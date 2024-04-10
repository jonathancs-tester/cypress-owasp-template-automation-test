@ANNUAL_SUMMARY
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: Model and Annual Summary Info

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	Scenario Outline: Check Annual Summary info
        When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "aiselection" menu in Model Explorer "time series" model
		And I wait for element "See More Information Button" be enabled
		And I click the "See More Information Button"
		Then I can see element "Best Model Info Table" is not be empty
		And I can see element "Sample Info Table" is not be empty
		And I can see element "Transformation Info Table" is not be empty
		And I can see element "MAPE Info Table" is not be empty
		And I can see element "WMAPE Info Table" is not be empty
		And I can see element "MPE Info Table" is not be empty
		And I can see element "RMSE Info Table" is not be empty
		And I can see element "MASE Info Table" is not be empty
		And I can see element "MASEs Info Table" is not be empty
		And I can see text "Level" in element "Annual Summary Card"
		And I can see text "Variation" in element "Annual Summary Card"


        Examples:
			 | ProjectName      			| 
			 | UI_FS_Mensal_Sanity_1  		| 
			 | Trimestral_Sanity			|
			 | Semanal_Sanity				| 
			 | Quinzenal_Sanity				| 
			 | dat_temp_more_dates			|		
			 | All_Mensal_4castHub_lag		| 

	Scenario Outline: Check error in Annual Summary info
        When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "aiselection" menu in Model Explorer "time series" model
		And I wait for element "See More Information Button" be enabled
		And I click the "See More Information Button"
		Then I can see element "Best Model Info Table" is not be empty
		And I can see element "Sample Info Table" is not be empty
		And I can see element "Transformation Info Table" is not be empty
		And I can see element "MAPE Info Table" is not be empty
		And I can see element "WMAPE Info Table" is not be empty
		And I can see element "MPE Info Table" is not be empty
		And I can see element "RMSE Info Table" is not be empty
		And I can see element "MASE Info Table" is not be empty
		And I can see element "MASEs Info Table" is not be empty
		And I can see text "Annual series summary is only available for series with at least 1 year of observation." in element "Annual Summary Card"

        Examples:
			| ProjectName      |
			| TS135_Diario     | 

    @USERSELECTION
    Scenario: Check User Selection page accessing a project for the first time
		When find "Sanity_Mensal" project
		And click to "Sanity_Mensal" Model Explorer
        And I wait for element "See More Information Button" be enabled
		And I click the "See More Information Button"
        Then I can see element "Best Model Info Table"