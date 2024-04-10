@MODEL_INFO
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Explorer - Model Info

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @CROSSVALIDATION
	Scenario Outline: Check Forecast horizon and Windows for Cross Validation
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=crossvalidation]"
		And I select "<ModelList>" options in element "Model List Variable Select"
		And I change the step to <crossValue> on the "Cross Validation Slider" slider element
		Then I can see text "<forestValue>" in element "Forecast Horizon Model Info"
		And I can see text "<crossValue>" in element "Test Windows Model Info"
		And I can see element "Cross Validation Chart Scatter Layer"

		Examples:
			| menu                  | ProjectName           | forestValue | crossValue | ModelList |
			| arima                 | ui_diario_sanity      | 3           | 3          | 2         |
			| regularizedregression | semanal_sanity        | 20          | 20         | 2         |
			| forecastcombination   | quinzenal_sanity      | 20          | 20         | 9         |
			| randomforest          | sanity_mensal         | 20          | 20         | 1         |
			| arima                 | trimestral_sanity     | 20          | 15         | 2         |
			| regularizedregression | semestral_sanity      | 10          | 5          | 2         |
			| forecastcombination   | anual_sanity          | 5           | 1          | 8         |
			| randomforest          | fs_bimestral_sanity_1 | 20          | 1          | 1         |
			| randomforest          | ts505_dataset_target  | 1           | 1          | 1         |

	@TS-488 @TS-463
	Scenario Outline: Modelling should not contain Model Type
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I click the "Menu Model Explorer[index=<Model>]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then check all elementary models texts "<Type>"

		Examples:
			| ProjectName                     | Model                 | Type                       |
			| anual_sanity                    | elementary            | ARIMA_SEASM,ARIMA_SEASD,-- |
			| diario_without_values_variables | elementary            | ARIMA_SEASM,STL,--         |
			| quinzenal_sanity                | elementary            | ARIMA_SEASM,--             |
			| semanal_sanity                  | elementary            | ARIMA_SEASM,--             |
			| ui_diario_sanity                | regularizedregression | ElasticNet                 |
			| semanal_sanity                  | regularizedregression | ElasticNet                 |
			| quinzenal_sanity                | regularizedregression | ElasticNet                 |
			| dataset_36obs                   | elementary            | LM                         |

	Scenario Outline: Check log info (apply log)
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then I can see text "<log>" in element "Transformation Model Info"

		Examples:
			| menu         | ProjectName           | log  |
			| arima        | ui_diario_sanity      | Log  |
			| arima        | quinzenal_sanity      | Diff |
			| randomforest | ui_diario_sanity      | Log  |
			| randomforest | ui_fs_mensal_sanity_2 | --   |

	@TS-653
	Scenario: Check WMAPE value when nsteps = 1
		Given I write "teste_wmape" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=teste_wmape;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then I get after info in "Accuracy Model Info[name=mape]"
		And I get before info in "Accuracy Model Info[name=wmape]"
		And I compare after info is not equal before info
