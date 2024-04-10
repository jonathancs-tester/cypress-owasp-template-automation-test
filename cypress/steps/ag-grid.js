import {
	scrollHorizontalToColElement,
} from "../components/ag-grid"

And(/I move horizontal scroll to "(.+)"/, function (value) { 
	scrollHorizontalToColElement(value)
})
