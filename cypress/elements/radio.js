const { withId, template: templateFunc } = require('./selectors')

export default function ({ template } = { template: {} }) {
	return {
		"Original Frequency Radio": withId("radio-original-container"),
		"Monthly Frequency Radio": withId("radio-monthly-container"),
		"Quarterly Frequency Radio": withId("radio-quarterly-container"),
		"Annual Frequency Radio": withId("radio-annual-container"),
		"Filter Radio": withId("radio-${name}-container"),
	}
}