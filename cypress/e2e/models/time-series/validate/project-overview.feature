@PROJECTOVERVIEW
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Project Overview

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @TS-3 @V3.2
	Scenario: Check Model In Production info for Product Overview
		And find "ML02-15Y-Dataset-All-Sanity_with_error" project
		And click to "ML02-15Y-Dataset-All-Sanity_with_error" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "10" options in element "Model List Variable Select"
		And select "com_s" dependent variable
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		And access to "projectoverview" menu in Model Explorer "time series" model
		When get "MAPE" value of the "forecast_4_com_s"
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "25" options in element "Model List Variable Select"
		And select "com_s" dependent variable
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		And access to "projectoverview" menu in Model Explorer "time series" model
		Then compare "MAPE" value of the "forecast_4_com_s"
	
	@V3.2 @TS-4 @TS-2 @TS-1 @TS-104 @TS-111 @TS-134
	Scenario: Check Depedent variable chart maximum plot 4 models
		And find "ML02-15Y-Dataset-All-Sanity_with_error" project
		And click to "ML02-15Y-Dataset-All-Sanity_with_error" Model Explorer
		And get "MAPE" value of the "com_se"
		And check '12' variables in Project Summary
		When click to show "com_mw" model in depedent variable chart
		And it should be not show the depedent variable chart with "not select" message
		When click to show "com_mw" model in depedent variable chart
		And show the "com_mw" in chart with "2" lines
		When click to show "com_n" model in depedent variable chart
		And show the "com_n" in chart with "4" lines
		And click to show "com_s" model in depedent variable chart
		And show the "com_s" in chart with "6" lines
		And click to show "com_se" model in depedent variable chart
		And show the "com_se" in chart with "8" lines
		Then it should be not to click "ind_mw" model in depedent variable chart
		And click to download export project and check "ind_mw" variables

	@TS-8 @V3.2
	Scenario Outline: Check if projects with one Y do not have Project Overwview
		And find "<ProjectName>" project
		When click to "<ProjectName>" Model Explorer
		Then the menu button "projectoverview" should not be visible

			Examples:
			| ProjectName           	|
			| ML02-15Y-With-1Y-Success  |
			| Sanity_Mensal				|

	@TS-5 @V3.2
	Scenario: Check if possible to customize values your table
		And find "ML02-15Y-Dataset-All-Sanity_with_error" project
		And click to "ML02-15Y-Dataset-All-Sanity_with_error" Model Explorer
		When click in Customize your Table
		And select 'Model' value in Customize your Table
		Then check if exists 'Model' value in Customize your Table

	@V3.2 @TS-7 @TS-145 
	Scenario: Change the variable name
		And find "ML02-15Y-Dataset-All-Sanity_with_error" project
		And click to "ML02-15Y-Dataset-All-Sanity_with_error" Model Explorer
		When click in Rename Variables
		Then change your "ind_mw" variable to "variable as-çãÀáâ"
		And check if variable "ind_mw" change the name to "variable as-çãÀáâ"
		And click to download export project and check "variable as-çãÀáâ" variables
		And click in Rename Variables
		And change your "ind_mw" variable to "ind_mw"
		And check if variable "ind_mw" change the name to "ind_mw"

	@V3.4 @TS-101 
	Scenario Outline: Check projections table
		And find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		Then check the projections table with "<Frequency>"
		And click to download export project and check "<Variables>" variables

		Examples:
			| ProjectName           							|   Frequency  	| Variables |
			| ML16-All-Dataset-Diario   						|	daily		| fluxo_dia	|
			| ML02-15Y-Dataset-All-Sanity_with_error			|	monthly		| com_s		|

	@TS-454 @TS-422
	Scenario Outline: Close model when back the project
	   Given find "<ProjectName>" project
	   And click to "<ProjectName>" Model Explorer
	   When I can see only one of following text "Project Overview" in element "Project Overview Title"
	   And I refresh and wait for element "Project Name Container" and return to previous page
	   Then i can see only one of following text "My Projects" in element "My Projects Modal"

       Examples:
			| ProjectName						| 
			| Dataset-Diario_170_mixed_obser	| 

	@TS-448
	Scenario Outline: Check Dependent Variables table 
		And find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When i click in element "Search Dependent Variables" search for "<Variables>"
		And I click the "Select or Deselect Variables Button"
		And i clear element "Search Dependent Variables"
		Then I can see text "<Variables>" in element "Chart Dependent Variables"

       Examples:
			| ProjectName								| Variables |
			| ML02-15Y-Dataset-All-Sanity_with_error	| ind_n     |