@FORECASTLCOMB
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Explorer - Forecast Combination
	
	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @MODELSPECIFICS
	Scenario Outline: Check Transformation, seasd and graphics for Model Specifics
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "forecastcombination" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "forecastcombination" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then it should be possible to check "<log>" in Forest Transformation of the Model Info
		And it should be possible to check the Actual and Model Fit chart
		And it should be possible to check the Actual and Forecast chart in "<ProjectName>"
		And it should be possible to check if "<has>" the Annual Variation histogram
	    And it should be possible to check if "<has>" the Annual Level histogram
	
		Examples:
			| ProjectName	 		| log   | dummies | ModelList   | has	|
			| UI_Diario_Sanity 		| True  | True    | 2			| False |
			| Semanal_Sanity 		| True  | True    | 3			| True	|
			| Quinzenal_Sanity 		| False | True    | 4			| True	|
			| Sanity_Mensal  		| True  | False   | 5			| True	|
			| Trimestral_Sanity 	| False | True    | 6			| True	|
			| Semestral_Sanity 		| False | False   | 7			| True	|
			| Anual_Sanity 			| True  | False   | 8			| True	|
			| FS_Bimestral_Sanity_1	| True  | True    | 9			| True	|

	@SANITY @F4-790 @CROSSVALIDATION @TS-344
	Scenario Outline: Check Forecast horizon and Windows for Cross Validation
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "forecastcombination" menu in Model Explorer "time series" model
		And access to "crossvalidation" submenu in "forecastcombination" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then it should be possible to check "<forestValue>" in Forecast horizon of the Model Info
		And it should be possible to check "<crossValue>" in Test windows of the Model Info
		And it should be possible to check the "MAPE" chart
		And choose "WMAPE" tab in MAPE chart
		And it should be possible to check the "WMAPE" chart
		And it should be possible to check the "MPE" chart
		And it should be possible to check the "RMSE" chart
	
		Examples:
			| ProjectName	 		| forestValue    | crossValue | ModelList   |
			| UI_Diario_Sanity 		| 3  			 | 3    	  | 2			|
			| Semanal_Sanity 		| 20  			 | 20    	  | 3			|
			| Quinzenal_Sanity 		| 20 			 | 20    	  | 9			|
			| Sanity_Mensal  		| 20  			 | 20   	  | 5			|
			| Trimestral_Sanity 	| 20 			 | 15    	  | 6			|
			| Semestral_Sanity  	| 10 			 | 5   		  | 7			|
			| Anual_Sanity  		| 5  			 | 1   		  | 8			|
			| FS_Bimestral_Sanity_1	| 20  			 | 1    	  | 4			|

	@SANITY @F4-789 @MODELDISPERSION
	Scenario Outline: Check all graphics for Model Dispersion
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "forecastcombination" menu in Model Explorer "time series" model
		And access to "modeldispersion" submenu in "forecastcombination" Model Explorer
		Then it should be possible to find "<BestModel>" in Aggregate Forecast Dispersion Chart
		
		Examples:
			| ProjectName	 		| BestModel   	 | 
			| UI_Diario_Sanity 		| Model 1  		 | 
			| Semanal_Sanity 		| Model 2   	 |
			| Quinzenal_Sanity 		| Model 3 		 | 
			| Sanity_Mensal  		| Model 4  		 | 
			| Trimestral_Sanity 	| Historical 	 | 
			| Semestral_Sanity  	| Model 8  		 | 
			| Anual_Sanity  		| Model 9  		 | 
			| FS_Bimestral_Sanity_1	| Model 10  	 | 
