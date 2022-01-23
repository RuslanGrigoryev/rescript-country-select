@react.component
let make = (~menuProps: Select.menuListProps, ~countriesListReference, ~chosenIndex) => {
  let itemHeight = 26 
  let selectedValues = menuProps.getValue()
  let initialIndex = selectedValues->Belt.Option.mapWithDefault(0, chosenIndex)
  let initialScrollOffset = initialIndex * itemHeight
  let itemCount = React.Children.count(menuProps.children)
  let childrenArray = React.Children.toArray(menuProps.children)
  <SelectVisibleItems
    height=menuProps.maxHeight 
    itemCount 
    itemSize=itemHeight 
    initialScrollOffset 
    ref={countriesListReference}
  >
    {
      props => <div style={props.style}> {childrenArray[props.index]} </div>
    }
  </SelectVisibleItems>
}
