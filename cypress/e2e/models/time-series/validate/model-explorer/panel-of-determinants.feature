@PAINEL_DETERMINANTS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Explorer - Painel of Determinants

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @F4-789 @F4-1001 @MODELDISPERSION @TS-152
	Scenario Outline: Check if exists variable and acurracy for Beta View
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		And I click the "N Model Select"
		And I click the "N Model Menu Select[position=last]"
		Then I can see text "<variable>" in element "Beta View Y Values Chart"
		And I can see text "<accuracy>" in element "Beta View Y Values Chart"

		Examples:
			| ProjectName           | variable      | accuracy  |
			| ui_diario_sanity      | cambio        | MAPE (%)  |
			| semanal_sanity        | gm12_dow12    | WMAPE (%) |
			| quinzenal_sanity      | rrp           | MPE (%)   |
			| sanity_mensal         | d_du          | RMSE      |
			| semestral_sanity      | explicativa_1 | MPE (%)   |
			| anual_sanity          | cambio_r      | WMAPE (%) |
			| fs_bimestral_sanity_1 | y_comida2     | MAPE (%)  |
			| ui_fs_mensal_sanity_1 | brl_eur_lag3  | MASE      |
			| ui_fs_mensal_sanity_1 | brl_usd_lag1  | MASEs     |

	@SANITY @F4-789 @F4-1001 @MODELDISPERSION @TS-152
	Scenario Outline: Check if not exists variable and acurracy for Beta View
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		And I click the "N Model Select"
		And I click the "N Model Menu Select[position=last]"
		Then I can't see any of following text "Variables" in element "Beta View Y Values Chart"
		And I can see text "Metrics" in element "Beta View Y Values Chart"
	
		Examples:
			| ProjectName                 | 
			| trimestral_sanity           |
			| contribuicao_anual_pib_agro | 

	@MOD1627
	Scenario Outline: List within list in exclusions losing format
		Given I write "mod1627" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=mod1627;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		And I click the "N Model Select"
		Then check if "<var1>" and "<var2>" variables not found in all models by Beta View

		Examples:
			| var1          | var2          |
			| fs_massa_real | fs_rend_medio |
			| fs_pop_des    | fs_rend_medio |
			| fs_pop_ea     | fs_rend_medio |
			| fs_pop_ocu    | fs_rend_medio |
			| fs_pop_des    | fs_massa_real |
			| fs_pop_ea     | fs_massa_real |
			| fs_pop_ocu    | fs_massa_real |

	@MOD1720 @TS239 @TS-445
	Scenario Outline: Should not include a univariate model in ARIMA
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		And I click the "N Model Select"
		Then check if "not exist" univariate model in Beta View

		Examples:
			| ProjectName      |
			| ui_diario_sanity |
			| quinzenal_sanity |
			| sanity_mensal    |
			| quinzenal_sanity |
			| semestral_sanity |
			| anual_sanity     |

	@MOD1648 @TS-267
	Scenario Outline: Check if at least one model has golden variable
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		And I click the "N Model Select"
		And I click the "N Model Menu Select[position=last]"
		Then I can see text "<variable>" in element "Beta View Y Values Chart"

		Examples:
			| ProjectName           | variable               |
			| ui_fs_mensal_sanity_1 | price_feedstock_3_lag3 |
			| mod1648               | temp_orvalho           |

	@TS-175
	Scenario Outline: Check warnings without 180 observations in Project Overview
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I can see text "<message>" in element "Warning Daily Container"
		Then I click the "Warning Daily Button"

		Examples:
			| ProjectName              | y-name                  | message                                                                                                  |
			| dataset-diario_170_obser | media_7d_hidratado_comb | No dataset has reached the recommended number of observations. Be aware of potential misleading results. |
			| daily_60_observations    | fluxo_dia               | Dataset did not reach the recommended number of observations. Be aware of potential misleading results.  |

	@TS-175
	Scenario Outline: Check warnings without 180 observations in Model Dispersion
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I select "<y-name>" options in element "Dependent Variable Select"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		Then I can see text "<message>" in element "Warning Daily Container"
		And I click the "Warning Daily Button"

		Examples:
			| ProjectName                    | y-name                  | message                                                                                                 |
			| dataset-diario_170_mixed_obser | media_7d_hidratado_comb | Dataset did not reach the recommended number of observations. Be aware of potential misleading results. |

	@SANITY @V3.2 @TS-73
	Scenario Outline: Check pre processamento (pp4i) found exploratory variable
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		And I click the "N Model Select"
		And I click the "N Model Menu Select[position=last]"
		Then I can see text "<variable>" in element "Beta View Y Values Chart"

		Examples:
			| ProjectName | variable |
			| ts-73-tc01  | z_gap    |
			| ts-73-tc4   | x_pib_rj |
			| ts-73-tc8   | diesel   |
			| ts-73-tc9   | v_comb   |

	@SANITY @V3.2 @TS-73
	Scenario Outline: Check pre processamento (pp4i) not found exploratory variable
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modeldispersion]"
		When I click the "N Model Select"
		And I click the "N Model Menu Select[position=last]"
		Then I can't see any of following text "<variable>" in element "Beta View Y Values Chart"

		Examples:
			| ProjectName | variable |
			| ts-73-tc2   | footer   |
			| ts-73-tc5   | z_diesel |
			| ts-73-tc9   | xagropec |
			| ts-73-tc12  | v_comb   |