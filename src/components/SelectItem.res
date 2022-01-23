%%raw(`import './../styles/country-value.css'`)

@react.component
let make = (~itemProps: Select.rSelectItemProps, ~onScroll) => {
  React.useEffect3(() => {
    if itemProps.isFocused {
      onScroll(itemProps.value)
    }
    None
  }, (itemProps.value, itemProps.isFocused, onScroll))

  let children =
    <div className="country">
      <span className={`country__flag flag-icon flag-icon-${itemProps.value}`}></span>
      <span className="country__name"> {React.string(itemProps.label)} </span>
    </div>

  Select.reactSelectComponents.rSelectItem({
    ...itemProps, children: children
  })
}
