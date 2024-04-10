@CROSS_VALIDATION
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Cross validation - ARIMA

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @CROSSVALIDATION
	Scenario Outline: Check Forecast horizon and Windows for Cross Validation
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "crossvalidation" submenu in "arima" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		And choose "<crossValue>" window in slider in Cross Validation for ARIMA
		Then it should be possible to check "<forestValue>" in Forecast horizon of the Model Info
		And it should be possible to check "<crossValue>" in Test windows of the Model Info
		And it should be possible to check the Cross validation windows charts
		And it should be possible to check the "MAPE" chart
		And choose "WMAPE" tab in MAPE chart
		And it should be possible to check the "WMAPE" chart
		And it should be possible to check the "MPE" chart
		And it should be possible to check the "RMSE" chart
		And it should be possible to check the "MASE" chart
		And it should be possible to check the "MASEs" chart

		Examples:
			| ProjectName           | forestValue | crossValue | ModelList |
			| UI_Diario_Sanity      | 3           | 3          | 2         |
			| Semanal_Sanity        | 20          | 20         | 11        |
			| Quinzenal_Sanity      | 20          | 20         | 6         |
			| Sanity_Mensal         | 20          | 20         | 40        |
			| Trimestral_Sanity     | 20          | 15         | 2         |
			| Semestral_Sanity      | 10          | 5          | 21        |
			| Anual_Sanity          | 5           | 1          | 18        |
			| FS_Bimestral_Sanity_1 | 20          | 1          | 27        |

	@TS-344
	Scenario: Informações incorretas na aba de cross validation das combinações
		And find "Sanity_Mensal" project
		And click to "Sanity_Mensal" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "crossvalidation" submenu in "arima" Model Explorer
		When get Accuracy info in cross validation
		And access to "forecastcombination" menu in Model Explorer "time series" model
		And access to "crossvalidation" submenu in "forecastcombination" Model Explorer
		Then compare Accuracy info in cross validation is different of previous model