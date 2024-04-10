const { withId } = require('./selectors')

export default {
	"Lag Number Input": withId("input-lag-number"),
	//Begin you Project - Time Series Modelling
	"Project Name Input": withId("Project-Name"),
	"Upload File Input": withId("input-file"),
	//Fine Tunning - Time Series Modelling
	"Cross Validation Input": withId("No.-of-Cross-Validation-Test-Sets-(n_windows)"),
	"Error Validation Icon Input": withId("icon_input_error_validation"),

	//******************************************************************

	//Feature Store
	"Group Search Input": withId("input-search-group"),
	"Indicator Search Input": withId("input-search-indicator"),
	"Group Name Input": withId("input-group-name"),
	"Group Description Input": withId("input-group-description"),
	"Search Indicators Input": withId("input-search-indicator"),
	"Delete Group Input": withId("input-delete-group")
}