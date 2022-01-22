/* Pure css with flags in background-image */
%%raw(`import 'flag-icon-css/css/flag-icon.min.css'`)

@react.component
let make = () => {
  let (country: option<string>, setCountryValue) = React.useState(_ => Some("us"))
  let onChange = countryValue => {
    setCountryValue(_ => countryValue)
    Js.log(countryValue)
  }

  <div className="app">
    { React.string("APP") }
  </div>
}
