const {  withId, template: templateFunc } = require('./selectors')

export default function ({ template } = { template: {} }) {
	return {
		"Potential Impacts See More Impacts Button": withId("potential-impacts-button-see-more"),
		"Potential Impacts Modal Close Button": withId("potential-impacts-modal-button-close"),
		"Selected Model Production Button": withId("button-send-to-production"),
		"Understanding Results Waterfall Button": withId("results-understanding-button-waterfall"),
		"Visualize Data Button": withId("button-visualize-data"),
		"Confirm Lags Button": withId("button-confirm-lags"),
		"Add Lags Button": withId("button-add-lags"),
		"QOQ Tab Button": withId("button-tab-qoq"),
		"YOY Tab Button": withId("button-tab-yoy"),
		"Send to Production Classification": withId("button-send-to-production"),
		"Send to User Selection Button": withId("button-send-to-production"),
		"See More Information Button": withId("button-see-more-information"),
		"Type Historical Data Graph Bar Button": withId("button-bar"),
		"Type Historical Data Graph Line Button": withId("button-line"),
		"Delete Explanatory Variables Button": withId("button-delete-explanatory-variables"),

		// My Projects
		"Create Project Button": withId("button-create-project"),
		"Time Series Menu": withId("select-time-series-button"),
		"Classification Menu": withId("select-classification-button"),
		"Begin Your Project Button": withId("button-submit-modeling-type"),

		//Begin your Project - Time Series Modelling
		"See Requirements Button": withId("button-see-requirements"),
		"Select Variables Button": withId("button-select-variables"),

		//Select Variables - Time Series Modelling
		"Final Settings Button": withId("button-final-settings"),
		"Download Dataset Button": withId("download-dataset"),
		"Add Feature Store Button": withId("button-add-variables"),
		"Choose Variables(s) Lags Button": withId("choose-variable(s)"),
		"Cancel Lags Button": withId("button-cancel-lags"),
		"Variable Importance Data View Button": withId("li-labelvariableimportance"),
		
		//Final Settings variables - Time Series Modelling
		"Modeling Button": withId("button-modeling"),

		//Fine Tunning - Time Series Modelling
		"Additional Configuration Tab": withId("button-tab-additional-configuration"),
		"Ranking Criteria Tab": withId("button-tab-ranking-criteria"),
		"Explanatory Features Tab": withId("button-tab-explanatory-features"),
		"Configure Exclusion Tab": withId("button-tab-configure-exclusion"),
		"Feature Selection Tab": withId("button-tab-feature-selection"),

		"Fine Tunning Button": withId("button-advanced-options"),
		"Fine Tunning Confirm Button": withId("button-modal-advanced-ok"),
		"Fine Tunning Cancel Button": withId("button-modal-advanced-cancel"),

		//User Selection
		"Restore Simulation Button": withId("restore-simulation"),
		"Send Simulation Button": withId("send-simulation"),

		//******************************************************************

		//Feature Store
		"Search FS Button": withId("li-select-search"),
		"Favorites Button": withId("li-select-favorites"),
		"My Favorites Button": withId("li-select-my-favorites"),
		"My Favorites Tab": withId("button-tab-my-favorites"),
		"4I Favorites Button": withId("li-select-4i-favorites"),
		"4I Favorites Tab": withId("button-tab-4i-favorites"),
		"Premium Group Button": withId("li-select-group-premium"),
		"Search Indicatiors Button": withId("button-search-indicators"),

		"Feature Store Variables Button": withId("feature-store-variables-button-open"),
		"Feature Store Variable New Tab Button": templateFunc(withId("feature-store-variable-card-link-${name}"), template),

		"Sub Category FS Menu": withId("sub-category-"),
		"Group Card Menu": templateFunc(withId("button-menu-${name}-${browser}"), template),
		"Group Card Delete Menu": templateFunc(withId("menu-button-delete-${name}-${browser}"), template),	

		"Send to Group Button": withId("button-send-to-group"),
		"Export Button": withId("button-export"),
		
		"Go to Group Button": withId("button-go-to-group"),
		"Create New Group Button": withId("button-create-group"),
		"Create New Group Confirm Button": withId("create-group-confirm-button"),

		"Pick4me Button": withId("button-start-pick-for-me"),
	}
}