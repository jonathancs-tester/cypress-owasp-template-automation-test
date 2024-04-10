const { withId } = require('./selectors')

export default {
	//Final Seeting - Time Series Modelling
	"Custom Period Toggle": withId("toggle-switch-custom-period"),
	
	//Fine Tunning - Time Series Modelling
	//Additional Configuration
	"Apply Log Toggle": withId("toggle-switch-apply-log"),
	"Add Seasonal Dummies Toggle": withId("toggle-switch-add-seasonal-dummies"),
	//Explanatory Features
	"Avoid Collinearity Toggle": withId("toggle-switch-explanatory-avoid-collinearity"),
	"Explanatory Variables Auto - Forecast Toggle": withId("toggle-switch-explanatory-variables"),
	"Allow Drift Toggle": withId("toggle-switch-drift"),
	//Feature Selection
	"Lasso Toggle": withId("toggle-switch-feature-avoid-collinearity"),
	"Random Forest Toggle": withId("toggle-switch-random-forest"),
	"Correlation Filter Toggle": withId("toggle-switch-correlation-filter")
}