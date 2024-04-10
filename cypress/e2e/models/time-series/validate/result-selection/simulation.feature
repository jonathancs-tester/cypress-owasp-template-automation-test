@SIMULATION
@4INTELLIGENCE @REGRESSION @TIMESERIES @USERSELECTION
Feature: User Selection - Simulation

	Background: Login
		Given insert "admin" credentials and login via "MFA"

	@TS-129 @USERSELECTION
	Scenario: Não deve mostrar a variável do_ como explicativa e não pode ser exportada
		And I visit "/"		
		And I click the "Models"
		And I click the "Search Project"
		And I write "63fce7818af6757fa3a97aee" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=63fce7818af6757fa3a97aee;position=first]"
		When I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		Then I can't see any of following text "do_" in element "Simulation Variables Card"
		And I can't see any of following text "do_" in element "Estimated Coefficients Variables Card"

	@USERSELECTION
	Scenario Outline: Verify if explanatory variables in simulation not contain z_
		Given I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		Then I can't see any of following text "z_" in element "Simulation Variables Card"
		And I can't see any of following text "z_" in element "Estimated Coefficients Variables Card"

		Examples:
			| ProjectName   |
			| dataset_exp_z |

	@TS-140
	Scenario Outline: Check components of the Simulator and Elasticities
		Given I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		And I write "sanity_mensal" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=sanity_mensal;position=first]"
		When I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=<submenu>]"
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		Then I can see element "Simulation Variables Card"
		And I can't see any of following text "%" in element "Estimated Coefficients Variables Card"
		And I can see element "Estimated Coefficients Variables Card"

		Examples:
			| ProjectName                | DependentVariable        | menu  | submenu        |
			| Sanity_Mensal              | industria                | arima | modelspecifics |
			| update_bergman_v1_baseline | ic_br_precos_comm_agro_2 | arima | modelspecifics |

	@TS-140
	Scenario Outline: Check not exists components of the Simulator and Elasticities
		Given I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		And I write "sanity_mensal" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=sanity_mensal;position=first]"
		When I click the "Menu Model Explorer[index=<menu>]"
		And I click the "Menu Model Explorer[index=<submenu>]"
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		Then I can't see element "Simulation Variables Card"
		And I can't see element "Estimated Coefficients Variables Card"

		Examples:
			| ProjectName   | DependentVariable | menu                  | submenu        |
			| Sanity_Mensal | industria         | regularizedregression | modelspecifics |
			| Sanity_Mensal | industria         | forecastcombination   | modelspecifics |
			| Sanity_Mensal | industria         | randomforest          | modelspecifics |

	@SANITY
	Scenario: Check if simulatable data are updated
		Given I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		And I write "sanity_mensal" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=sanity_mensal;position=first]"
		When I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I use "pmc_a_n" as "name" in template
		And I change the step to 6 on the "Slider" slider element
		Then I can see element "Simulation Variables Card"
		And I can't see any of following text "%" in element "Estimated Coefficients Variables Card"
		And I can see element "Estimated Coefficients Variables Card"
		Then I get after info in "Annual Summary Level Table"
		And I click the "Send Simulation Button"
		And I intercept "**/simulations" route as "simulations" with "GET" http verbs
		And I wait "@simulations" routes
		And I get before info in "Annual Summary Level Table"
		And I compare after info is not equal before info
		And I click the "Restore Simulation Button"

	Scenario: Check if simulatable data are not updated
		Given I visit "/"	
		And I click the "Models"
		And I click the "Search Project"
		And I write "bug_dummies_f4-1412" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=bug_dummies_f4-1412;position=first]"
		When I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "1" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		Then I get after info in "Annual Summary Level Table"
		And I click the "Send Simulation Button"
		And I intercept "**/simulations" route as "simulations" with "GET" http verbs
		And I wait "@simulations" routes
		And I get before info in "Annual Summary Level Table"
		And I compare after info is equal deep to before info

	@API
	Scenario Outline: Apply Simulation for Security Fix
		And get first "<project>" id
		When simulate fixed variables project using "<forecast>", "<year>", "<variable>", "<values>" info with "<response>"

		Examples:
			| response    | project       | forecast             | year | variable                        | values          |
			| bad request | Sanity_Mensal | forecast_1_industria | 2020 | ';env;ps',d_du,pim_n,temp_min_n | 0.04,-9.17,0.68 |
			| bad request | Sanity_Mensal | forecast_1_industria | 0000 | d_du,pim_n,temp_min_n           | 0.04,-9.17,0.68 |
