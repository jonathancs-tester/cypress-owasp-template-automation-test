const { withIdAndSelector, template: templateFunc } = require('./selectors')

export default function ({ template } = { template: {} }) {
	return {
		"Calendar DatePicker": withIdAndSelector("datepicker-${name}", 'input'),
		"Previus Calendar DatePicker": withIdAndSelector("datepicker-${name}", '.react-datepicker__navigation--previous'),
		"Next Calendar DatePicker": withIdAndSelector("datepicker-${name}", '.react-datepicker__navigation--previous'),
		"Select Date Calendar DatePicker": "[class^=react-datepicker][class$=-text]",
	}
}