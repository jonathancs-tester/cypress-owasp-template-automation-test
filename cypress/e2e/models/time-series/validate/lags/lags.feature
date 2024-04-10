@LAGS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION
Feature: Validate lags variables

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

    Scenario Outline: Check add lags with errors
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<datasetName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		When I click the "Add Lags Button"
		And I write "<lag_number>" text in element "Lag Number Input"
		And I can see element "Error Validation Icon Input"
		Then I can see text "<message>" in element "Lag Search Modal"
		And I wait for element "Confirm Lags Button" be disabled
		
		Examples:
			| datasetName           | lag_number | dataset                     			   		  | message                        			   |
			| FS_Diario_Download_1  | clear      | time-series/dataset_diario_fake_1.xlsx  		  | You must specify a number	   			   |
			| FS_Diario_Download_1  | 8          | time-series/dataset_diario_fake_1.xlsx  		  | Lag number must be equal or less than 7    |
			| FS_Diario_Download_1  | 0          | time-series/dataset_diario_fake_1.xlsx  		  | Lag number must be equal or greater than 1 |
			| FS_Semanal_Download_1 |-2          | time-series/dataset_semanal_fake_1.xlsx 		  | Lag number must be equal or greater than 1 |
			| FS_Semanal_Download_1 | 10         | time-series/dataset_semanal_fake_1.xlsx 		  | Lag number must be equal or less than 3    |
			| FS_Mensal_Download_1  |-1          | time-series/Mensal/dataset_mensal_fake_1.xlsx  | Lag number must be equal or greater than 1 |
			| FS_Mensal_Download_1  | 4          | time-series/Mensal/dataset_mensal_fake_1.xlsx  | Lag number must be equal or less than 3    |

	Scenario Outline: Check available variables in add lags
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<datasetName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I click the "Delete Explanatory Variables Button"
		Then I wait for element "Add Lags Button" be disabled

		Examples:
			| datasetName           | dataset                    			  |
			| FS_Diario_Download_1  | time-series/dataset_diario_fake_1.xlsx  |
			| FS_Semanal_Download_1 | time-series/dataset_semanal_fake_1.xlsx |
			| FS_Mensal_Download_1  | time-series/Mensal/dataset_mensal_fake_1.xlsx  |

	@TS-284
	Scenario Outline: Check add lags correctly
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<datasetName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"	
		When I click the "Add Lags Button"
		And I write "<lag_number>" text in element "Lag Number Input"
		And I select "Select all" options in element "Choose Variables(s) Lags Button"
		When I click the "Confirm Lags Button"
		And I click the "Final Settings Button"
		And I can see element "Final Settings Card"

		Examples:
			| datasetName           	| lag_number | dataset               			       	|
			| FS_Diario_Download_1  	| 7          | time-series/dataset_diario_fake_1.xlsx  	|
			| FS_Semestral_Download_1 	| 3          | time-series/dataset_semestral_fake_1.xlsx|
			| FS_Mensal_Download_1  	| 1          | time-series/Mensal/dataset_mensal_fake_1.xlsx  	|
