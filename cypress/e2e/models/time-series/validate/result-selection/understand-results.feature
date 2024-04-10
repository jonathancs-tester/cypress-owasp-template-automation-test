@UNDERSTAND_RESULTS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: AI Selection - Understand Results

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@TS-491 @TS-495 @TS-611
	Scenario Outline: Check variables with greater effect
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		And I click the "Filter Radio[name=<Frequency>;position=first]"
		And I can see element "Understanding the Result"
		And I select "<Data>" options in element "Data Results Select"
		And I click the "See More Impacts Collapse"
		Then I can see text "<Variable>" in element "Understanding the Result"
		And I can see text "<Message>" in element "Understanding the Result"

		Examples:
			| ProjectName                        | Frequency | Variable  | Data       | Message                                           |
			| check_variable_with_greater_effect | original  | natal_sab | 2022-12-01 | compared to the same month in the previous year   |
			| check_variable_with_greater_effect | quarterly | pim_rs    | 2023 Q4    | compared to the same quarter in the previous year |
			| ts495                              | annual    | outliers  | 2023       | compared to the previous year                     |
			| dataset_36obs                      | quarterly | outliers  | 2020 Q1    | compared to the same quarter in the previous year |

	@TS-774
	Scenario Outline: Check no insight available for this date
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"
		And I click the "Filter Radio[name=<Frequency>;position=first]"
		And I can see element "Understanding the Result"
		And I select "<Data>" options in element "Data Results Select"
		Then I can see text "<Variable>" in element "Understanding the Result"

		Examples:
			| ProjectName   | Frequency | Variable                           | Data |
			| dataset_36obs | annual    | No insight available for this date | 2018 |