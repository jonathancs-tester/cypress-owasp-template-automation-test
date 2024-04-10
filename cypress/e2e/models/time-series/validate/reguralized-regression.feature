@REGULARIZEDREGRESSION
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Explorer - Regularized Regression

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @MODELSPECIFICS
	Scenario Outline: Check Transformation, seasd and graphics for Model Specifics
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "regularizedregression" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "regularizedregression" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then it should be possible to check "<log>" in Transformation of the Model Info
		And it should be possible to check ElasticNet, Ridge or Lasso in Type of the Model Info
		And it should be possible to check "<dummies>" with d4i variable in Model Specification
		And it should be possible to check if "<has>" the Check Residuals charts
		And it should be possible to check the Actual and Model Fit chart
		And it should be possible to check the Actual and Forecast chart in "<ProjectName>"
		And it should be possible to check if "<histogram>" the Annual Variation histogram
		And it should be possible to check if "<histogram>" the Annual Level histogram

		Examples:
			| ProjectName       | log   | dummies | ModelList | has  | histogram |
			| UI_Diario_Sanity     | True  | True    | 1         | True | False     |
			| Semanal_Sanity    | True  | True    | 2         | True | True      |
			| Quinzenal_Sanity  | False | True    | 2         | True | True      |
			| Sanity_Mensal     | True  | False   | 3         | True | True      |
			| Trimestral_Sanity | False | True    | 2         | True | True      |
			| Semestral_Sanity  | False | False   | 2         | True | True      |
			| Anual_Sanity      | True  | False   | 1         | True | True      |

	@MODELSPECIFICS 
	#FS_Bimestral_Sanity_1 has 'd_b' dummy variables instead of d4i
	Scenario: Check Transformation, seasd and graphics for Model Specifics - FS_Bimestral_Sanity_1
		When find "UI_FS_Bimestral_Sanity_1" project 
		And click to "UI_FS_Bimestral_Sanity_1" Model Explorer
		And access to "regularizedregression" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "regularizedregression" Model Explorer
		And I select "2" options in element "Model List Variable Select"
		Then it should be possible to check "True" in Transformation of the Model Info
		And it should be possible to check ElasticNet, Ridge or Lasso in Type of the Model Info
		And it should be possible to check "True" with d_b variable in Model Specification
		And it should be possible to check if "True" the Check Residuals charts
		And it should be possible to check the Actual and Model Fit chart
		And it should be possible to check the Actual and Forecast chart in "<ProjectName>"
		And it should be possible to check if "True" the Annual Variation histogram
		And it should be possible to check if "True" the Annual Level histogram

	@SANITY @CROSSVALIDATION
	Scenario Outline: Check Forecast horizon and Windows for Cross Validation
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "regularizedregression" menu in Model Explorer "time series" model
		And access to "crossvalidation" submenu in "regularizedregression" Model Explorer
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
			| Semanal_Sanity        | 20          | 20         | 2         |
			| Quinzenal_Sanity      | 20          | 20         | 2         |
			| Sanity_Mensal         | 20          | 20         | 3         |
			| Trimestral_Sanity     | 20          | 15         | 2         |
			| Semestral_Sanity      | 10          | 5          | 2         |
			| Anual_Sanity          | 5           | 1          | 1         |
			| FS_Bimestral_Sanity_1 | 20          | 1          | 2         |
