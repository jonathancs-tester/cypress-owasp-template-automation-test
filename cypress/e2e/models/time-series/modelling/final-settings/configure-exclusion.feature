@CONFIGURE_EXCLUSION
@4INTELLIGENCE @UI @CREATEPROJECT @STEP3 @TIMESERIES @REGRESSION @MODELLING

Feature: Final Settings - Configure Exclusion

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@TS-500
	Scenario: Validation allows sending exclusions with 1 single variable.
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Massa_Com_Exclusao" text in element "Project Name Input"
		And I attach fixture "time-series/Mensal/dataset_massarenda.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "yyyy-MM-dd" options in element "Format Date Select"
		And I click the "Final Settings Button"
		When I click the "Fine Tunning Button"
		And I click the "Configure Exclusion Tab"
		And I select "massahabitual" options in element "Group 1"
		Then I wait for element "Fine Tunning Confirm Button" be disabled
