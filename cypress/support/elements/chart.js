const { withId, withIdAndSelector } = require('./selectors')

export default {
	"Potential Impacts Chart": withId("potential-impacts-chart"),
	"Potential Impacts Modal Chart": withId("potential-impacts-modal-chart"),
	"Result Container Chart": withId("result-container-chart"),

	//Data View
	"Correlation Matrix Chart": withId("div-chart-correlation-matrix"),
	"Correlation Chart": withId("chart-correlation"),
	"Correlation Chart Bar Layer": withIdAndSelector("chart-correlation", ".barlayer"),

	"Variable Importance Chart": withId("chart-check-residual-2"),
	"Variable Importance Chart Scatter Layer": withIdAndSelector("chart-check-residual-2", ".scatterlayer"),
	"Variable Importance Chart Bar Layer": withIdAndSelector("chart-check-residual-2", ".barlayer"),
	"Variable Importance Chart Y Name": withIdAndSelector("chart-check-residual-2", ".ytick"),

	"STL Decomposition Chart": withId("chart-stl-decompostion"),

	"Unit chart": withId("unit-chart"),
	"Error Correlation Matrix Chart": withId("container-error-correlation-matrix"),
	"Error Mensage Potential Impacts Chart": withId("potential-impacts-chart-error"),
	"Error Mensage Explanatory Variables Chart": withId("explanatory-variables-chart-error"),
	"Historical Data Graph Chart": withId("chart-transformations"),
	"Chart Dependent Variables": withId("chart-dependent-variables"),

	// Final Settings
	"Historical Forecast Chart": withId("container-chart-historical-forecast"),

	//Model Breakdown - Arima Specifics
	"Model Breakdown Chart": withId("model-breakdown-tabs"),
	"Model Breakdown HighChart": withId("breakdown-chart"),
	"Model Breakdown Error HighChart": withId("breakdown-error"),
	"Model Breakdown MoM Chart Bar Layer": withIdAndSelector("chart-model-breakdown-mom", ".barlayer"),
	"Model Breakdown MoM HighChart Bar Layer": withIdAndSelector("breakdown-chart", ".highcharts-column-series"),
	"Model Breakdown MoM Chart Scatter Layer": withIdAndSelector("chart-model-breakdown-mom", ".scatterlayer"),
	"Model Breakdown MoM HighChart Scatter Layer": withIdAndSelector("breakdown-chart", ".highcharts-line-series"),

}