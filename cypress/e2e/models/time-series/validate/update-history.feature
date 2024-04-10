@UPDATE_HISTORY
@4INTELLIGENCE @UI @CREATEPROJECT @REGRESSION @TIMESERIES
Feature: Update History

	Background: Login
		Given insert "admin" credentials and login via "MFA"

	@SANITY	
	Scenario: Check Update History
		And access main page			
		And access "Models" application
		And find "All_Mensal_MU_lag" project
		And click to "All_Mensal_MU_lag" Model Explorer
		And check if "You are viewing Update" message is visible
        And I wait for element "Project Menu" be enabled
		When I click the "Project Menu"
        And I wait for element "Update history" be enabled
        And I click the "Update history"
        Then check if there are an update in project
        And click in first update
        And check if "You are viewing Update 1" message is visible

	Scenario: Check Update History
		And access main page			
		And access "Models" application
		And find "duplicate_base_mdias_dataset_70y" project
		And click to "duplicate_base_mdias_dataset_70y" Model Explorer
		And check if "You are viewing Update" message is visible
        And I wait for element "Project Menu" be enabled
		When I click the "Project Menu"
        And I wait for element "Update history" be enabled
        And I click the "Update history"
        Then the update and orignal date should not be equal

	@SANITY
	Scenario: Check Share Update History
		And search "teste_mdias_dataset_70y" id in response API
		And create duplicate project with "@projectID", "view" user and "success" response
		And access main page			
		And access "Models" application
		And find "teste_mdias_dataset_70y" project
		And click to "teste_mdias_dataset_70y" Model Explorer
		And check if "You are viewing Update" message is visible
        And I wait for element "Project Menu" be enabled
		When I click the "Project Menu"
        And I wait for element "Update history" be enabled
        And I click the "Update history"
		And click in first share
		And insert "view" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		And find "teste_mdias_dataset_70y" project
		And click to "teste_mdias_dataset_70y" Model Explorer
		And check if "You are viewing Update" message is visible
        And I wait for element "Project Menu" be enabled
		When I click the "Project Menu"
        And I wait for element "Update history" be enabled
        And I click the "Update history"
        Then check if there are an update in project
