@HISTORICAL_FORECAST
@4INTELLIGENCE @UI @CREATEPROJECT @STEP3 @TIMESERIES @REGRESSION @MODELLING

Feature: Final Settings - Historical Forecast

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @F4-465 @F4-476 @F4-477 @F4-524 @F4-1404 @TS-13
	Scenario Outline: Check metrics and date for Forecast Optimizes Period
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "<dateFormat>" options in element "Format Date Select"
		And I click the "Final Settings Button"
		And I can see element "Custom Period Toggle"
		And I close the "Feature Selection Modal" if exists
		And I close the "Data Processing Modal" if exists
		When I can see text list "<metrics>" in element "Historical Forecast Chart"
		And I can see text list "<date>" in element "Historical Forecast Chart"
		And I set "Custom Period Toggle" to checked
		And I change the value to "<forestDefault>" from "<forestValue>" on the "Forecast Horizon Slider" slider element
		When I click the "Fine Tunning Button"
		And I can see text "<crossDefault>" attribute value in element "Cross Validation Input"
		And I write "<crossValue>" text in element "Cross Validation Input"
		And I click the "Fine Tunning Confirm Button"
		Then I can see text list "<dateChanged>" in element "Historical Forecast Chart"

		Examples:
			| ProjectName 		   | dataset 										| dateFormat  |forestDefault | crossDefault | forestValue | crossValue | metrics 								| date      	 |  dateChanged 	|
			| Diario_Sanity        | time-series/dataset_diario_fake_4.xlsx     	| do not set  | 7			| 103		   | 3           | 3          |	Historical;Forecast;Total;Optimized		| July 31   	 |	August 03 		|
			| Semanal_Sanity       | time-series/dataset_semanal_fake_2.xlsx    	| do not set  | 52			| 23		   | 20          | 20         |	Historical;Forecast;Total				| September 27   |	February 14		|
			| Quinzenal_Sanity     | time-series/dataset_quinzenal_fake_1.xlsx  	| do not set  | 26			| 14		   | 20          | 20         |	Historical;Forecast;Total				| December 30    |	September 21	|
			| Sanity_Mensal        | time-series/Mensal/dataset_mensal_fake_3.xlsx  | do not set  | 12			| 12		   | 20          | 20     	  |	Historical;Forecast;Total;Optimized		| December;2019  |	August;2021		|
			| Trimestral_Sanity    | time-series/dataset_trimestral_fake_1.xlsx 	| yyyy-MM-dd  | 4			| 12		   | 20          | 15         |	Historical								| January   	 |  January;2020	|
			| Semestral_Sanity     | time-series/dataset_semestral_fake_1.xlsx  	| do not set  | 2			| 8		   	   | 10          | 5          |	Historical;Forecast;Total;Optimized		| July  		 |	July;2020		|
			| Anual_Sanity         | time-series/dataset_anual_fake.xlsx        	| do not set  | 1			| 5		  	   | 5           | 1          |	Historical;Forecast;Total;Optimized		| January   	 |	January;2024	|
			| NoExploratory_Sanity | time-series/no_explanatory_variables.xlsx  	| do not set  | 12			| 12		   | 20          | 20         |	Historical;Forecast;Total;Optimized		| January   	 |	September;2021	|
			| bug_dummies_F4-1412  | time-series/test_fs_wd-step2.xlsx 				| do not set  | 12			| 12		   | 12          | 12         |	Historical;Forecast;Total				| February  	 |	February;2021	|
			| Modeling_F4-1427     | time-series/dataset_fs_trimestral_fake_1.xlsx  | yyyy-MM-dd  | 4			| 12		   | 10          | 20         |	Historical;Forecast;Total;Optimized		| April  		 |	October;2021	|
			| Many_variables       | time-series/Mensal/vazao_sf.xlsx               | do not set  | 12			| 12		   | 10          | 20 		  |	Historical								| September   	 |	September		|
