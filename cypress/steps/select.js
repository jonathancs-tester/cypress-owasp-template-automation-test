import {   
	selectFrequency,
	selectValue,
	selectExactlyValue,
} from "../components/common"

And(/I select frequency "(original|monthly|quarterly|annual)" in "(.*)"/, (frequency, element) => {
	frequency = frequency.charAt(0).toUpperCase() + frequency.slice(1);
	let id = `${frequency} Frequency Radio`;

	selectFrequency(id, element)
})

And(/I select "(.+)" options in element "(.+)"/,function (value, id) {
	if(value!='do not set')
		selectValue(id, value, { template: this.template });
})

And(/I select "(.+)" options exactly in element "(.+)"/,function (value, id) {
	if(value!='do not set')
		selectExactlyValue(id, value, { template: this.template });
})

And(/I select list "(.*[^;])" options in element "(.+)"/, (list, id) => {
	const values = list.split(';')
	for (let value of values) {
		if(value!='do not set'){
			selectValue(id, value)	
		}	
	}
})

