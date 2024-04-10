@POTENTIAL_IMPACTS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: AI Selection - Potential Impacts

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @TS-176 @TS-815 @AISELECTION
	Scenario Outline: Visualize Potencial impacts chart
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		Then I can see element "Potential Impacts Chart"

		Examples:
			| ProjectName                |
			| ui_fs_mensal_sanity_1      |
			| ui_fs_mensal_sanity_2      |
			| ml29-all-dataset-mensal    |
			| ml16-all-dataset-diario    |
			| ml23-all-dataset-anual     |
			| fs_bimestral_sanity_1      |
			| ml26-all-dataset-semestral |

	@SANITY @TS-176 @TS-815 @AISELECTION
	Scenario Outline: Not possible to visualize the Potencial impacts chart
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		And I can see element "Potential Impacts Chart"
		Then I wait for element "Potential Impacts See More Impacts Button" be disabled

		Examples:
			| ProjectName                 |
			| ml27-all-dataset-trimestral |
			| ui_diario_sanity            |
			| ml25-all-dataset-semanal    |

	@TS-347	@TS-501 @AISELECTION
	Scenario Outline: Check exclusion variable in AI Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		And I can see element "Understanding the Result"
		And I click the "See More Impacts Collapse"
		Then I can see only one of following text "<exclusion>" in element "Results Cards"
		And I can see element "Potential Impacts Chart"
		And I can see only one of following text "<exclusion>" in element "Potential Impacts Chart"

		Examples:
			| ProjectName        | exclusion                                      |
			| massa_com_exclusao | massahabitual,rendanacionalbruta,rendahabitual |
			| massa_sem_exclusao | massahabitual,rendanacionalbruta               |