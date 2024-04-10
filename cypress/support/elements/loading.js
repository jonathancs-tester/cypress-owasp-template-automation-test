const { withId } = require('./selectors')

export default {
	"Loading": withId("loading"),
	"Annual Summary Loading": withId("annual-summary-container-loading"),
	"Potential Outliers Loading": withId("div-loading-potential-outliers"),
	"Loading Test": `[data-testid~="loading"]`
}