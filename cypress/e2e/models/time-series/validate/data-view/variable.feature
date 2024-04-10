@DATAVIEW_VARIABLE
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION 
Feature: Data View Variable

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY
    Scenario: Check Variable importance
        And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Sanity_Mensal" text in element "Project Name Input"
		And I attach fixture "time-series/Mensal/dataset_mensal_fake_3.xlsx" in element "Upload File Input"
		And I can see element "Select Variables Button"	
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "do not set" options in element "Format Date Select"
		And I can see element "Visualize Data Button"
		When I click the "Visualize Data Button"
		And I click the "Variable Importance Data View Button"
		And I select "4" options in element "Show Variables Data View Select"
		Then I can see element "Variable Importance Chart Bar Layer"
		And I can see element "Variable Importance Chart Scatter Layer"
		And I should see is "equal to" 4 items of "Variable Importance Chart Y Name"
	   	 
	Scenario Outline: Check variables and lags should be visible in data view
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "do not set" options in element "Format Date Select"
		And I can see element "Add Lags Button"
		When I click the "Add Lags Button"
		And I write "<lag_number>" text in element "Lag Number Input"
		And I select "Select all" options in element "Choose Variables(s) Lags Button"
		And I can see element "Confirm Lags Button"
		When I click the "Confirm Lags Button"
		And I can see element "Visualize Data Button"
		And I click the "Visualize Data Button"
		And I click the "Variable Importance Data View Button"
		Then I can see text list "<variable>" in element "Variable Importance Chart"		

		Examples:
			| ProjectName          | lag_number | dataset                   			 | variable   |
			| FS_Diario_Download_1 | 7          | time-series/dataset_diario_fake_1.xlsx | l2_;l1_;l7_|

  	Scenario Outline: Check errors messages in Variable importance
        And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "do not set" options in element "Format Date Select"
		And I can see element "Visualize Data Button"
		When I click the "Visualize Data Button"
		And I click the "Variable Importance Data View Button"
		Then I can see text "<errors>" in element "Variable Importance Error Card"     

	   Examples:
            |	ProjectName			| dataset                   								|  errors        						 			|
		    |	NoExploratory_Sanity| time-series/no_explanatory_variables.xlsx         		| No explanatory variables selected     			|
			|	Only_Dummies		| time-series/dataset_semestral_fake_1_so_dummy-step2.xlsx  | All selected explanatory variables are dummies	| 
