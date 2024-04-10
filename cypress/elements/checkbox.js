const { withId, template: templateFunc } = require('./selectors')

export default function ({ template } = { template: {} }) {
	return {
		"All Checkbox": withId("checkbox-"),
		"Select One Checkbox": withId("checkbox-${name}"),
	}
}