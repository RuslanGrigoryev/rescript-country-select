/* Pure css with flags in background-image */
%%raw(`import 'flag-icon-css/css/flag-icon.min.css'`)
%%raw(`import './styles/country-select.css'`)

@react.component
let make = () => {
  let (country: option<string>, setCountryValue) = React.useState(_ => Some("us"))
  let onChange = countryValue => {
    setCountryValue(_ => countryValue)
    Js.log(countryValue)
  }

  <div className="app">
    <CountrySelect
      className="country-select"
      country=?{country}
      onChange={onChange}
    />
  </div>
}
