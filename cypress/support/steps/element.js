import { 
	elementIsVisible, 
	waitElementEnabled,
	elementHasElement, 
} from "../pageobjects/common"

And(/I (can|can't) see element "(.+)"/, (value, id) => {
	let canSee = value === "can"
	elementIsVisible(id, canSee);
})

And(/I can see element "(.+)" is (be|not be) empty/, (value, id) => {
	let beEmpty = value === "be"
	elementIsEmpty(id, beEmpty);
})

And(/I wait for element "(.+)" be (enabled|disabled)/, (id, status) => {
	const enabled = status === "enabled"
	waitElementEnabled(id, enabled);
})

And(/I find "(.+)" in element "(.+)"/, (elementID, id) => {
	elementHasElement(id, elementID)
})