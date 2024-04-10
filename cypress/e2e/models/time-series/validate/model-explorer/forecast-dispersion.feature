@FORECAST_DISPERSION
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Explorer - Forecast Dispesion

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @F4-789 @MODELDISPERSION
	Scenario Outline: Check Forecast Dispersion chart
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		And I select "<n-best>" options in element "N Best Model Select"
		Then I can see text "<BestModel>" in element "Forecast Dispersion Chart"

		Examples:
			| ProjectName       | BestModel  | n-best |
			| ui_diario_sanity  | Model 20   | 20     |
			| quinzenal_sanity  | Model 30   | 30     |
			| trimestral_sanity | Historical | 2      |
			| anual_sanity      | Model 50   | 50     |

	@SANITY @F4-789 @MODELDISPERSION
	Scenario Outline: Check Forecast Dispersion chart in Forecast Combination
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=forecastcombination]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		Then I can see text "<BestModel>" in element "Forecast Dispersion Chart"

		Examples:
			| ProjectName           | BestModel |  
			| semanal_sanity        | Model 2   | 
			| sanity_mensal         | Model 4   | 
			| semestral_sanity      | Model 8   | 
			| fs_bimestral_sanity_1 | Model 11  |