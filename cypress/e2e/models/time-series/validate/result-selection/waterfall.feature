@WATERFALL
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: AI Selection - Waterfall

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @TS-337 @AISELECTION
	Scenario Outline: Check Waterfall chart for AI selection
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"	
		And I can see element "Understanding the Result"
		And I wait for element "See More Impacts Collapse" be enabled
		And I click the "See More Impacts Collapse"
		Then I get value reference a Cards
		And I click the "Understanding Results Waterfall Button"
		And I get value reference a Waterfall
		And I compare cards with Waterfall

		Examples:
			| ProjectName        |
			| massa_com_exclusao |
			| massa_sem_exclusao |

	@TS-636 @AISELECTION @TS-701
	Scenario Outline: Check Waterfall chart disabled for univariate model
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=aiselection]"	
		And I can see element "Understanding the Result"
		Then I wait for element "See More Impacts Collapse" be disabled

		Examples:
			| ProjectName |
			| mod1828     |
