@PICK4ME
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION
Feature: Pick4me integration with Feature Store

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page
		And access "Models" application

	@SANITY
	Scenario Outline: Send modelling with added variables pick for me
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"		
		And I select "do not set" options in element "Format Date Select"
		And I click the "Add Feature Store Button"
		And I click the "Pick4me Button"
		And I click "Name" name in "Feature Store Groups Modal"
		And I click "Send series" name in "Feature Store Groups Modal"
		And I click the "Modeling Modal"
		And I click the "Final Settings Button"
		And I wait for element "Custom Period Toggle" be enabled
		And I close the "Feature Selection Modal" if exists
		And I close the "Data Processing Modal" if exists
		And I set "Custom Period Toggle" to checked
		And I change the value to "<forestDefault>" from "<forestValue>" on the "Forecast Horizon Slider" slider element
		When I click the "Fine Tunning Button"
		And I can see text "<crossDefault>" attribute value in element "Cross Validation Input"
		And I write "<crossValue>" text in element "Cross Validation Input"
		And I set "Apply Log Toggle" to <log>
		And I set "Add Seasonal Dummies Toggle" to <dummies>
		And I click the "Ranking Criteria Tab"
		And I select "<accuracy>" options in element "Accuracy Criteria Select"
		And I select "<cross>" options in element "Cross Validation Summary Select"
		And I click the "Explanatory Features Tab"
		And I set "Avoid Collinearity Toggle" to <avoid>
		And I set "Explanatory Variables Auto - Forecast Toggle" to <auto_expl>
		And I set "Allow Drift Toggle" to <drift>
		And I click the "Configure Exclusion Tab"
		And I select list "<group 1>" options in element "Group 1"
		And I select list "<group 2>" options in element "Group 2"
		And I select list "<group 3>" options in element "Group 3"
		And I click the "Feature Selection Tab"
		And I set "Lasso Toggle" to <lasso>
		And I set "Random Forest Toggle" to <random>
		And I set "Correlation Filter Toggle" to <correlation>
		And I select "<g.variables>" options in element "Golden Variable Select"
		And I click the "Fine Tunning Confirm Button"
		And I click the "Modeling Button"
		And I can see text "You'll receive an email informing when the job is finished." in element "Modeling Description Modal"
		And I close the "Modeling Modal" if exists

		Examples:
			| ProjectName 				| dataset 					 					 | forestDefault | crossDefault | forestValue | crossValue | log  	 | dummies 	  | accuracy | cross  | avoid 	  | auto_expl  | drift  	| group 1                   | group 2           | group 3     | lasso 	| random 	| correlation | g.variables            |
			| Mensal_All_With_Pick4Me 	| time-series/Mensal/dataset_mensal_fake_1.xlsx  | 12            | 12           | 20          | 20         | unchecked| checked    | WMAPE    | Median | unchecked | unchecked  | checked    | do not set              | do not set       | do not set     | checked  | checked   | checked   | do not set             |
	
	@F4-1907
	Scenario Outline: Check probability with greater than 0.5 value
		And I intercept "**/featurestore/series/recommended**" route as "waitPickForMeVariables" with "POST" http verbs
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		When I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "<dataFormat>" options in element "Format Date Select"
		And I click the "Add Feature Store Button"
		And I click the "Pick4me Button"
		Then I wait "@waitPickForMeVariables" routes
		And I check "probability" is greater than 0.5 in response

		Examples:
			| ProjectName 			| dataFormat	| dataset 					 					|
			| FS_Mensal_Variables_1 | do not set	| time-series/Mensal/dataset_mensal_fake_1.xlsx |
			| FS_Mensal_Variables_5 | yyyy-MM-dd	| time-series/Mensal/dataset_mensal_fake_5.csv  |

	Scenario Outline: Check pick for me dummies variables not be visible
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"		
		And I select "yyyy-MM-dd" options in element "Format Date Select"
		And I click the "Add Feature Store Button"
		And I click the "Pick4me Button"
		Then I can't see any of following text "<dummiesVariables>" in element "Feature Store Groups Modal"

		Examples:
			| ProjectName 			| dataset 								 		 | dummiesVariables 	|
			| checkDummiesVariables | time-series/Mensal/prod_automoveis.xlsx 		 | BRA - FIFA World Cup	|
     
	Scenario Outline: Check error message in pick for me for dataset with error
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"		
		And I select "do not set" options in element "Format Date Select"
		And I click the "Add Feature Store Button"
		And I click the "Pick4me Button"
		Then I can see text "Sorry, we couldn't find any feature to recommend." in element "Feature Store Groups Modal"

		Examples:
			| ProjectName 			  | dataset 								 		|
			| FS_Mensal_Dataset_Error | time-series/Mensal/dataset_mensal_alterado.xlsx |

	Scenario Outline: Check available number of series in pick for me
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"		
		And I select "do not set" options in element "Format Date Select"
		And I click the "Add Feature Store Button"
		And I click the "Pick4me Button"
		Then I should see is "greater than" 20 items of "All Checkbox"
		And I should see is "less than" 40 items of "All Checkbox"

		Examples:
			| ProjectName 			 | dataset 				 			   		  |
			| FS_Mensal_Dataset		 | time-series/Mensal/dataset_mensal_fake_1.xlsx |

	Scenario Outline: Check modal Feature Store variables reseted when change Dependent Variable
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"		
		And I select "do not set" options in element "Format Date Select"
		And I click the "Add Feature Store Button"
		And I click the "Pick4me Button"
		And I click "Name" name in "Feature Store Groups Modal"
		And I click "Send series" name in "Feature Store Groups Modal"
		And I click the "Modeling Modal"
		When I select "pmc" options in element "Response Variable Select"
		Then I can see text "Feature Store Variables reseted!" in element "Models Modal"
		And I close the "Models Modal" if exists
		And I can't see any of following text "fs_" in element "Explanatory Variable Select"

		Examples:
			| ProjectName 			| dataset 					 			 | Dependent_variable |
			| FS_Mensal_Variables_1 | time-series/Mensal/dataset_mensal_fake_1.xlsx | pmc				  |

	Scenario Outline: Check if Feature Store integration is disable of user without permission
		Given insert "time_series" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		And I click the "Create Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"		
		And I select "do not set" options in element "Format Date Select"
		Then I wait for element "Add Feature Store Button" be disabled

		Examples:
			| ProjectName 			| dataset 					 			 |
			| FS_Mensal_Variables_1 | time-series/Mensal/dataset_mensal_fake_1.xlsx |
	
	Scenario Outline: Check if Feature Store integration is disable for others frequency
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"		
		And I select "do not set" options in element "Format Date Select"
		Then I wait for element "Add Feature Store Button" be disabled

		Examples:
			| ProjectName 			| dataset 					 	 |
			| TS135_Diario          | time-series/dataset_diario_y_var.xlsx      | 
			| Semanal_Sanity        | time-series/dataset_semanal_fake_2.xlsx    |
			| Quinzenal_Sanity      | time-series/dataset_quinzenal_fake_1.xlsx  |
			| Trimestral_Sanity     | time-series/dataset_trimestral_fake_1.xlsx | 
			| Semestral_Sanity      | time-series/dataset_semestral_fake_1.xlsx  | 
			| Anual_Sanity          | time-series/dataset_anual_fake.xlsx        | 
			