@BREAKDOWN
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION
Feature: Breakdown

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @USERSELECTION @MODELSPECIFICS @test
	Scenario: Check Model Breakdown exibition - User Selection 
		When find "Sanity_Mensal" project 
		And click to "Sanity_Mensal" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		Then I select "4" options in element "Model List Variable Select"
		And I can see text "Breakdown is only available for the first 3 arima models." in element "Model Breakdown Chart"		
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		And I can see text "Breakdown is only available for the first 3 arima models." in element "Model Breakdown Error HighChart"	
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		And I can see element "Model Breakdown MoM Chart Bar Layer"
		And I can see element "Model Breakdown MoM Chart Scatter Layer"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		And I can see element "Model Breakdown MoM HighChart Bar Layer"
		And I can see element "Model Breakdown MoM HighChart Scatter Layer"
		And I can see text "pmc_a_n" in element "Model Breakdown HighChart"
		And I select frequency "quarterly" in "Explaining the Results Card"
		# And I click the "QOQ Tab Button"
		And I can see text "pmc_a_n" in element "Model Breakdown HighChart"
		And I select frequency "annual" in "Explaining the Results Card"
		# And I click the "YOY Tab Button"
		And I can see text "pmc_a_n" in element "Model Breakdown HighChart"

	@SANITY @TS-409 @USERSELECTION @MODELSPECIFICS
	Scenario Outline: Improve message drilldown for daily, weekly, or biweekly data - User Selection
		When find "<ProjectName>" project 
		And click to "<ProjectName>" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "4" options in element "Model List Variable Select"
		And I can see text "Breakdown is not available for daily, weekly or fortnightly data." in element "Model Breakdown Chart"	
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		And I can see text "Breakdown is not available for daily, weekly or fortnightly data." in element "Model Breakdown Error HighChart"	
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		And I can see text "Breakdown is not available for daily, weekly or fortnightly data." in element "Model Breakdown Chart"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		And I can see text "Breakdown is not available for daily, weekly or fortnightly data." in element "Model Breakdown Error HighChart"

		Examples:
			| ProjectName   	| 
			| UI_Diario_Sanity 	|
			| Semanal_Sanity 	|
			| Quinzenal_Sanity	|
	
	@USERSELECTION @MODELSPECIFICS
	Scenario: Check Model Breakdown tabs for no mensal projects - User Selection
		When find "Anual_Sanity" project 
		And click to "Anual_Sanity" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		Then I wait for element "QOQ Tab Button" be disabled
		And I wait for element "YOY Tab Button" be disabled
		And I can see element "Send to User Selection Button"
		And I click the "Send to User Selection Button"
		And I can see element "See More Information Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		Then I wait for element "Quarterly Frequency Radio" be disabled
		And I wait for element "Annual Frequency Radio" be disabled

	@MODELSPECIFICS @TS-494
	Scenario: Check sum_eps aggregation variable is not renderized
		When find "Trimestral_Sanity" project 
		And click to "Trimestral_Sanity" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		Then I wait for element "QOQ Tab Button" be disabled
		And I wait for element "YOY Tab Button" be disabled
		And I can't see any of following text "sum_eps" in element "Model Breakdown Chart"
		