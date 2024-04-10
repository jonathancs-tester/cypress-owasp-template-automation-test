@PROJECTIONS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @PROJECT_OVERVIEW
Feature: Project Overview - Projections

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @TS-3 @V3.2
	Scenario Outline: Check Model In Production info for Product Overview
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=<submenu>]"
		And I select "10" options in element "Model List Variable Select"
		And I select "com_s" options in element "Dependent Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I click the "Menu Model Explorer[index=projectoverview]"
		And I use "ind_s" as "name" in template
		And I can see element "Select Dependent Variable Button"
		Then I get after info in "Projections Table"		
		And I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=<submenu>]"
		And I select "25" options in element "Model List Variable Select"
		And I select "com_s" options in element "Dependent Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I click the "Menu Model Explorer[index=projectoverview]"
		And I can see element "Select Dependent Variable Button"
		And I get before info in "Projections Table"
		Then I compare after info is not equal before info

        Examples:
			| ProjectName              				 | menu  | submenu        |
			| ml02-15y-dataset-all-sanity_with_error | arima | modelspecifics |

	@TS-8 @V3.2
	Scenario Outline: Check if projects with one Y do not have Project Overview
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		Then I can't see element "Menu Model Explorer[index=projectoverview]"

		Examples:
			| ProjectName              |
			| ml02-15y-with-1y-success |
			| sanity_mensal            |
