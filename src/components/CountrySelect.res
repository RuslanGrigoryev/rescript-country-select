@react.component
let make = (
  ~className: option<string>=?,
  ~country: option<string>=?,
  ~onChange,
) => {
  let api = "https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json"
  let countriesListReference = React.useRef(Js.Nullable.null)
  let (isSelectVisible: bool, setSelectVisibility) = React.useState(_ => false);
  let (countriesList: array<Select.countryItem>, setCountriesList) = React.useState(_ => [])

  /* Fetch countries data */
  React.useEffect2(() => {
    let _ =
      Fetch.fetch(api)
      ->Js.Promise.then_(Fetch.Response.json, _)
      ->Js.Promise.then_(arr => {
        switch Select.countryItems_decode(arr) {
        | Ok(data) => setCountriesList(_ => data)
        | Error(_) => Js.log("Error while fetching data from api url: " ++ api)
        }
        Js.Promise.resolve()
      }, _)
      ->Js.Promise.catch(_ => {
        Js.Promise.resolve()
      }, _)

    None
  }, (Js.Nullable.null, setCountriesList))

  let countryItem = switch country {
    | Some(country) => Js.Array.find((c: Select.countryItem) => c.value == country, countriesList)
    | None => None
  }

  /* scroll to chosen item */
  let onScroll = item => {
    let index = Js.Array.findIndex(
      (c: Select.countryItem) => c.value == item,
      countriesList,
    )

    countriesListReference.current
    ->Js.Nullable.toOption
    ->Belt.Option.forEach((listEl: SelectVisibleItems.listEl) => listEl.scrollToItem(. index))
  }

  /* Define default country for countries list */
  let chosenIndex = (selectedValues: array<Select.countryItem>) => {
    switch selectedValues {
    | [] => 0
    | selectedValues => {
        Js.Array.findIndex(
          (country: Select.countryItem) => country.value == selectedValues[0].value,
          countriesList,
        )
      }
    }
  }

  /* Do not show react-select dropdown indicator */
  let rDropdownIndicator = () => React.null

  /* Do not show react-select indicator separator */
  let rIndicatorSeparator = () => React.null

  /* Rewrite react-select item */
  let rSelectItem = itemProps => {
    <SelectItem itemProps onScroll />
  }

  /* Rewrite react-select list */
  let renderList = menuProps => {
    <SelectList menuProps countriesListReference chosenIndex />
  }

  /* Toggle click by select */
  let onClick = (_) => {
    setSelectVisibility(_ => !isSelectVisible)
  };

  switch isSelectVisible {
    | false => <div ?className><SelectControl
        item=?countryItem
        onClick=onClick
        isSelectVisible=isSelectVisible
      /></div>
    | true => <>
      <div ?className><SelectControl
        item=?countryItem
        onClick=onClick
        isSelectVisible=isSelectVisible
      /></div>
        <Select
          options=countriesList
          defaultMenuIsOpen=true
          defaultInputValue=""
          placeholder="Search"
          autoFocus=true
          onBlur={_ => {
            setSelectVisibility(_ => false)
          }}
          components={
            { rSelectItem, renderList, rDropdownIndicator, rIndicatorSeparator }
          }
          onChange={country => {
            let countryCode = switch country {
            | Some(country) => Some(country.value)
            | None => None
            }
            onChange(countryCode)
            setSelectVisibility(_ => !isSelectVisible)
          }}
          classNamePrefix="cs-prfx"
        />
    </>
  }
}
