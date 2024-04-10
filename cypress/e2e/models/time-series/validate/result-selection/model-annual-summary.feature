@ANNUAL_SUMMARY
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: AI Selection/User Selection - Model and Annual Summary Info

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@TS-903
	Scenario Outline: Check Annual Summary info without forecast
        Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=aiselection]"
		And I wait for element "See More Information Button" be enabled
		And I click the "See More Information Button"
		When I can see element "Selected Model" is not be empty
		And I can see element "Sample Info Table" is not be empty
		And I can see element "Transformation Info Table" is not be empty
		And I can see element "MAPE Info Table" is not be empty
		And I can see element "WMAPE Info Table" is not be empty
		And I can see element "MPE Info Table" is not be empty
		And I can see element "RMSE Info Table" is not be empty
		And I can see element "MASE Info Table" is not be empty
		And I can see element "MASEs Info Table" is not be empty
		Then I can see text "Level" in element "Annual Summary Card"
		And I can see text "Variation" in element "Annual Summary Card"
		And I can't see element "Forecast Legend Table"

        Examples:
			 | ProjectName      			| 
			 | ui_fs_mensal_sanity_1  		| 
			 | trimestral_sanity			|
			 | quinzenal_sanity				| 

	@TS-903
	Scenario Outline: Check Annual Summary info with forecast
        Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=aiselection]"
		And I wait for element "See More Information Button" be enabled
		And I click the "See More Information Button"
		When I can see element "Selected Model" is not be empty
		And I can see element "Sample Info Table" is not be empty
		And I can see element "Transformation Info Table" is not be empty
		And I can see element "MAPE Info Table" is not be empty
		And I can see element "WMAPE Info Table" is not be empty
		And I can see element "MPE Info Table" is not be empty
		And I can see element "RMSE Info Table" is not be empty
		And I can see element "MASE Info Table" is not be empty
		And I can see element "MASEs Info Table" is not be empty
		Then I can see text "Level" in element "Annual Summary Card"
		And I can see text "Variation" in element "Annual Summary Card"
		And I can see element "Forecast Legend Table"

        Examples:
			 | ProjectName      			| 
			 | semanal_sanity				| 
			 | dat_temp_more_dates			|	

	Scenario Outline: Check error in Annual Summary info
        Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=aiselection]"
		And I wait for element "See More Information Button" be enabled
		And I click the "See More Information Button"
		Then I can see element "Selected Model" is not be empty
		And I can see element "Sample Info Table" is not be empty
		And I can see element "Transformation Info Table" is not be empty
		And I can see element "MAPE Info Table" is not be empty
		And I can see element "WMAPE Info Table" is not be empty
		And I can see element "MPE Info Table" is not be empty
		And I can see element "RMSE Info Table" is not be empty
		And I can see element "MASE Info Table" is not be empty
		And I can see element "MASEs Info Table" is not be empty
		And I can see text "Annual series summary is only available for series with at least 1 year of observation." in element "Annual Summary Card"

        Examples:
			| ProjectName      |
			| ts135_diario     | 

    @USERSELECTION
    Scenario: Check User Selection page accessing a project for the first time
		Given I write "sanity_mensal" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=sanity_mensal;position=first]"
		And I click the "Menu Model Explorer[index=userselection]"
        And I wait for element "See More Information Button" be enabled
		And I click the "See More Information Button"
        Then I can see element "Best Model Info Table"
		And I click the "Best Model Info Table"