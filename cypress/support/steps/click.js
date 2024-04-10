import {
	clickVariable,
	clickVariableByName,
	setCheckboxValue,
	closeModal,
	openTab
} from "../pageobjects/common"

And(/I use "(.+)" as "(.+)" in template/, function (value, template) {
	if (!this.template) {
		this.template = {}
	}
	this.template[template] = value
})

And(/I click the "(.+)"/, function (id) {
	clickVariable(id, { template: this.template });
})

And(/I open the "(.+)"/, function (id) {
	openTab(id, { template: this.template });
})

And(/I click "(.+)" name in "(.+)"/, function(name, id){
	clickVariableByName(id, name);
})

And(/I set "(.+)" to (checked|unchecked)/, (id, value) => {
	let checked = value === "checked"
	setCheckboxValue(id, checked)
})

And(/I close the "(.+)" if exists/, (id) => {
	closeModal(id);
})