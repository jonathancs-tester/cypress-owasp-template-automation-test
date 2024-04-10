@MODEL_DISPERSION
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER
Feature: Model Dispersion - ARIMA

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @F4-789 @F4-1001 @MODELDISPERSION @TS-152
	Scenario Outline: Check all graphics for Model Dispersion
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modeldispersion" submenu in "arima" Model Explorer
		And change to last option in N Best Models of the Dispersion
		Then it should be possible to find "<BestModel>" in Aggregate Projections Chart in Dispersion
		And it should "be" possible to show "<variable>" variable in Beta View of the Dispersion
		And it should "be" possible to show "<accuracy>" accuracy in Beta View of the Dispersion

		Examples:
			| ProjectName           		  | BestModel | variable       	     | accuracy    |
			| UI_Diario_Sanity         		  | 10        | cambio         	     | MAPE (%)    |
			| Semanal_Sanity        		  | 10        | gm12_dow12     	     | WMAPE (%)   |
			| Quinzenal_Sanity      		  | 10        | rrp            	     | MPE (%)     |
			| Sanity_Mensal         		  | 20        | d_du           	     | RMSE        |
			| Trimestral_Sanity     		  | 3         | no variable   	     | no accuracy |
			| Semestral_Sanity      		  | 20        | explicativa_1 	     | MPE (%) 	   |
			| Anual_Sanity          		  | 20        | cambio_r          	 | WMAPE (%)   |
			| FS_Bimestral_Sanity_1 		  | 30        | y_comida2   		 | MAPE (%)    |
			| FS_Mensal_Sanity_1			  | 20 		  | brl_eur_lag3 		 | MASE		   |
			| FS_Mensal_Sanity_1			  | 20 		  | brl_usd_lag1 		 | MASEs	   |
			| Contribuicao_Anual_PIB_Agro     | 1         | no variable   	     | no accuracy |

	@MOD1627
	Scenario Outline: Lista dentro de lista em exclusions perdendo formato
		When find "mod1627" project 
		And click to "mod1627" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modeldispersion" submenu in "arima" Model Explorer
		Then check if "<var1>" and '<var2>' variables not found in all models by Beta View

		Examples:
			|	var1			|	var2			|
			|	fs_massa_real	|	fs_rend_medio	|
			|	fs_pop_des		|	fs_rend_medio	|
			|	fs_pop_ea		|	fs_rend_medio	|
			|	fs_pop_ocu		|	fs_rend_medio	|
			|	fs_pop_des		|	fs_massa_real	|
			|	fs_pop_ea		|	fs_massa_real	|
			|	fs_pop_ocu		|	fs_massa_real	|

	@MOD1720 @TS239 @TS-445
	Scenario Outline: Não deve incluir um modelo univariado em ARIMA
		When find "<ProjectName>" project 
		And click to "<ProjectName>" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modeldispersion" submenu in "arima" Model Explorer
		Then check if "not exist" univariate model in Beta View

		Examples:
			| ProjectName       | 
			| UI_Diario_Sanity  | 
			| Quinzenal_Sanity  |
			| Sanity_Mensal     | 
			| Quinzenal_Sanity  |
			| Semestral_Sanity  |
			| Anual_Sanity      |

	# sempre verificar se o modelo tem a golden variable
	@MOD1648 @TS-267
	Scenario Outline: Check if at least one model has 'price_feedstock_3_lag3' golden variable
		When find "<projectName>" project 
		And click to "<projectName>" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modeldispersion" submenu in "arima" Model Explorer
		And change to last option in N Best Models of the Dispersion
		And it should "be" possible to show "<variable>" variable in Beta View of the Dispersion

		Examples:
		|	projectName 				|	variable					|
		|	FS_Mensal_Sanity_1 			|	price_feedstock_3_lag3		|
		|	mod1648						|	temp_orvalho				|	

	@TS-175
	Scenario Outline: Check warnings without 180 observations
		When find "<project-name>" project 
		And click to "<project-name>" Model Explorer
		Then the warning of observations "<message>" should be "<visibleInitialy>"
		And select "<y-name>" dependent variable
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modeldispersion" submenu in "arima" Model Explorer
		Then the warning of observations "<message>" should be "<visibleLater>"

		Examples:
			|	project-name					|	y-name					| visibleInitialy  | visibleLater 	| message	|
			|	Dataset-Diario_170_mixed_obser	|	media_7d_hidratado_comb	| not visible	   | visible		| Dataset did not reach the recommended number of observations. Be aware of potential misleading results. |
			|	Dataset-Diario_170_obser		|	media_7d_hidratado_comb	| visible		   | not visible	| No dataset has reached the recommended number of observations. Be aware of potential misleading results. |
			|	daily_60_observations			|	fluxo_dia				| visible		   | not visible 	| Dataset did not reach the recommended number of observations. Be aware of potential misleading results.			|


	@MOD1739 @TS238
	Scenario Outline: Reformular cálculo do MASE e MASEs
		When find "<projectName>" project 
		And click to "<projectName>" Model Explorer
		And select "<y-name>" dependent variable
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modeldispersion" submenu in "arima" Model Explorer
		Then it should "<haveMetric>" possible to show "MASEs" accuracy in Beta View of the Dispersion

		Examples:
			|	projectName 				|	haveMetric	| y-name					|
			|	ML23-All-Dataset-Anual  	|	not be		| pim						|
			|	ML24-All-Dataset-Bimestral 	|	be			| lasanha					|
			|	ML16-All-Dataset-Diario		|	be			| fluxo_dia					|
			|	ML29-All-Dataset-Mensal		|	be			| y_hdv_dlh 				|
			|	ML25-All-Dataset-Semanal	|	not	be		| brazil_cooking_cooker_4	|
			|	ML26-All-Dataset-Semestral	|	be			| br_npim2					|
			|	ML27-All-Dataset-Trimestral	|	be			| pibd						|
			|	ML28-All-Dataset-Quinzenal	|	not	be		| demand					|
			|	ML16-All-Dataset-Diario		|	not	be		| temp_media				|
