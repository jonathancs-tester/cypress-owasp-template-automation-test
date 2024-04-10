const { withId, template: templateFunc } = require('./selectors')

export default function ({ template } = { template: {} }) {
	return {
		"Slider": templateFunc(withId("slider-${name}"), template),
	}
}