@MYPROJECTS_UI
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION 
Feature: My Projects

	@SANITY
	Scenario: No projects found
		When insert "time_series" credentials and login via "MFA"
		And I visit "/"	
		And I click the "Models"
		Then I can see text "No projects found, start by creating one." in element "No Project Message Container"
		And I wait for element "Create Project Button" be enabled	

	@TS-48
	Scenario: Check visualize projects in modeling with partial error
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		When I write "ML02-15Y-Dataset-All-Sanity_with_error" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=ml02-15y-dataset-all-sanity_with_error;position=first]"
		Then I click the "Chart Dependent Variables Dropdown Indicator"
		And I can see text "com_ne" in element "Disabled Option"
	
	@TS-616
	Scenario: Check create project disable with read project user
		When insert "read_project" credentials and login via "MFA"
		And I visit "/"	
		And I click the "Models"
		Then I can see element "Message Forecast Projects"
		And I wait for element "Delete My Project Menu[name=semanal_sanity]" be disabled

	@SANITY
	Scenario: Check multiple dependent variables exibition at Projects
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		When I write "ML02-15Y-Dataset-All-Sanity_with_error" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I can see text "variables" in element "Project Verify Dependent Variable[project=ML02-15Y-Dataset-All-Sanity_with_error;position=first]" 

	@SANITY
	Scenario Outline: Project deletion successfully
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		When I write "<project>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "Options Project Button[project=<project>;position=first]"
		And I click the "Delete My Project Menu[name=<project>;position=first]"
		And I write "<projectName>" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"

		 Examples:
			 | project 				 | projectName 			|
			 | noexploratory_sanity  | NoExploratory_Sanity |
			 | hotel  				 | hotel		   		|
	
	Scenario Outline: Project deletion failed
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		When I write "<project>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes 
		And I click the "Options Project Button[project=<project>;position=first]"
		And I click the "Delete My Project Menu[name=<project>;position=first]"
		And I write "invalidDeletionWord" text in element "Input Confirm Delete"
		Then I can see text "Must write the correct project name" in element "p"

		Examples:
			 | project 				 |
			 | noexploratory_sanity  |
			 | hotel  |
	
	@SANITY
	Scenario Outline: Check download project with success 
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		When I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "Options Project Button[project=<ProjectName>;position=first]"
		And I click the "Menu Download Project Button[project=<ProjectName>;position=first]"
		Then I check if download size is greather than 200 kb

	Examples:
		|	ProjectName									|
		|	anual_sanity								|
		|	ml02-15y-dataset-all-sanity_with_error		|
