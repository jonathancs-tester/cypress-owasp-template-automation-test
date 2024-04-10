@SIMULATION
@4INTELLIGENCE @REGRESSION @TIMESERIES
Feature: User Selection - Simulation 

	Background: Login
		Given insert "admin" credentials and login via "MFA"

	@SANITY @API 
	Scenario Outline: Apply Simulation for Security Fix
		And get first "<project>" id
		When simulate fixed variables project using "<forecast>", "<year>", "<variable>", "<values>" info with "<response>"

    	Examples:
			| response 		| project		 | forecast 		     | year 	|	variable  						|	values 			|
			| bad request   | Sanity_Mensal  | forecast_1_industria  | 2020    	|	';env;ps',d_du,pim_n,temp_min_n	|	0.04,-9.17,0.68	|
			| bad request   | Sanity_Mensal  | forecast_1_industria  | 0000		|	d_du,pim_n,temp_min_n			|	0.04,-9.17,0.68	|

	@TS-129 @USERSELECTION
	Scenario: Não deve mostrar a variável do_ como explicativa e não pode ser exportada
		And access main page			
		And access "Models" application
		When find "63fce7818af6757fa3a97aee" project
		And click to "63fce7818af6757fa3a97aee" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		Then I can't see any of following text "do_" in element "Simulation Variables Card"
		And I can't see any of following text "do_" in element "Estimated Coefficients Variables Card"
			
	@USERSELECTION
	Scenario Outline: Verify if explanatory variables in simulation not contain z_
		And access main page			
		And access "Models" application
	    Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		Then I can't see any of following text "z_" in element "Simulation Variables Card"
		And I can't see any of following text "z_" in element "Estimated Coefficients Variables Card"
		
       Examples:
			| ProjectName						|
			| dataset_exp_z						|

	@TS-140 
	Scenario Outline: Check components of the Simulator and Elasticities
		And access main page			
		And access "Models" application
		When find "Sanity_Mensal" project 
		And click to "Sanity_Mensal" Model Explorer
		And access to "<menu>" menu in Model Explorer "time series" model
		And access to "<submenu>" submenu in "<menu>" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		Then I can see element "Simulation Variables Card"
		And I can't see any of following text "%" in element "Estimated Coefficients Variables Card"
		And I can see element "Estimated Coefficients Variables Card"

		Examples:
			| ProjectName				| DependentVariable			| menu                  | submenu        | 
			| Sanity_Mensal				| industria					| arima                 | modelspecifics | 
			| update_bergman_v1_baseline| ic_br_precos_comm_agro_2	| arima                 | modelspecifics | 

	@TS-140 
	Scenario Outline: Check not exists components of the Simulator and Elasticities
		And access main page			
		And access "Models" application
		When find "Sanity_Mensal" project 
		And click to "Sanity_Mensal" Model Explorer
		And access to "<menu>" menu in Model Explorer "time series" model
		And access to "<submenu>" submenu in "<menu>" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		Then I can't see element "Simulation Variables Card"
		And I can't see element "Estimated Coefficients Variables Card"

		Examples:
			| ProjectName				| DependentVariable			| menu                  | submenu        |
			| Sanity_Mensal 			| industria					| regularizedregression | modelspecifics |
			| Sanity_Mensal 			| industria					| forecastcombination   | modelspecifics |
			| Sanity_Mensal 			| industria					| randomforest          | modelspecifics | 

	@SANITY
	Scenario: Check if simulatable data are updated
		And access main page			
		And access "Models" application
		When find "Sanity_Mensal" project 
		And click to "Sanity_Mensal" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		And I use "pmc_a_n" as "name" in template
		And I change the step to 6 on the "User Selection Slider" slider element
		Then I can see element "Simulation Variables Card"
		And I can't see any of following text "%" in element "Estimated Coefficients Variables Card"
		And I can see element "Estimated Coefficients Variables Card"		
		Then I get after info in "Annual Summary Level Table"
		And I click the "Send Simulation Button"
		And I get before info in "Annual Summary Level Table"
		And I compare after info is not equal before info
		And I click the "Restore Simulation Button"

	Scenario: Check if simulatable data are not updated
		And access main page			
		And access "Models" application
		When find "bug_dummies_F4-1412" project 
		And click to "bug_dummies_F4-1412" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		Then I get after info in "Annual Summary Level Table"
		And I click the "Send Simulation Button"
		And I get before info in "Annual Summary Level Table"
		And I compare after info is equal to before info
		# And check if Annual Summary cedules are updated without change slider