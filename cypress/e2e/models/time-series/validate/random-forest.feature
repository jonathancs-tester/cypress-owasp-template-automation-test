@RANDOMFOREST
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Explorer - Random Forest

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @MODELSPECIFICS
	#Random Forest 'log' parameter: Transformation is not mandatory. If it is showed must be 'Diff' data
	Scenario Outline: Check Transformation, seasd and graphics for Model Specifics
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "randomforest" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "randomforest" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		And choose the Variable Importance to "<VariableImportance>"
		Then it should be possible to check "<log>" in Random Transformation of the Model Info
		And it should be possible to check the "<VariableImportance>" variables importance in IncMSE Chart
		And it should be possible to check the Actual and Model Fit chart
		And it should be possible to check the Actual and Forecast chart in "<ProjectName>"
		And it should be possible to check if "<has>" the Annual Variation histogram
		And it should be possible to check if "<has>" the Annual Level histogram

		Examples:
			| ProjectName           | log   | dummies | ModelList | VariableImportance | has   |
			| UI_Diario_Sanity      | False | True    | 1         | 2                  | False |
			| Semanal_Sanity        | True  | True    | 1         | 2                  | True  |
			| Quinzenal_Sanity      | False | True    | 1         | 3                  | True  |
			| Sanity_Mensal         | True  | False   | 1         | 4                  | True  |
			| Semestral_Sanity      | False | False   | 1         | 6                  | True  |
			| Anual_Sanity          | False | False   | 1         | 7                  | True  |
			| FS_Bimestral_Sanity_1 | True  | True    | 1         | 8                  | True  |
			| Modeling_F4-1427 		| True  | False   | 1         | 8                  | True  |

	@SANITY @CROSSVALIDATION
	Scenario Outline: Check Forecast horizon and Windows for Cross Validation
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "randomforest" menu in Model Explorer "time series" model
		And access to "crossvalidation" submenu in "randomforest" Model Explorer
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

		Examples:
			| ProjectName           | forestValue | crossValue | ModelList |
			| UI_Diario_Sanity      | 3           | 3          | 1         |
			| Semanal_Sanity        | 20          | 20         | 1         |
			| Quinzenal_Sanity      | 20          | 20         | 1         |
			| Sanity_Mensal         | 20          | 20         | 1         |
			| Semestral_Sanity      | 10          | 5          | 1         |
			| Anual_Sanity          | 5           | 1          | 1         |
			| FS_Bimestral_Sanity_1 | 20          | 1          | 1         |
			| ts505_dataset_target 	| 1           | 1          | 1         |
			
	# @MOD1623 -> precisa criar a request pelo cypress.config (card https://4intelligenceds.atlassian.net/browse/TS-218)
	# Scenario: run_update quebrando quando único modelo no fp é um Random Forest
	# 	When find "mod1623" project 
	# 	And click to "mod1623" Model Explorer
	# 	Then it should be possible to find "Random Forest" in Model Summary
	# 	And it should not be possible to find "ARIMA" in Model Summary
	# 	And it should not be possible to find "Regularized Regression" in Model Summary
	# 	And it should not be possible to find "Forecast Combination" in Model Summary

	@MOD1510
	Scenario Outline: Valores negativos no Random Forest quando a série é só positiva
		When find "mod1510" project 
		And click to "mod1510" Model Explorer
		And select "<y-name>" dependent variable
		And access to "randomforest" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "randomforest" Model Explorer
		Then check if y_fit not contain values less than 0 in Actual vs Model Fit Series

		Examples:
			|	y-name		|
			|	caminhoes	|