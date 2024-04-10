import charts from "../components/charts"

const Charts = new charts

And("I check Unit of {string} chart", (id) => {
	Charts.checkChartsUnit(id);
})

And("I check values in x axis of {string} chart", (id) => {
	Charts.checkXaxisValues(id);
})

And("I check values in y axis of {string} chart", (id) => {
	Charts.checkYaxisValues(id);
})