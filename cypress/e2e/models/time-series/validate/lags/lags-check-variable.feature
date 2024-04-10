@LAGS_CHECK_VARIABLE
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @LAGS
Feature: Lags - Check Variable

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"
	
	Scenario Outline: Check number of variables and delete
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
		Then I click the "Confirm Lags Button"
		And I click the "Add Lags Button"
		And I can see text list "<variable>" in element "Choose Variables(s) Lags Button"
		And I can see text "<lag_number>" attribute value in element "Lag Number Input"
		And I click the "Cancel Lags Button"
		And I click the "Delete Explanatory Variables Button"
		Then I can see element "Warning Icon"
		And I can see text "Lags Reseted!" in element "h1"
		And I can see text "It was necessary to clear your lag variables selection. Please configure again." in element "p"

		Examples:
			| datasetName          | lag_number | dataset                    			 | variable  								|
			| FS_Diario_Download_1 | 1          | time-series/dataset_diario_fake_1.xlsx | avg_temp_ex;z_chuva_ex;d_vesp_natal_mod7 | 
			| FS_Diario_Download_1 | 3          | time-series/dataset_diario_fake_1.xlsx | avg_temp_ex;z_chuva_ex;d_vesp_natal_mod7 |
			| FS_Diario_Download_1 | 7          | time-series/dataset_diario_fake_1.xlsx | avg_temp_ex;z_chuva_ex;d_vesp_natal_mod7 |
		
	Scenario Outline: Check if the lagged variables are being erased when change the data
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "FS_Erase_Lags" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I select "dd/MM/yyyy" options in element "Format Date Select"
		When I click the "Add Lags Button"
		And I write "<lag_number>" text in element "Lag Number Input"
		And I select "Select all" options in element "Choose Variables(s) Lags Button"
		When I click the "Confirm Lags Button"
		And I select "dd/MM/yyyy" options in element "Format Date Select"
		Then I can see element "Warning Icon"
		And I can see text "Lags Reseted!" in element "h1"
		And I can see text "It was necessary to clear your lag variables selection. Please configure again." in element "p"

		Examples:
			| lag_number | dataset                     			|
			| 3          | time-series/dados_teste_dates.xlsx 	|
		
	Scenario Outline: Check if the lagged variables are being erased when change the dependent variable
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "FS_Erase_Lags" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I select "dd/MM/yyyy" options in element "Format Date Select"
		When I click the "Add Lags Button"
		And I write "<lag_number>" text in element "Lag Number Input"
		And I select "Select all" options in element "Choose Variables(s) Lags Button"
		When I click the "Confirm Lags Button"
		And I click the "Response Variable Select"
		And I click "<Dependent_variable>" name in "Response Variable Select"
		Then I can see element "Warning Icon"
		And I can see text "Lags Reseted!" in element "h1"
		And I can see text "It was necessary to clear your lag variables selection. Please configure again." in element "p"

		Examples:
			| lag_number | dataset             			        | Dependent_variable |
			| 3          | time-series/dados_teste_dates.xlsx 	| z_du			    |
	
	Scenario Outline: Check if the lagged variables are being erased when change the date variable
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "FS_Erase_Lags" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I select "dd/MM/yyyy" options in element "Format Date Select"
		When I click the "Add Lags Button"
		And I write "<lag_number>" text in element "Lag Number Input"
		And I select "Select all" options in element "Choose Variables(s) Lags Button"
		When I click the "Confirm Lags Button"
		And I select "<Date_variable>" options in element "Time Feature Date"
		Then I can see element "Warning Icon"
		And I can see text "Lags Reseted!" in element "h1"
		And I can see text "It was necessary to clear your lag variables selection. Please configure again." in element "p"

		Examples:
			| lag_number | dataset                     		 			  | Date_variable |
			| 3          | time-series/dados_teste_dates_2_Dates.xlsx 	  | data_test	  |
