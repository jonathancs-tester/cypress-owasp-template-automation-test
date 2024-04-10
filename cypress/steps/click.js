import {
	clickVariable,
	clickVariableByName,
	closeModal,
	openTab,
	setCheckboxValue,
} from "../components/common";

beforeEach(function(){
	this.template = {};
})

And(/I use "(.+)" as "(.+)" in template/, function (value, template) {
	if (!this.template) {
		this.template = {}
	}
	this.template[template] = value
})

And(/I click the "(.+)"/, function (id) {
	clickVariable(id, { template: this.template })
})

And(/I open the "(.+)"/, function (id) {
	openTab(id, { template: this.template });
})

And(/I click "(.+)" name in "(.+)"/, function(name, id){
	clickVariableByName(id, name);
})

And(/I set "(.+)" to (checked|unchecked|not set)/, function(id, value) {
	if(value != 'not set'){
		let checked = value === "checked"
		setCheckboxValue(id, checked, { template: this.template })
	}
})

And(/I close the "(.+)" if exists/, (id) => {
	closeModal(id);
})