@DOWNLOAD-DATASET
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION
Feature: Download Dataset

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page
		And access "Models" application

	@TS-365 @FORECASTCOMBINATION
	Scenario: Check the projection of the export of the forecast combination
		When find "Semanal_Sanity" project
		And click to "Semanal_Sanity" Model Explorer
		And access to "userselection" menu in Model Explorer "time series" model
		Then click to download dataset containing the historical series and check "4i_period" columns with "historical" rows
		And click to download dataset containing the historical series and check "data_tidy" columns with "2022-01-02" rows
		And click to download dataset containing the historical series and check "brazil_cooking_cooker_4" columns with "10,9679" rows

	@LAGS
	Scenario Outline: Check variables and lags should be visible in excel downloaded
		And start a new project creation
		And select "time-series" projects
		And insert "<datasetName>" at "ProjectName" field
		And upload a valid "<dataset>" dataset and go to step 2
		And select "yyy-MM-dd" as DateTime format
		When I click the "Add Lags Button"
		And I write "<lag_number>" text in element "Lag Number Input"
		And I select "Select all" options in element "Choose Variables(s) Lags Button"
		Then I wait for element "Confirm Lags Button" be disabled
		When I click the "Confirm Lags Button"
		And click to download dataset and check "<variable>" variables and lags with "<lag_number>" lag number

		Examples:
			| datasetName          | lag_number | dataset                                | variable                                 |
			| FS_Diario_Download_1 | 1          | time-series/dataset_diario_fake_1.xlsx | avg_temp_ex,z_chuva_ex,d_vesp_natal_mod7 |
			| FS_Diario_Download_1 | 3          | time-series/dataset_diario_fake_1.xlsx | avg_temp_ex,z_chuva_ex,d_vesp_natal_mod7 |
			| FS_Diario_Download_1 | 7          | time-series/dataset_diario_fake_1.xlsx | avg_temp_ex,z_chuva_ex,d_vesp_natal_mod7 |
