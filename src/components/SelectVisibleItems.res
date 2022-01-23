/* extend react-window (new gen of react-virtualized)*/

type childrenFunctionProps = {
  index: int,
  style: ReactDOM.style,
}

type childrenFunction = childrenFunctionProps => React.element

type listEl = {scrollToItem: (. int) => unit}

@module("react-window") @react.component
external make: (
  ~height: int,
  ~itemCount: int,
  ~itemSize: int,
  ~initialScrollOffset: int,
  ~ref: React.ref<Js.Nullable.t<listEl>>,
  ~children: childrenFunction,
) => React.element = "FixedSizeList"
