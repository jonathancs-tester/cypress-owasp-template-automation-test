const { withId, withIdAndSelector } = require('./selectors')

export default {
	"Dependent Variable Select": '[data-cy="dependent-variable"] .select__control',
	"Model List Variable Select": '[data-cy="n.-on-the-list"] .select__control',
	"Data Results Select": '[id="ai-selection-results-select"] .select__control',
	"Projection os Explanatory Variables Select": '[data-cy="variable"] .select__control',
	
	//Select Variables - Time Series Modelling
	"Format Date Select": withId("format"),
	"Selected Model": withId("selected-model"),
	"Response Variable Select": withId("response-variable"),
	"Explanatory Variable Select": withId("explanatory-variables"),
	"Show Variables Data View Select": withId("show-n-variables"),
	
	//Fine Tunning - Time Series Modelling
	"Accuracy Criteria Select": withId("accuracy-criteria"),
	"Cross Validation Summary Select": withId("cross-validation-summary"),
	"Group 1": withIdAndSelector("group-1",".select__control"),
	"Group 2": withIdAndSelector("group-2",".select__control"),
	"Group 3": withIdAndSelector("group-1",".select__control"),
	"Golden Variable Select": withId("golden-variables"),

	//Feature Store
	"Region Serie Select": withId("region"),
	"Frequency Serie Select": withId("frequency"),
	"Primary Transformation Serie Select": withId("primary-transformation"),
	"Secondary Transformation Serie Select": withId("secondary-transformation")
}