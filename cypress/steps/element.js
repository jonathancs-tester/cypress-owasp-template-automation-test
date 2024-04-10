import {
	clickRefreshAndReturn,
	elementHasElement,
	elementIsEmpty,
	elementIsVisible,
	waitElementEnabled,
} from "../components/common";

And(/^I (can|can't) see element "(.+)"$/, function(value, id) {
	let canSee = value === "can"
	elementIsVisible(id, canSee, { template: this.template });
})

And(/^I can see element "(.+)" is (be|not be) empty$/, function (id, value) {
	let beEmpty = value === "be"
	elementIsEmpty(id, beEmpty, { template: this.template });
})

And(/I wait for element "(.+)" be (enabled|disabled)/, function(id, status) {
	const enabled = status === "enabled"
	waitElementEnabled(id, enabled, { template: this.template });
})

And(/I find "(.+)" in element "(.+)"/, (elementID, id) => {
	elementHasElement(id, elementID)
})
