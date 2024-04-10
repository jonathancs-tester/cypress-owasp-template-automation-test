@FEATURE_SELECTION
@4INTELLIGENCE @UI @CREATEPROJECT @STEP3 @TIMESERIES @REGRESSION @MODELLING

Feature: Final Settings - Feature Selection
	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	Scenario: Check at least one mandatory Feature Selection option.
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "dataset_mensal_fake_1" text in element "Project Name Input"
		And I attach fixture "time-series/Mensal/dataset_fs_mensal_fake_1.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I click the "Final Settings Button"
		And I can see element "Custom Period Toggle"
		And I close the "Feature Selection Modal" if exists
		And I close the "Data Processing Modal" if exists
		When I click the "Fine Tunning Button"
		And I click the "Feature Selection Tab"
		And I set "Lasso Toggle" to unchecked
		And I set "Random Forest Toggle" to unchecked
		And I set "Correlation Filter Toggle" to unchecked
		And I select "abpo" options in element "Golden Variable Select"
		Then I can see text "Select at least one method." in element "Fine Tunning Modal"
		And I can see text "Setting golden variables may hinder final accuracy results. The impacts are stronger the more golden variables you choose." in element "Fine Tunning Modal"
	
	Scenario: Check all Feature Selection options disabled.
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Massa_Com_Exclusao" text in element "Project Name Input"
		And I attach fixture "time-series/Mensal/dataset_massarenda.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "yyyy-MM-dd" options in element "Format Date Select"
		And I click the "Final Settings Button"
		When I click the "Fine Tunning Button"
		And I click the "Feature Selection Tab"
		Then I wait for element "Lasso Toggle" be disabled
		And I wait for element "Random Forest Toggle" be disabled
		And I wait for element "Correlation Filter Toggle" be disabled
