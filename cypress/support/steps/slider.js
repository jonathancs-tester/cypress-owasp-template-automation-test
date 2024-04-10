import {
	changeStepSlider,
	changeBeforeAfterSlider
} from "../components/slider"

And(/I change the step to ([0-9]+) on the "(.+)" slider element/, function (value,id) { 
	changeStepSlider(value, id, { template: this.template })
})

And(/I change the value to "(.+)" from "(.+)" on the "(.+)" slider element/, (before,after,id) => {
	changeBeforeAfterSlider(before,after,id)
})
