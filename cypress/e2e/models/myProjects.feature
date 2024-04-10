@MYPROJECTS_UI
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION
Feature: My Projects

	@SANITY
	Scenario: No projects found
		Given insert "view" credentials and login via "MFA"
		And access main page			
		When access "Models" application
		Then it should not be possible to access "My Projects" with "view" user

	@TS-48
	Scenario: Check visualize projects in modeling with partial error
		And access main page			
		And access "Models" application
		When find "ML02-15Y-Dataset-All-Sanity_with_error" project
		And click to "ML02-15Y-Dataset-All-Sanity_with_error" Model Explorer
		Then check "com_ne" Dependent Variable should be disable
	
	Scenario: Check create project disable with read project user
		When insert "read_project" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		Then it should not be possible to access "Create a New Project" with "read project" user
		And it should be to check "Sorry, you only have access to demand forecast projects. To able to create projects contact our seller team." tooltip message

	@SANITY
	Scenario: Check multiple dependent variables exibition at Projects
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		Then find "ML02-15Y-Dataset-All-Sanity_with_error" project 
		And check multiple dependent variables exibition at Projects

	@SANITY
	Scenario Outline: Project deletion successfully
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		When find "<project>" project 
	 	Then click to delete it

		 Examples:
			 | project 				 |
			 | NoExploratory_Sanity  |
			 | hotel  |
	
	Scenario Outline: Project deletion failed
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		When find "<project>" project 
		And type an invalid word to delete it
		Then a deletion error message should be showed

		Examples:
			 | project 				 |
			 | NoExploratory_Sanity  |
			 | hotel  |
	
	@SANITY
	Scenario Outline: Check download project with success
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		When find "<ProjectName>" project 
		Then click to download project and check its is greather than 200 kB

	Examples:
		|	ProjectName									|
		|	Anual_Sanity								|
		|	ML02-15Y-Dataset-All-Sanity_with_error		|
