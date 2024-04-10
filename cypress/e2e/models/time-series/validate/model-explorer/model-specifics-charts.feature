@MODEL_SPECIFICS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER @ARIMA
Feature: Model Explorer - Model Specifics

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@SANITY @F4-779 @MODELSPECIFICS @TS-151
	Scenario Outline: Check charts for ARIMA and Regularized Regression
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then I can see element "Check Residuals First Chart Scatter Layer"
		And I can see element "Check Residuals Second Chart Scatter Layer"
		And I can see element "Check Residuals Second Chart Bar Layer"
		And I can see element "Check Residuals Third Chart Bar Layer"
		And I can see element "Historical and Model Fit Chart Scatter Layer"
		And I can see text list "<legend-model-fit>" in element "Historical and Model Fit Chart"
		And I can see element "Historical and Forecast Chart Scatter Layer"
		And I can see text list "<legend-forecast>" in element "Historical and Forecast Chart"
		And I can see element "Annual Variation (%) Chart Bar Layer"
		And I can see text list "<legend-actual>" in element "Annual Variation (%) Chart"
		And I can see element "Annual Level Chart Bar Layer"
		And I can see text list "<legend-actual>" in element "Annual Level Chart"

		Examples:
			| menu                  | ProjectName       | ModelList | legend-forecast                         | legend-model-fit     | legend-actual       |
			| arima                 | semanal_sanity    | 6         | Historical;Forecast                     | Historical;Model fit | Historical;Forecast |
			| regularizedregression | quinzenal_sanity  | 2         | Historical;Forecast                     | Historical;Model fit | Historical          |
			| arima                 | sanity_mensal     | 40        | Historical;Forecast;Seasonally Adjusted | Historical;Model fit | Historical;Forecast |
			| regularizedregression | trimestral_sanity | 1         | Historical;Seasonally Adjusted          | Historical;Model fit | Historical          |
			| arima                 | semestral_sanity  | 21        | Historical;Forecast                     | Historical;Model fit | Historical;Forecast |
			| regularizedregression | anual_sanity      | 3         | Historical;Forecast                     | Historical;Model fit | Historical;Forecast |

	@SANITY @F4-779 @MODELSPECIFICS @TS-151
	Scenario Outline: Check charts for Forecast Combination and Elementary
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then I can see element "Historical and Model Fit Chart Scatter Layer"
		And I can see text list "<legend-model-fit>" in element "Historical and Model Fit Chart"
		And I can see element "Historical and Forecast Chart Scatter Layer"
		And I can see text list "<legend-forecast>" in element "Historical and Forecast Chart"
		And I can see element "Annual Variation (%) Chart Bar Layer"
		And I can see text list "<legend-actual>" in element "Annual Variation (%) Chart"
		And I can see element "Annual Level Chart Bar Layer"
		And I can see text list "<legend-actual>" in element "Annual Level Chart"

		Examples:
			| menu                | ProjectName       | ModelList | legend-forecast                         | legend-model-fit     | legend-actual       |
			| forecastcombination | semanal_sanity    | 6         | Historical;Forecast                     | Historical;Model fit | Historical;Forecast |
			| elementary          | quinzenal_sanity  | 2         | Historical;Forecast                     | Historical;Model fit | Historical          |
			| forecastcombination | sanity_mensal     | 11        | Historical;Forecast;Seasonally Adjusted | Historical;Model fit | Historical;Forecast |
			| elementary          | trimestral_sanity | 3         | Historical;Seasonally Adjusted          | Historical;Model fit | Historical          |
			| forecastcombination | semestral_sanity  | 10        | Historical;Forecast                     | Historical;Model fit | Historical;Forecast |
			| elementary          | anual_sanity      | 2         | Historical;Forecast                     | Historical;Model fit | Historical;Forecast |

	@SANITY @MODELSPECIFICS @MOD1510
	Scenario Outline: Check charts for Random Forest
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		When I select "<y-name>" options in element "Dependent Variable Select"
		And I select "1" options in element "Model List Variable Select"
		And I can see element "Variable Importance HighChart Bar Series"
		And I select "4" options in element "Show Variables Data View Select"
		And I should see is equal to 4 items of "Variable Importance HighChart Data Label"
		And I can see element "Historical and Model Fit Chart Scatter Layer"
		And I can see text list "<legend-model-fit>" in element "Historical and Model Fit Chart"
		And I can't see any of following text "-" in element "Historical and Model Fit Y Values Chart"
		And I can see element "Historical and Forecast Chart Scatter Layer"
		And I can see text list "<legend-forecast>" in element "Historical and Forecast Chart"
		And I can't see any of following text "-" in element "Historical and Forecast Y Values Chart"
		And I can see element "Annual Variation (%) Chart Bar Layer"
		And I can see text list "<legend-actual>" in element "Annual Variation (%) Chart"
		And I can see element "Annual Level Chart Bar Layer"
		And I can see text list "<legend-actual>" in element "Annual Level Chart"

		Examples:
			| menu         | ProjectName      | y-name    | legend-forecast     | legend-model-fit     | legend-actual       |
			| randomforest | modeling_f4-1427 | pim       | Historical;Forecast | Historical;Model fit | Historical;Forecast |
			| randomforest | mod1510          | caminhoes | Historical;Forecast | Historical;Model fit | Historical;Forecast |

	@SANITY @F4-779 @MODELSPECIFICS @TS-151
	Scenario Outline: Check data is not available for Annual Variation and Annual Level
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then I can see element "Check Residuals First Chart Scatter Layer"
		And I can see element "Check Residuals Second Chart Scatter Layer"
		And I can see element "Check Residuals Second Chart Bar Layer"
		And I can see element "Check Residuals Third Chart Bar Layer"
		And I can see element "Historical and Model Fit Chart Scatter Layer"
		And I can see text list "<legend-model-fit>" in element "Historical and Model Fit Chart"
		And I can see element "Historical and Forecast Chart Scatter Layer"
		And I can see text list "<legend-forecast>" in element "Historical and Forecast Chart"
		And I can't see element "Annual Variation (%) Chart Bar Layer"
		And I can see text "Annual Variation is not available for this model" in element "Model Specifics Container"
		And I can't see element "Annual Level Chart Bar Layer"
		And I can see text "Annual Level is not available for this model" in element "Model Specifics Container"

		Examples:
			| menu                  | ProjectName      | ModelList | legend-forecast     | legend-model-fit     |
			| arima                 | ui_diario_sanity | 12        | Historical;Forecast | Historical;Model fit |
			| regularizedregression | ui_diario_sanity | 2         | Historical;Forecast | Historical;Model fit |

	@MOD1615
	Scenario: Check "z_" in Y variable and log=TRUE with forecasts wrongs
		Given I write "mod1615" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=mod1615;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "11" options in element "Model List Variable Select"
		Then I can see element "Check Residuals First Chart Scatter Layer"
		And I can see element "Check Residuals Second Chart Scatter Layer"
		And I can see element "Check Residuals Second Chart Bar Layer"
		And I can see element "Check Residuals Third Chart Bar Layer"
		And I can see element "Historical and Model Fit Chart Scatter Layer"
		And I can see text list "Historical;Model fit" in element "Historical and Model Fit Chart"
		And I can see element "Historical and Forecast Chart Scatter Layer"
		And I can see text list "Historical;Forecast;Seasonally Adjusted" in element "Historical and Forecast Chart"
		And I can see element "Annual Variation (%) Chart Bar Layer"
		And I can't see any of following text "x10" in element "Model Specifics Container"
		And I can see element "Annual Level Chart Bar Layer"
		And I can't see any of following text "x10" in element "Model Specifics Container"