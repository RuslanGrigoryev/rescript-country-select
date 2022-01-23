@react.component
let make = (~item: option<Select.countryItem>=?, ~onClick, ~isSelectVisible: bool) => {
  let className = switch isSelectVisible {
  | false => "control"
  | true => "control active"
  }

  <div 
    className=className
    onClick
  >
    {switch item {
    | Some(item) => React.string(item.label)
    | None => React.string("")
    }}
  </div>
}
