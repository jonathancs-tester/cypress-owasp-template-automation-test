const { withId, withIdAndSelector } = require('./selectors')

export default {
	//User Selection
	"Best Model Info Table": `${withId("selected-model")}`,
	"Sample Info Table": `${withId("selected-model-sample")}`,
	"Transformation Info Table": `${withId("selected-model-transformation")}`,
	"MAPE Info Table": `${withId("selected-model-mape")}`,
	"WMAPE Info Table": `${withId("selected-model-wmape")}`,
	"MPE Info Table": `${withId("selected-model-mpe")}`,
	"RMSE Info Table": `${withId("selected-model-rmse")}`,
	"MASE Info Table": `${withId("selected-model-mase")}`,
	"MASEs Info Table": `${withId("selected-model-mases")}`,

	"Annual Summary Level Table": withIdAndSelector("annual-summary-container", "tr:nth-child(1) span"),
	"Annual Summary Variation Table": withIdAndSelector("annual-summary-container", "tr:nth-child(2) span"),
}