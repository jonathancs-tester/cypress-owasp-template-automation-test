const { withId, template: templateFunc } = require('./selectors')

export default function ({ template } = { template: {} }) {
	return {
		//Begin your Project - Time Series Modelling
		"Forecast Horizon Slider": withId("input-slider-n-steps"),

		//User Selection
		"User Selection Slider": templateFunc(withId("slider-${name}"), template),
	}
}