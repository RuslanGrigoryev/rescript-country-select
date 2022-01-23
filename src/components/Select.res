%%raw(`import './../styles/country-prfx.css'`)

/*
  Extend react-select
*/
@decco
type countryItem = {
  label: string,
  value: string,
}

@decco
type countryItems = array<countryItem>

@as("ActionTypes")
type actionTypes =
  SELECT_OPTION | DESELECT_OPTION | REMOVE_VALUE | POP_VALUE | SET_VALUE | CLEAR | CREATE_OPTION

@as("ClassNamesState") type classNamesState = {key: bool}

type rSelectItemProps = {
  cx: (~state: option<classNamesState>, ~className: option<string>) => string,
  getStyles: (~name: string, ~props: Js.Dict.t<string>) => unit,
  getValue: unit => option<countryItem>,
  isMulti: bool,
  options: countryItems,
  selectOption: (~option: countryItem) => unit,
  setValue: (~value: countryItem, ~action: actionTypes) => unit,
  selectProps: Js.Dict.t<string>,
  theme: Js.Dict.t<string>,
  innerProps: Js.Dict.t<string>,
  data: Js.Dict.t<string>,
  label: string,
  type_: string,
  value: string,
  innerRef: unit => unit,
  isFocused: bool,
  children: React.element,
  maxHeight: int,
}

type menuListProps = {
  options: countryItems,
  children: React.element,
  maxHeight: int,
  getValue: unit => option<array<countryItem>>,
}

type rSelectItem = rSelectItemProps => React.element
type rSelect = rSelectItemProps => React.element
type renderList = menuListProps => React.element
type rDropdownIndicator = () => React.element
type rIndicatorSeparator = () => React.element

/* rewrite react select components https://react-select.com/components */
type reactSelectComponents = {
  @as("Option") rSelectItem: rSelectItemProps => React.element,
}

type components = {
  @as("Option") rSelectItem: rSelectItem,
  @as("MenuList") renderList: renderList,
  @as("DropdownIndicator") rDropdownIndicator: rDropdownIndicator,
  @as("IndicatorSeparator") rIndicatorSeparator: rIndicatorSeparator,
}

type defaultMenuIsOpen = bool
type autoFocus = bool
type defaultInputValue = string
type placeholder = string
type onBlur = () => unit
type classNamePrefix = string

@module("react-select") external reactSelectComponents: reactSelectComponents = "components"

@module("react-select") @react.component
external make: (
  ~options: countryItems,
  ~onChange: option<countryItem> => unit,
  ~components: components,
  ~defaultMenuIsOpen: defaultMenuIsOpen,
  ~autoFocus: autoFocus,
  ~placeholder: placeholder,
  ~defaultInputValue: defaultInputValue,
  ~onBlur: onBlur,
  ~classNamePrefix: classNamePrefix
) => React.element = "default"
