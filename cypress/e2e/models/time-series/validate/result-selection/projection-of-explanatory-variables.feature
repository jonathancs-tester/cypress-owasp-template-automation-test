@PROJECTION_OF_EXPLANATORY_VARIABLES
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: AI Selection/User Selection - Projection Of Explanatory Variables

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@TS-372 @TS-898 @AISELECTION
	Scenario Outline: Show variables in Projection - Ai Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		And I click the "Filter Radio[name=<Frequency>;position=first]"
		And I can see element "Result Container Chart"
		Then I select "<Variable>" options in element "Projection os Explanatory Variables Select"

		Examples:
			| ProjectName      | Frequency | Variable  |
			| dataset_exp_z    | annual    | fs_ici    |
			| ui_diario_sanity | quarterly | z_tem_max |

	@TS-411 @USERSELECTION
	Scenario Outline: Show variables in Projection - User Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		Then I select "<Variable>" options in element "Projection os Explanatory Variables Select"

		Examples:
			| ProjectName   | Variable        |
			| dataset_exp_z | z_fs_taxa_selic |

	@SANITY @AISELECTION
	Scenario Outline: Check AI selection errors message
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		Then I can see text "<message>" in element "Error Mensage Explanatory Variables Chart"
		And I can see text "<message>" in element "Error Mensage Potential Impacts Chart"

		Examples:
			| ProjectName | message                                  |
			| mod1827_v1  | No explanatory variable to be displayed. |
