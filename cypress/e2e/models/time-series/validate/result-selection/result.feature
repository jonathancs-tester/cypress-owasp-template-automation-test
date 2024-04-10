@RESULTS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: AI Selection/User Selection - Results Chart

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@TS-478 @TS-504 @AISELECTION
	Scenario Outline: Verify diary dataset frequency is visible Ai Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		And I click the "Filter Radio[name=<Frequency>;position=first]"
		Then I can see element "Result Container Chart"

		Examples:
			| ProjectName                     | Frequency |
			| diario_without_values_variables | original  |
			| diario_without_values_variables | monthly   |
			| diario_without_values_variables | quarterly |
			| mod1828                         | annual    |

	@TS-477 @USERSELECTION
	Scenario Outline: Verify diary dataset frequency is visible User Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=userselection]"
		And I click the "Filter Radio[name=<Frequency>;position=first]"
		Then I can see element "Result Container Chart"

		Examples:
			| ProjectName                     | Frequency |
			| diario_without_values_variables | original  |
			| diario_without_values_variables | monthly   |
			| diario_without_values_variables | quarterly |
			| mod1828                         | annual    |

	Scenario Outline: Check Latest data on results chart
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		Then I can see text list "<date>" in element "Result Container Chart"

		Examples:
			| ProjectName           | Frequency | date                                         |
			| anual_sanity          | original  | 2017;2018;2019;2020;2021;2022                |
			| ui_fs_mensal_sanity_1 | original  | Oct 2019;Jan 2020;Apr 2020                   |
			| semestral_sanity      | original  | 2015;2016;2017;2018;2019;2020                |
			| quinzenal_sanity      | original  | Jul 2019;Sep 2019;Nov 2019;Jan 2020;Mar 2020 |
			| semanal_sanity        | original  | Mar 2020;May 2020;Jul 2020;Sep 2020;Nov 2020 |
			| dataset_with_no_date  | original  | Mar 2018;May 2018;Jul 2018;Sep 2018;Nov 2018 |

	@TS-338
	Scenario Outline: Verify dataset Ai Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		And I select "<Dependent_variable>" options in element "Dependent Variable Select"
		And I click the "Filter Radio[name=<Frequency>;position=first]"
		And I can see element "Result Container Chart"
		Then I can see text list "<date>" in element "Result Container Chart"

		Examples:
			| ProjectName             | Frequency | Dependent_variable | date                                                                                                        |
			| ml16-all-dataset-diario | monthly   | temp_media         | Jul 2019;Jan 2020;Jul 2020;Jan 2021;Jul 2021;Jan 2022                                                       |
			| trimestral_sanity       | original  | pibd               | Apr 2017;Jul 2017;Oct 2017;Jan 2018;Apr 2018;Jul 2018;Oct 2018;Jan 2019;Apr 2019;Jul 2019;Oct 2019;Jan 2020 |


	@AISELECTION @TS-700
	Scenario Outline: Verify diary dataset frequency is not visible Ai Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		And I click the "Filter Radio[name=<Frequency>;position=first]"
		Then I can't see element "Result Container Chart"
		And I can see text "Annual series summary is only available for series with at least 1 year of observation" in element "Models Modal"

		Examples:
			| ProjectName                     | Frequency |
			| diario_without_values_variables | annual    |

	@TS-477 @USERSELECTION @TS-700
	Scenario Outline: Verify diary dataset frequency is not visible User Selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=userselection]"
		And I click the "Filter Radio[name=<Frequency>;position=first]"
		Then I can't see element "Result Container Chart"
		And I can see text "Annual series summary is only available for series with at least 1 year of observation" in element "Models Modal"

		Examples:
			| ProjectName                     | Frequency |
			| diario_without_values_variables | annual    |
