const { withId } = require('./selectors')

export default {
	//Final Settings
	"Models Modal": withId("layout-container-div-faas"),
	"Data Processing Modal": withId("modalWarningOKButton"),
	"Feature Selection Modal": withId("featureSelectionOkBtn"),
	"Modeling Modal": withId("modalConclusionOkButton"),
	"Modeling Description Modal": withId("modal-modelling-conclusion-description"),
	"Lag Search Modal": withId("lagged-variables-modal-visible"),
	"Error Modal": withId("fail-modal"),
	
	//Fine Tunning - Time Series Modelling
	"Fine Tunning Modal": withId("advSettingsModalRenderization"),
	
	//Feature Store
	"Feature Store Groups Modal": withId("container-feature-store"),
}