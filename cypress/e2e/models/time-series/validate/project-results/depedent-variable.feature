@DEPEDENT_VARIABLE
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @PROJECT_OVERVIEW
Feature: Project Overview - Dependent Variables

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@V3.2 @TS-4 @TS-2 @TS-1 @TS-104 @TS-111 @TS-134 
	Scenario: Check Depedent variable chart maximum plot 4 models
		Given I write "ml02-15y-dataset-all-sanity_with_error" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=ml02-15y-dataset-all-sanity_with_error;position=first]"
		When I can see text "12" in element "Project Summary Table"
		And I use "ind_s" as "name" in template
		And I can see element "Select Dependent Variable Button"
		And I click the "Select Dependent Variable Button[name=com_mw]"
		And I can see text "Select at least one variable to check the comparison of the dependent variables of your project." in element "Depedent Variable Card"
		And I click the "Select Dependent Variable Button[name=res_n]"
		And I click the "Select Dependent Variable Button[name=com_mw]"
		And I click the "Select Dependent Variable Button[name=com_n]"
		And I click the "Select Dependent Variable Button[name=com_se]"
		And I can see text list "res_n;com_mw;com_n;com_se" in element "Dependent Variables Chart"
		And I can see element "Mini Chart Dependent Variables"
		Then I wait for element "Select Dependent Variable Button" be disabled

	@TS-5 @V3.2
	Scenario: Check if possible to customize values your table
		Given I write "ml02-15y-dataset-all-sanity_with_error" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=ml02-15y-dataset-all-sanity_with_error;position=first]"
		When I click the "Adjust Settings Button"
		And I click the "Customize Your Table Button"
		And I set "Select One Checkbox[name=model]" to checked
		And I click the "Save Button"
		Then I can see text "Model" in element "Dependent Variables Table"
		And I click the "Adjust Settings Button"
		And I click the "Customize Your Table Button"
		And I set "Select One Checkbox[name=model]" to unchecked
		And I click the "Save Button"
		
	@V3.2 @TS-7 @TS-145
	Scenario: Check if possible to change the variable name
		Given I write "ml02-15y-dataset-all-sanity_with_error" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=ml02-15y-dataset-all-sanity_with_error;position=first]"
		When I click the "Adjust Settings Button"
		And I click the "Rename Variables Button"
		And I write "variable as-çãÀáâ" text in element "Rename Variable Input[name=ind_s;position=first]"
		And I click the "Save Button"
		And I can see text "variable as-çãÀáâ" in element "Depedent Variable Card"
		And I click the "Export Button"
		And I check if download size is greather than 200 kb
		And I check if "variable as-çãÀáâ" data is finding in download file
		And I clear download folder
		And I click the "Adjust Settings Button"
		And I click the "Rename Variables Button"
		And I write "ind_s" text in element "Rename Variable Input[name=ind_s;position=first]"
		And I click the "Save Button"
		Then I can see text "ind_s" in element "Depedent Variable Card"
		And I can see element "Mini Chart Dependent Variables"

	Scenario Outline: Check Search Dependent Variables in chart
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I write "<Variables>" text in element "Search Dependent Variables"
		And I click the "Select or Deselect Variables Button"
		And I write "error" text in element "Search Dependent Variables"
		Then I can see text "We couldn't find any dependent variable containing" in element "Dependent Variables Not found Chart"

		Examples:
			| ProjectName                            | Variables |
			| ml02-15y-dataset-all-sanity_with_error | ind_n     |