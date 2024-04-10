@DUPLICATE_API
@4INTELLIGENCE @API @DUPLICATEPROJECT @TIMESERIES @REGRESSION
Feature: Duplicate Project

	#Essa .feature deve ficar em validate devido precisar da modelagem já finalizada para duplicar
	Background: Login
		Given insert "admin" credentials and login via "MFA"

	@SANITY
	Scenario Outline: Check create duplicate projects
		And search "<projectName>" id in response API
		When create duplicate project with "@projectID", "<user>" user and "<response>" response
		And insert "<user_credential>" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Search Project"
		Then I write "<project>" text in element "Search Project"
		And I can see text "<projectName>" in element "My Project Name Card"

		Examples:
			| response | projectName              | user                      | project                  | user_credential |
			| success  | UI_FS_Mensal_Variables_1 | read-project@4casthub.com | UI_FS_Mensal_Variables_1 | read_project    |
			| success  | Semanal_Sanity           | read-project@4casthub.com | Semanal_Sanity           | read_project    |
			| success  | 63c17641ac7bf6cdf744b536 | read-project@4casthub.com | 63c17641ac7bf6cdf744b536 | read_project    |
			| success  | UI_Diario_Sanity         | read-project@4casthub.com | UI_Diario_Sanity         | read_project    |

	@SANITY @CS-317
	Scenario Outline: Duplication route not allows classification projects
		And search "<projectName>" id in response API
		When create duplicate project with "@projectID", "<user>" user and "<response>" response

		Examples:
			| response    | projectName   | user                      | project       |
			| bad request | vinhos_sanity | read-project@4casthub.com | vinhos_sanity |

	Scenario Outline: Check duplicate projects error when project not finished
		And I visit "/"
		And I click the "Models"
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "<dateFormat>" options in element "Format Date Select"
		And I click the "Final Settings Button"
		And I wait for element "Custom Period Toggle" be enabled
		And I close the "Data Processing Modal" if exists
		And I set "Custom Period Toggle" to checked
		And I change the value to "<forestDefault>" from "<forestValue>" on the "Forecast Horizon Slider" slider element
		When I click the "Fine Tunning Button"
		And I can see text "<crossDefault>" attribute value in element "Cross Validation Input"
		And I write "<crossValue>" text in element "Cross Validation Input"
		And I set "Apply Log Toggle" to <log>
		And I set "Add Seasonal Dummies Toggle" to <dummies>
		And I click the "Ranking Criteria Button"
		And I select "<accuracy>" options in element "Accuracy Criteria Select"
		And I select "<cross>" options in element "Cross Validation Summary Select"
		And I click the "Explanatory Features Button"
		And I set "Avoid Collinearity Toggle" to <avoid>
		And I set "Explanatory Variables Auto - Forecast Toggle" to <auto_expl>
		And I set "Allow Drift Toggle" to <drift>
		And I click the "Configure Exclusion Button"
		And I select list "<group 1>" options in element "Group 1"
		And I select list "<group 2>" options in element "Group 2"
		And I select list "<group 3>" options in element "Group 3"
		And I click the "Feature Selection Button"
		And I select "<g.variables>" options in element "Golden Variable Select"
		And I click the "Fine Tunning Confirm Button"
		And I click the "Modeling Button"
		And I can see text "You'll receive an email informing when the job is finished." in element "Modeling Description Modal"
		And I close the "Modeling Modal" if exists
		When search "<ProjectName>" id in response API
		Then create duplicate project with "@projectID_NotFinished", "read-project@4casthub.com" user and "bad request" response

		Examples:
			| ProjectName                | dataset                             | dateFormat | forestDefault | crossDefault | forestValue | crossValue | log     | dummies   | accuracy | cross  | avoid   | auto_expl | drift   | group 1         | group 2    | group 3       | g.variables |
			| Duplicate_Processing_Error | time-series/dataset_anual_fake.xlsx | do not set | 1             | 5            | 5           | 1          | checked | unchecked | WMAPE    | Median | checked | checked   | checked | pib_tot;pib_fam | do not set | pib_ind;pib_x | ipca        |