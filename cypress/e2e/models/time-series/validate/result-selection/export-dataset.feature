@USERSELECTION_EXPORT
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @USERSELECTION
Feature: User Selection - Export Dataset

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @TS-244 @USERSELECTION
	Scenario Outline: Check export dataset with historical series and forecasts - User Selection
		When I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=<submenu>]"
		And I select "<ModelList>" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I click the "Download User Selection"
		Then I check if download size is greather than 200 kb
		And I clear download folder

		Examples:
			| ProjectName           | menu                  | submenu         | ModelList |
			| ui_diario_sanity      | arima                 | modelspecifics  | 4         |
			| semanal_sanity        | arima                 | crossvalidation | 9         |
			| quinzenal_sanity      | forecastcombination   | modelspecifics  | 2         |
			| sanity_mensal         | regularizedregression | crossvalidation | 3         |
			| trimestral_sanity     | forecastcombination   | modelspecifics  | 6         |
			| semestral_sanity      | forecastcombination   | crossvalidation | 12        |
			| anual_sanity          | randomforest          | modelspecifics  | 1         |
			| fs_bimestral_sanity_1 | randomforest          | crossvalidation | 1         |
			| fs_pim_mar2002        | arima                 | modelspecifics  | 2         |