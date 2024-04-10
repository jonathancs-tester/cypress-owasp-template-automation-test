@ELEMENTARY
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Explorer - Elementary
	
	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

    @SANITY
    Scenario Outline: Check Model Specifics in Elementary
        When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "elementary" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "elementary" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then it should be possible to check "<log>" in Transformation of the Model Info
		And it should be possible to check the Actual and Model Fit chart
		And it should be possible to check the Actual and Forecast chart in "<ProjectName>"
		And it should be possible to check if "<has>" the Annual Variation histogram
		And it should be possible to check if "<has>" the Annual Level histogram

        Examples:
			| ProjectName       | log    | ModelList | has   |
			| UI_Diario_Sanity  | True   | 1         | False |
			| Semanal_Sanity    | True   | 2         | True  |
			| Quinzenal_Sanity  | False  | 3         | True  |
			| Sanity_Mensal     | True   | 4         | True  |
			| Quinzenal_Sanity  | False  | 1         | True  |
			| Semestral_Sanity  | False  | 2         | True  |
			| Anual_Sanity      | True   | 2         | True  |

	@TS-488 @TS-463
	Scenario Outline: Dataset should not contain Model Type
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "<Model>" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "<Model>" Model Explorer
		Then check all elementary models texts "<Type>"

		Examples:
			| ProjectName   					| Model					| Type					     |
			| Anual_Sanity 						| elementary			| ARIMA_SEASM,ARIMA_SEASD,-- |
			| diario_without_values_variables 	| elementary			| ARIMA_SEASM,STL,-- 		 |
			| Quinzenal_Sanity					| elementary			| ARIMA_SEASM,--			 |
			| Semanal_Sanity					| elementary			| ARIMA_SEASM,--			 |
			| UI_Diario_Sanity  				| regularizedregression | ElasticNet				 |
			| Semanal_Sanity    				| regularizedregression | ElasticNet				 |
			| Quinzenal_Sanity  				| regularizedregression | ElasticNet				 |
			| dataset_36obs						| elementary			| LM					 	 |
			
	Scenario Outline: Dataset should not contain elementary models
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "<model>" menu in Model Explorer "time series" model
		And I wait for element "Model Explorer Elementary Model Specifics Label" be disabled
		
		Examples:
			| ProjectName   | model 				|
			| Seas_d_false 	| randomforest 			|		
			| Seas_d_false 	| regularizedregression |		
