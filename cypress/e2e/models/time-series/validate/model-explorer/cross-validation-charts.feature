@CROSS_VALIDATION_CHART
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Explorer - Cross Validation Charts

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @CROSSVALIDATION
	Scenario Outline: Check accuracy charts for Cross Validation
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=crossvalidation]"
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then I can see element "Percentage Error Metrics HighChart Scatter Layer"
		And I set "Percentage Error Checkbox[name=wmape]" to checked
		And I set "Percentage Error Checkbox[name=mpe]" to checked
		And I can see text list "MAPE;WMAPE;MPE" in element "Percentage Error Metrics HighChart"
		And I can see element "Level Error Metric HighChart Scatter Layer"
		And I can see element "Scaled Error Metrics HighChart Scatter Layer"
		And I can see element "Level Error Metric HighChart Scatter Layer"
		And I set "Scaled Error Checkbox[name=mases]" to checked
		And I can see text list "MASE;MASEs" in element "Scaled Error Metrics HighChart"
		And I can see text list "RMSE" in element "Level Error Metric HighChart"

		Examples:
			| menu                  | ProjectName           | ModelList |
			| arima                 | ui_diario_sanity      | 2         |
			| regularizedregression | sanity_mensal         | 2         |
			| randomforest          | trimestral_sanity     | 1         |
			| forecastcombination   | semestral_sanity      | 9         |
			| arima                 | fs_bimestral_sanity_1 | 2         |
			| arima                 | ts505_dataset_target  | 1         |


	@TS-421 @CROSSVALIDATION
	Scenario Outline: MASEs values for NaN should be disable the checkbox
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=crossvalidation]"
		And I select "<ModelList>" options in element "Model List Variable Select"
		And I can see element "Level Error Metric HighChart Scatter Layer"
		And I can see element "Scaled Error Metrics HighChart Scatter Layer"
		And I can see element "Level Error Metric HighChart Scatter Layer"
		Then I wait for element "Scaled Error Checkbox[name=mases]" be disabled
		And I can see text list "MASE" in element "Scaled Error Metrics HighChart"

		Examples:
			| menu                  | ProjectName      | ModelList |
			| arima                 | anual_sanity     | 2         |
			| regularizedregression | semanal_sanity   | 2         |
			| forecastcombination   | quinzenal_sanity | 9         |

	@TS-344
	Scenario: Incorrect information in the combinations cross validation tab
		Given I write "sanity_mensal" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=sanity_mensal;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=crossvalidation]"
		When I get after info in "Accuracy Model Summary"
		And I click the "Menu Model Explorer[index=forecastcombination]"
		And I click the "Menu Model Explorer[index=crossvalidation]"
		Then I get before info in "Accuracy Model Summary"
		And I compare after info is not equal before info

	@TS-1029
	Scenario: Dataset combination without z_ not accept the log variable
		And I write "ts1029" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=ts1029;position=first]"
		When I click the "Menu Model Explorer[index=forecastcombination]"
		And I click the "Menu Model Explorer[index=crossvalidation]"
		Then I can't see any of following text "e+" in element "Cross Validation Y Value Chart"
