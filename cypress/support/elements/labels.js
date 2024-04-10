const {withIdAndSelector, withId} = require('./selectors')

export default {
	"Results Cards Label": `${withIdAndSelector("primary-results-card-", "h4")},${withIdAndSelector("secondary-results-card-", "h4")}`,
	"Correlation Matrix Label": withId("li-labelcorrelationmatrix"),
	"Results Waterfall Labels": withIdAndSelector("results-waterfall-container", ".highcharts-xaxis-labels"),
	"Model Explorer Elementary Label": withId("li-labelelementary"),
	"Model Explorer Elementary Model Specifics Label": withId("li-labelmodelspecifics")
}