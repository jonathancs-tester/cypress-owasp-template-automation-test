@BREAKDOWN
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION
Feature: Model Explorer - Breakdown

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @USERSELECTION @MODELSPECIFICS @TS-652 @TS-757
	Scenario: Check Model Breakdown exibition - User Selection
		Given I write "ml29-all-dataset-mensal" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=ml29-all-dataset-mensal;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		When I select "45" options in element "Model List Variable Select"
		And I can see element "Model Breakdown MoM HighChart Bar Layer"
		And I can see element "Model Breakdown MoM HighChart Scatter Layer"
		And I can see element "Model Breakdown Forecast Line HighChart"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can see element "Model Breakdown MoM HighChart Bar Layer"
		And I can see element "Model Breakdown MoM HighChart Scatter Layer"
		And I can see element "Model Breakdown Forecast Line HighChart"
		And I can see text "preco_gasol_uf" in element "Model Breakdown HighChart"
		And I click the "Filter Radio[name=quarterly;position=1]"
		And I can see text "preco_gasol_uf" in element "Model Breakdown HighChart"
		And I click the "Filter Radio[name=annual;position=1]"
		And I can see text "preco_gasol_uf" in element "Model Breakdown HighChart"
		And I can see text "one_off" in element "Model Breakdown HighChart"
		And I can't see any of following text "level_effects" in element "Model Breakdown HighChart"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "1" options in element "Model List Variable Select"
		And I can see element "Model Breakdown MoM HighChart Bar Layer"
		And I can see element "Model Breakdown MoM HighChart Scatter Layer"
		And I can see element "Model Breakdown Forecast Line HighChart"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		Then I can see element "Selected Model"
		And I can see element "Model Breakdown MoM HighChart Bar Layer"
		And I can see element "Model Breakdown MoM HighChart Scatter Layer"
		And I can see element "Model Breakdown Forecast Line HighChart"
		And I can see text "preco_gasol_uf" in element "Model Breakdown HighChart"
		And I click the "Filter Radio[name=quarterly;position=1]"
		And I can see text "preco_gasol_uf" in element "Model Breakdown HighChart"
		And I click the "Filter Radio[name=annual;position=1]"
		And I can see text "preco_gasol_uf" in element "Model Breakdown HighChart"
		And I can see text "level_effects" in element "Model Breakdown HighChart"
		And I can't see any of following text "one_off" in element "Model Breakdown HighChart"

	@SANITY @TS-409 @USERSELECTION @MODELSPECIFICS
	Scenario Outline: Improve message drilldown for daily, weekly, or biweekly data - User Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "4" options in element "Model List Variable Select"
		When I can see text "Only available for monthly data." in element "Model Breakdown Error HighChart"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can see text "Only available for monthly data." in element "Model Breakdown Error HighChart"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "1" options in element "Model List Variable Select"
		Then I can see text "Only available for monthly data." in element "Model Breakdown Error HighChart"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can see text "Only available for monthly data." in element "Model Breakdown Error HighChart"

		Examples:
			| ProjectName      |
			| ui_diario_sanity |
			| semanal_sanity   |
			| quinzenal_sanity |

	@USERSELECTION @MODELSPECIFICS
	Scenario: Check Model Breakdown tabs for no mensal projects - User Selection
		Given I write "anual_sanity" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=anual_sanity;position=first]"
		When I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "1" options in element "Model List Variable Select"
		And I can see text "Only available for monthly data." in element "Model Breakdown Error HighChart"
		Then I can see element "Send to User Selection Button"
		And I click the "Send to User Selection Button"
		And I can see element "See More Information Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can see text "Only available for monthly data." in element "Model Breakdown Error HighChart"

	@MODELSPECIFICS @TS-494
	Scenario Outline: Check sum_ aggregation variable is not renderized
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "1" options in element "Model List Variable Select"
		Then I can't see any of following text "sum_" in element "Model Breakdown HighChart"

		Examples:
			| ProjectName   |
			| sanity_mensal |
# | Trimestral_Sanity | ->https://4intelligenceds.atlassian.net/browse/TS-562: Foi comentado pois a funcionalidade estará disponivel para proxima release

