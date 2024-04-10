import {elementHasTextsCount, getSelectOptions,selectValue} from "../../../components/common"

const {
	And
} = require("cypress10-cucumber-preprocessor/steps");

And("check all elementary models texts {string}", (texts) => {
	getSelectOptions("Model List Variable Select").then((options) => {
		for(let option of options) {
			selectValue("Model List Variable Select", option)
			elementHasTextsCount("Model Info Info Type", texts.split(","), 0)
		}
	})
})
