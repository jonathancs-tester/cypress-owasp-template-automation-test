@VARIABLE_PERFORMANCE
@4INTELLIGENCE @UI @REGRESSION @TIMESERIES
Feature: Variable Performance in Time Series

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@CS-285
	Scenario Outline: Check Variation of projections
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=variableperformance]"
		And I can see element "Forecast Variation Chart"
		And I can see text "Historical Data" in element "Forecast Variation Chart"
		And I can see text "Original Forecast" in element "Forecast Variation Chart"
		And I can see text "Update 1 (Forecast)" in element "Forecast Variation Chart"
		And I can see element "Metrics by period Chart"
		And I can see text "Metrics by period" in element "Metrics by period Chart"
		And I can see element "Real vs Forecast Chart"
		And I can see text "Historical Data" in element "Real vs Forecast Chart"
		And I can see text "Original Forecast" in element "Real vs Forecast Chart"
		Then I can see text "See how the forecast from the pmc_supermercados models where altered with the addition of new data." in element "Forecast Variation Desctiption Chart"

		Examples:
			| ProjectName                |
			| all_mensal_partial_success |

	@CS-288
	Scenario Outline: Check Performance by period
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I can see element "Project Overview Title"
		When I click the "Menu Model Explorer[index=overallperformance]"
		And I can see element "Performance by period"
		And I can see text "<dependent_variable_1>" in element "td"
		And I can see text "<dependent_variable_2>" in element "td"

		Examples:
			| ProjectName                | dependent_variable_1 | dependent_variable_2 |
			| all_mensal_partial_success | 59.00%               | 70.00%               |