@MODELLING_TIME_SERIES
@4INTELLIGENCE @CREATEPROJECT @TIMESERIES @REGRESSION @MODELLING

Feature: Modeling - Send your project

	Background: Login
		Given insert "admin" credentials and login via "MFA"

	@SANITY @UI @TS-13 @TS-347
	Scenario Outline: Modeling default datasets from UI
		And access main page
		And access "Models" application
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "<dateFormat>" options in element "Format Date Select"
		And I click the "Final Settings Button"
		And I wait for element "Custom Period Toggle" be enabled
		And I close the "Data Processing Modal" if exists
		And I set "Custom Period Toggle" to checked
		And I change the value to "<forestDefault>" from "<forestValue>" on the "Forecast Horizon Slider" slider element
		When I click the "Fine Tunning Button"
		And I can see text "<crossDefault>" attribute value in element "Cross Validation Input"
		And I write "<crossValue>" text in element "Cross Validation Input"
		And I set "Apply Log Toggle" to <log>
		And I set "Add Seasonal Dummies Toggle" to <dummies>
		And I click the "Ranking Criteria Tab"
		And I select "<accuracy>" options in element "Accuracy Criteria Select"
		And I select "<cross>" options in element "Cross Validation Summary Select"
		And I click the "Explanatory Features Tab"
		And I set "Avoid Collinearity Toggle" to <avoid>
		And I set "Explanatory Variables Auto - Forecast Toggle" to <auto_expl>
		And I set "Allow Drift Toggle" to <drift>
		And I click the "Configure Exclusion Tab"
		And I select list "<group 1>" options in element "Group 1"
		And I select list "<group 2>" options in element "Group 2"
		And I select list "<group 3>" options in element "Group 3"
		And I click the "Feature Selection Tab"
		And I select "<g.variables>" options in element "Golden Variable Select"
		And I click the "Fine Tunning Confirm Button"
		And I click the "Modeling Button"
		And I can see text "You'll receive an email informing when the job is finished." in element "Modeling Description Modal"
		And I close the "Modeling Modal" if exists

		Examples:
			| ProjectName           | dataset                            	 		| dateFormat | forestDefault 	| crossDefault | forestValue | crossValue | log     | dummies   | accuracy | cross  | avoid   	| auto_expl | drift   | group 1         								| group 2    			| group 3       | g.variables |
			| UI_Diario_Sanity     	| time-series/dataset_diario_fake_4.xlsx 		| do not set | 7				| 103		   | 3           | 3          | checked | checked   | MAPE     | Median | unchecked | checked   | checked | do not set      								| z_tem_max;z_tem_min   | do not set    | do not set  |
			| Golden_Var_Without_FS | time-series/dataset_anual_fake.xlsx 	 		| do not set | 1             	| 5            | 5           | 1          | checked | unchecked | WMAPE    | Median | checked 	| checked   | checked | pib_tot;pib_fam 								| do not set 			| pib_ind;pib_x | ipca        |
			| Massa_Com_Exclusao   	| time-series/Mensal/dataset_massarenda.xlsx 	| yyyy-MM-dd | 12 				| 12 		   | 12          | 12         | checked | checked   | MAPE     | Mean   | checked 	| unchecked | checked | massahabitual;rendanacionalbruta;rendahabitual 	| do not set 			| do not set 	| do not set  |
			| Massa_Sem_Exclusao   	| time-series/Mensal/dataset_massarenda.xlsx 	| yyyy-MM-dd | 12 				| 12 		   | 12          | 12         | checked | checked   | MAPE     | Mean   | checked 	| unchecked | checked | do not set  									| do not set 			| do not set 	| do not set  |
			| dataset_with_no_date 	| time-series/dataset_with_no_date.xlsx      	| do not set | 7       			| 53		   | 7			 | 53		  | checked | checked   | MAPE     | Mean   | checked 	| unchecked | checked | do not set 										| do not set 			| do not set    | do not set  |

	@SANITY @UI @TS-13
	Scenario Outline: Modeling datasets with Feature Selection from UI
		And access main page
		And access "Models" application
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "<dateFormat>" options in element "Format Date Select"
		And I click the "Final Settings Button"
		And I wait for element "Custom Period Toggle" be enabled
		And I close the "Feature Selection Modal" if exists
		And I close the "Data Processing Modal" if exists
		And I set "Custom Period Toggle" to checked
		And I change the value to "<forestDefault>" from "<forestValue>" on the "Forecast Horizon Slider" slider element
		When I click the "Fine Tunning Button"
		And I can see text "<crossDefault>" attribute value in element "Cross Validation Input"
		And I write "<crossValue>" text in element "Cross Validation Input"
		And I set "Apply Log Toggle" to <log>
		And I set "Add Seasonal Dummies Toggle" to <dummies>
		And I click the "Ranking Criteria Tab"
		And I select "<accuracy>" options in element "Accuracy Criteria Select"
		And I select "<cross>" options in element "Cross Validation Summary Select"
		And I click the "Explanatory Features Tab"
		And I set "Avoid Collinearity Toggle" to <avoid>
		And I set "Explanatory Variables Auto - Forecast Toggle" to <auto_expl>
		And I set "Allow Drift Toggle" to <drift>
		And I click the "Configure Exclusion Tab"
		And I select list "<group 1>" options in element "Group 1"
		And I select list "<group 2>" options in element "Group 2"
		And I select list "<group 3>" options in element "Group 3"
		And I click the "Feature Selection Tab"
		And I set "Lasso Toggle" to <lasso>
		And I set "Random Forest Toggle" to <random>
		And I set "Correlation Filter Toggle" to <correlation>
		And I select "<g.variables>" options in element "Golden Variable Select"
		And I click the "Fine Tunning Confirm Button"
		And I click the "Modeling Button"
		And I can see text "You'll receive an email informing when the job is finished." in element "Modeling Description Modal"
		And I close the "Modeling Modal" if exists

		Examples:
			| ProjectName              | dataset                                       		| dateFormat | forestDefault | crossDefault | forestValue | crossValue | log  	  | dummies 	| accuracy | cross  | avoid 	| auto_expl  | drift  	  | group 1                   | group 2           | group 3     | lasso    | random    | correlation | g.variables            |
			| UI_FS_Bimestral_Sanity_1 | time-series/dataset_fs_bimestral_fake_1.xlsx  		| do not set | 6             | 6            | 20          | 1          | checked  | checked    	| MPE      | Mean   | unchecked | checked    | checked    | do not set                | pmc;pim           | abpo;serasa | checked  | unchecked | unchecked   | do not set             |
			| UI_FS_Bimestral_Sanity_2 | time-series/dataset_fs_bimestral_fake_1.csv   		| dd/MM/yyyy | 6             | 6            | 20          | 1          | unchecked| checked    	| RMSE     | Median | checked   | checked    | checked    | do not set                | linguica;salsicha | do not set  | checked  | unchecked | checked     | do not set             |
			| UI_FS_Mensal_Sanity_1    | time-series/Mensal/dataset_fs_mensal_fake_3.xlsx 	| do not set | 12            | 12           | 12          | 2          | checked  | unchecked  	| RMSE     | Median | unchecked | unchecked  | checked    | brl_usd_lag1;brl_eur_lag1 | do not set        | do not set  | checked  | checked   | unchecked   | price_feedstock_3_lag3 |
			| UI_FS_Mensal_Sanity_2    | time-series/Mensal/dataset_fs_mensal_fake_4.xlsx 	| do not set | 12            | 12           | 20          | 20         | unchecked| checked    	| WMAPE    | Median | unchecked | unchecked  | checked    | fog_1;fog_2               | fog_3;fog_4       | ckt;fe      | checked  | checked   | unchecked   | do not set             |

	Scenario Outline: Check send variables Feature Store to Faas and modeling project
		And I use "sanity-time-series" as "name" in template
		And access main page
		And access "Models" application
		And delete "sanity-time-series" garbage in "4i favorites"
		And access main page
		And access "Feature Store" application
		And I click the "Favorites Button"
		And I click the "4I Favorites Button"
		And I click the "Create New Group Button"
		And I write "sanity-time-series-${browser}" text in element "Group Name Input"
		And I write "sanity-time-series-${browser}" text in element "Group Description Input"
		And I click the "Create New Group Confirm Button"
		And I click the "Group Name Card"
		And I wait for element "Search Indicatiors Button" be enabled
		And I click the "Search Indicatiors Button"
		And I click "Japan" name in "Sub Category FS Menu"
		And I wait for element "Indicator Card" be enabled
		And I click "JPN - NIKKEI225" name in "Indicator Card"
		And I select "Monthly" options in element "Frequency Serie Select"
		And I click the "Send to Group Button"
		And I click the "Continue Button"
		And I click the "4I Favorites Tab"
		And I click the "Group Name Card"
		And I click the "Add Button"
		And I click the "Go to Group Button"
		When access "Models" app menu
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "do not set" options in element "Format Date Select"
		And I click the "Add Feature Store Button"
		And I click the "4I Favorites Tab"
		And I click the "Group Name Card"
		And I click "JPN - NIKKEI225" name in "Models Modal"
		And I click the "Send to Group Button"
		And I close the "Modeling Modal" if exists
		And I can see text "<variables>" in element "Explanatory Variable Select"
		And I click the "Final Settings Button"
		And I wait for element "Custom Period Toggle" be enabled
		And I click the "Modeling Button"
		And I can see text "You'll receive an email informing when the job is finished." in element "Modeling Description Modal"
		And I close the "Modeling Modal" if exists
		And access "Feature Store" app menu
		And I click the "Favorites Button"
		And I click the "4I Favorites Button"
		And I click the "Group Card Menu" 
		And I click the "Group Card Delete Menu" 
		And I write "sanity-time-series-${browser}" text in element "Delete Group Input"
		And I click the "Delete Confirm Button"

		Examples:
			| ProjectName              | dataset                                       | group              | variables          |
			| UI_FS_Mensal_Variables_1 | time-series/Mensal/dataset_mensal_fake_1.xlsx | sanity-time-series | fs_nikkei225_jp_1	 |

	@API
	Scenario Outline: Modeling project from API
		When upload dataset '<dataset>' with '<ProjectName>' project name
		And select variables with '<dateFormat>' date format
		And validate dataset
		Then send modeling with configs '<forestValue>', '<crossValue>', '<log>', '<dummies>', '<i.crit>', '<accuracy>', '<cross>', '<avoid>', '<auto_expl>', '<group 1>', '<group 2>', '<group 3>', '<lasso>', '<random>', '<correlation>', '<goldenVar>'

		Examples:
			| ProjectName                        | dataset                                               | dateFormat | forestValue | crossValue | log   | dummies | i.crit | accuracy | cross  | avoid | auto_expl | group 1                                                                                                                                                                                                  | group 2                     | group 3                     | lasso | random | correlation | goldenVar                     |
			| TS135_Diario                       | dataset_diario_y_var.xlsx                             | yyyy-MM-dd | 3           | 3          | True  | True    | BIC    | MAPE     | Median | False | True      | do not set                                                                                                                                                                                               | z_tem_max,z_tem_min         | do not set                  | True  | True   | True        | do not set                    |
			| Semanal_Sanity                     | dataset_semanal_fake_2.xlsx                           | yyyy-MM-dd | 20          | 20         | True  | True    | AIC    | WMAPE    | Mean   | True  | True      | z_tt1,z_tt2                                                                                                                                                                                              | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| Quinzenal_Sanity                   | dataset_quinzenal_fake_1.xlsx                         | yyyy-MM-dd | 20          | 20         | False | True    | AIC    | MAPE     | Median | True  | True      | rrp,rrp_negative                                                                                                                                                                                         | rrp_positive,solar_exposure | do not set                  | True  | True   | True        | do not set                    |
			| Sanity_Mensal                      | Mensal/dataset_mensal_fake_3.xlsx                     | yyyy-MM-dd | 20          | 20         | True  | False   | BIC    | MPE      | Mean   | True  | False     | do not set                                                                                                                                                                                               | rendar,massa_r              | pmc_a_n,pim_n               | True  | True   | True        | do not set                    |
			| Trimestral_Sanity                  | dataset_trimestral_fake_1.xlsx                        | yyyy-MM-dd | 20          | 15         | False | True    | BIC    | WMAPE    | Mean   | False | True      | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| Semestral_Sanity                   | dataset_semestral_fake_1.xlsx                         | yyyy-MM-dd | 10          | 5          | False | False   | BIC    | WMAPE    | Mean   | False | False     | explicativa_2,explicativa_3                                                                                                                                                                              | explicativa_4,explicativa_5 | explicativa_7,explicativa_8 | True  | True   | True        | do not set                    |
			| Anual_Sanity                       | dataset_anual_fake.xlsx                               | yyyy-MM-dd | 5           | 1          | True  | False   | BIC    | WMAPE    | Median | True  | True      | pib_tot,pib_fam                                                                                                                                                                                          | do not set                  | pib_ind,pib_x               | True  | True   | True        | do not set                    |
			| NoExploratory_Sanity               | no_explanatory_variables.xlsx                         | yyyy-MM-dd | 20          | 20         | True  | True    | BIC    | WMAPE    | Median | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| bug_dummies_F4-1412                | test_fs_wd-step2.xlsx                                 | yyyy-MM-dd | 12          | 12         | True  | True    | AIC    | MAPE     | Mean   | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| Modeling_F4-1427                   | dataset_fs_trimestral_fake_1.xlsx                     | yyyy-MM-dd | 10          | 20         | True  | True    | BIC    | WMAPE    | Median | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| Many_variables                     | Mensal/vazao_sf.xlsx                                  | yyyy-MM-dd | 10          | 20         | True  | True    | BIC    | WMAPE    | Median | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| FS_Bimestral_Sanity_1              | dataset_fs_bimestral_fake_1.xlsx                      | yyyy-MM-dd | 20          | 1          | True  | True    | AIC    | MPE      | Mean   | False | True      | do not set                                                                                                                                                                                               | pmc,pim                     | abpo,serasa                 | True  | False  | False       | do not set                    |
			| FS_Bimestral_Sanity_2              | dataset_fs_bimestral_fake_1.csv                       | dd/MM/yyyy | 20          | 1          | False | True    | BIC    | RMSE     | Median | True  | True      | do not set                                                                                                                                                                                               | linguica,salsicha           | do not set                  | True  | False  | True        | do not set                    |
			| FS_Mensal_Sanity_1                 | Mensal/dataset_mensal_fake_3.xlsx                     | yyyy-MM-dd | 12          | 2          | True  | False   | AIC    | RMSE     | Median | False | False     | brl_usd_lag1,brl_eur_lag1                                                                                                                                                                                | do not set                  | do not set                  | True  | True   | False       | price_feedstock_3_lag3        |
			| FS_Mensal_Sanity_2                 | Mensal/dataset_mensal_fake_4.csv                      | yyyy-MM-dd | 20          | 20         | False | True    | AIC    | WMAPE    | Median | False | False     | fog_1,fog_2                                                                                                                                                                                              | fog_3,fog_4                 | ckt,fe                      | True  | True   | False       | do not set                    |
			| RezendeJob_AllPick4me              | dataset_energia_com_co-step2.xlsx                     | yyyy-MM-dd | 12          | 12         | True  | True    | AIC    | MAPE     | Mean   | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| Contribuicao_Anual_PIB_Agro        | ContribuicaoAnual_PIBAgro.xlsx                        | yyyy-MM-dd | 3           | 4          | False | False   | AIC    | MAPE     | Mean   | True  | True      | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| Biscoito_Nordeste_Sanity           | dataset_biscoitos.xlsx                                | yyyy-MM-dd | 1           | 12         | True  | True    | AIC    | MAPE     | Mean   | True  | False     | pib_brasil,confianca_consumidor,populacao_ocupada, renda_bruta_restrita,confianca_industria, pib_nordeste,massa_real, renda_real,renda_bruta, expedicao_caixas_de_papel,volume_vendas_varejo_real_brasil | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| geracao_energia_Sanity             | carga_energia_ons_dez21-new.xlsx                      | yyyy-MM-dd | 3           | 3          | True  | True    | AIC    | MAPE     | Mean   | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | fs_heavyabcr_br_5,fs_icc_br_5 |
			| FS_pim_mar2002                     | dataset_fs_pim_mar2002.xlsx                           | yyyy-MM-dd | 3           | 3          | True  | True    | AIC    | MAPE     | Mean   | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | fs_heavyabcr_br_5,fs_icc_br_5 |
			| daily_60_observations              | errors/dataset_paulista_fluxo_60 .xlsx                | yyyy-MM-dd | 3           | 3          | True  | True    | AIC    | MAPE     | Mean   | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | fs_heavyabcr_br_5,fs_icc_br_5 |
			| dataset_exp_z                      | dataset_exp_z.xlsx                                    | yyyy-MM-dd | 6           | 12         | False | True    | AIC    | MAPE     | Median | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| diario_without_values_variables    | dataset_diario_without_values_dependent_variable.xlsx | yyyy-MM-dd | 6           | 12         | False | True    | AIC    | MAPE     | Median | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| Seas_d_false                       | no_explanatory_variables.xlsx                         | yyyy-MM-dd | 20          | 20         | True  | False   | BIC    | WMAPE    | Median | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| dataset_36obs                      | dataset_36obs.xlsx                                    | yyyy-MM-dd | 12          | 6          | True  | True    | BIC    | WMAPE    | Median | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| check_variable_with_greater_effect | check_variable_with_greater_effect.xlsx               | yyyy-MM-dd | 9           | 3          | True  | True    | AIC    | MAPE     | Mean   | True  | False     | pib_br,pmca_br,pmc_br,pim_br,pib_rs,pmca_rs,pmc_rs,pim_rs,pib_su,pmca_su,pmc_su,pim_su                                                                                                                   | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| ts495                              | dataset_ts495.xlsx                                    | yyyy-MM-dd | 12          | 12         | True  | True    | AIC    | MAPE     | Mean   | True  | False     | massa_hab,pib4i,pib4i_servicos,pmc,pmc_farm,pmc_a,pop_ocup,renda_hab,renda_nac_disp_bruta_rest,x11                                                                                                       | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| ts505_dataset_target               | dataset_target.xlsx                                   | yyyy-MM-dd | 1           | 1          | True  | True    | AIC    | MAPE     | Mean   | True  | False     | do not set                                                                                                                                                                                               | do not set                  | do not set                  | True  | True   | True        | do not set                    |
			| dat_temp_more_dates                | dat_temp.xlsx                                         | yyyy-MM-dd | 4           | 12         | True  | True    | AIC    | MAPE     | Mean   | True  | False     | chuva,dias_uteis                                                                                                                                                                                         | do not set                  | do not set                  | True  | True   | True        | do not set                    |

	@API
	Scenario Outline: Modeling project from API with lags
		When upload dataset '<dataset>' with '<ProjectName>' project name
		And select variables with '<dateFormat>' date format
		And add variables lags
		And validate dataset
		Then send modeling with configs '<forestValue>', '<crossValue>', '<log>', '<dummies>', '<i.crit>', '<accuracy>', '<cross>', '<avoid>', '<auto_expl>', '<group 1>', '<group 2>', '<group 3>', '<lasso>', '<random>', '<correlation>', '<goldenVar>'

		Examples:
			| ProjectName         | dataset                                  | dateFormat | forestValue | crossValue | log  | dummies | i.crit | accuracy | cross | avoid | auto expl. | group 1    | group 2        | group 3       | lasso | random | correlation | goldenVar  |
			| Mensal_Sanity_lags  | Mensal/dataset_mensal_fake_3.xlsx        | yyyy-MM-dd | 20          | 20         | True | False   | AIC    | MAPE     | Mean  | True  | False      | do not set | rendar,massa_r | pmc_a_n,pim_n | True  | True   | True        | do not set |
			| TS135_Mensal_Sanity | Mensal/dataset_mensal_date_variable.xlsx | yyyy-MM-dd | 20          | 20         | True | False   | AIC    | MAPE     | Mean  | True  | False      | do not set | rendar,massa_r | pmc_a_n,pim_n | True  | True   | True        | do not set |

	@API @TS-65 @TS-73 @TS-128 @TS-279 @TS-330
	Scenario Outline: Modeling project from Base64
		When send a modeling "<file>" in "<version>" API

		Examples:
			| version | file                                                  |
			| v1      | time-series/b64rm_ML01-Consumo-Energia-Nstep12-Sanity |
			| v1      | time-series/b64rm_ML02-15Y-Dataset-All-Sanity         |
			| v1      | time-series/b64rm_ML03_SAME_2Y                        |
			| v1      | time-series/b64rm_ML23-All-Dataset-Anual              |
			| v1      | time-series/b64rm_ML24-All-Dataset-Bimestral          |
			| v1      | time-series/b64rm_ML25-All-Dataset-Semanal            |
			| v1      | time-series/b64rm_ML26-All-Dataset-Semestral          |
			| v1      | time-series/b64rm_ML27-All-Dataset-Trimestral         |
			| v1      | time-series/b64rm_ML28-All-Dataset-Quinzenal          |
			| v1      | time-series/b64rm_ML29-All-Dataset-Mensal             |
			| v1      | time-series/b64rm_ML05-Seasonal Adjus Broken 24 hrs   |
			| v1      | time-series/b64rm_ML06-All-Demo-Dataset-Sanity-Lags   |
			| v1      | time-series/b64rm_ML08_mod1627                        |
			| v1      | time-series/b64rm_ML09_mod1621                        |
			| v1      | time-series/b64rm_ML10_mod1647                        |
			| v1      | time-series/b64rm_ML11_mod1648                        |
			| v1      | time-series/b64rm_ML12_mod1683                        |
			| v1      | time-series/b64rm_ML13_mod1645                        |
			| v1      | time-series/b64rm_ML14_mod1615                        |
			| v1      | time-series/b64rm_ML15_mod1510                        |
			| v1      | time-series/b64rm_ML16-All-Dataset-Diario             |
			| v1      | time-series/b64rm_ML17_mod1828                        |
			| v1      | time-series/b64rm_ML18_mod1827_v1                     |
			| v1      | time-series/b64rm_ML19_mod1827_v2                     |
			| v1      | time-series/b64rm_ML20_mod1777                        |
			| v1      | time-series/b64rm_ML21_mod1779                        |
			| v1      | time-series/b64rm_ML22_mod1896                        |
			| v1      | time-series/b64rm_ts68_bergman                        |
			| v1      | time-series/b64rm_ts279                               |
			| v1      | time-series/b64rm_ts330                               |
			| v1      | time-series/63fce7818af6757fa3a97aee                  |
			| v1      | pp4i/b64rm_ts-73-tc01                                 |
			| v1      | pp4i/b64rm_ts-73-tc2                                  |
			| v1      | pp4i/b64rm_ts-73-tc3                                  |
			| v1      | pp4i/b64rm_ts-73-tc4                                  |
			| v1      | pp4i/b64rm_ts-73-tc5                                  |
			| v1      | pp4i/b64rm_ts-73-tc7                                  |
			| v1      | pp4i/b64rm_ts-73-tc8                                  |
			| v1      | pp4i/b64rm_ts-73-tc9                                  |
			| v1      | pp4i/b64rm_ts-73-tc10                                 |
			| v1      | pp4i/b64rm_ts-73-tc11                                 |
			| v1      | pp4i/b64rm_ts-73-tc12                                 |
			| v1      | time-series/b64rm_Dataset-Diario_170_mixed_obser      |
			| v1      | time-series/b64rm_Dataset-Diario_170_obser            |
# | v1  		| time-series/incident_cpu-98Ys			|
# | v1  		| time-series/b64rm_teste_mdias_dataset_70y_168977641102799 			|
# | v1  		| time-series/b64rm_All_Mensal_modelling_lag_169039937349889 			|

	@API @PARTIAL_ERROR @TS-128 
	Scenario Outline: Modeling with partial error via Base 64 and skip validate errors
		When send a modeling without validate errors "<project>" with "<response>"

		Examples:
			| response 		| project 											|
			| success  		| b64rm_ML02-15Y-With-1Y-Success					|
			| success  		| b64rm_ML02-15Y-Dataset-All-Sanity_partial_error	|
			| not found  	| b64rm_ML02-15Y-Dataset-All-Sanity_partial_error	|
			| unauthorized  | b64rm_ML02-15Y-Dataset-All-Sanity_partial_error	|
			| bad request  	| b64rm_ML02-15Y-Dataset-All-Sanity_partial_error	|
