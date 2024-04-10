const { withId, template: templateFunc } = require('./selectors')

export default function ({ template } = { template: {} }) {
	return {
		"Selected Frequency Text": withId("selected-frequency"),
		"Selected Latest Data Text": withId("selected-latest-data"),
		"Selected Transformation Text": withId("selected-transformation"),
		"Selected Forecast Text": withId("selected-forecast"),
		"Selected Inflation Text": withId("selected-inflation"),
	}
}