@MODEL_SPECIFICS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER @ARIMA
Feature: Model Specifics - ARIMA

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @F4-779 @MODELSPECIFICS @TS-151
	Scenario Outline: Check Transformation, seasd and graphics for Model Specifics
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		Then it should be possible to check "<log>" in Transformation of the Model Info
		And Check the formatting of the Model Info metrics
		And it should be possible to check "<dummies>" with d4i variable in Model Specification
		And it should be possible to check if "True" the Check Residuals charts
		And it should be possible to check the Actual and Model Fit chart
		And it should be possible to check the Actual and Forecast chart in "<ProjectName>"
		And it should be possible to check if "<has>" the Annual Variation histogram
		And it should be possible to check if "<has>" the Annual Level histogram

		Examples:
			| ProjectName       | log   | dummies | ModelList | has   |
			| UI_Diario_Sanity  | True  | True    | 2         | False |
			| Semanal_Sanity    | True  | True    | 2         | True  |
			| Quinzenal_Sanity  | False | True    | 6         | True  |
			| Sanity_Mensal     | True  | False   | 40        | True  |
			| Quinzenal_Sanity  | False | True    | 2         | True  |
			| Semestral_Sanity  | False | False   | 21        | True  |
			| Anual_Sanity      | True  | False   | 18        | True  |

	@F4-779 @MODELSPECIFICS
	#FS_Bimestral_Sanity_1 has d_b dummy instead d4i
	Scenario: Check Transformation, seasd and graphics for Model Specifics
		When find "UI_FS_Bimestral_Sanity_1" project
		And click to "UI_FS_Bimestral_Sanity_1" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "2" options in element "Model List Variable Select"
		Then it should be possible to check "True" in Transformation of the Model Info
		And it should be possible to check "True" with d_b variable in Model Specification
		And it should be possible to check if "True" the Check Residuals charts
		And it should be possible to check the Actual and Model Fit chart
		And it should be possible to check the Actual and Forecast chart in "<ProjectName>"
		And it should be possible to check if "True" the Annual Variation histogram
		And it should be possible to check if "True" the Annual Level histogram
		
	#check if d=0 at Model Info for ARIMA models we must have 'intercept' variable at Model Specification modal
	Scenario: Check 'Intercept' variable exibition according to Arima's 'd' option
		When find "Sanity_Mensal" project 
		And click to "Sanity_Mensal" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		Then if Arima's d parameter sinalizes if intercept variable must be showed at Model Specification modal
	
	Scenario: Check dummies variables of a dataset that already had dummies
		When find "UI_FS_Bimestral_Sanity_1" project 
		And click to "UI_FS_Bimestral_Sanity_1" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		Then it should be possible to check "False" with d4i variable in Model Specification
		And it should be possible to check "True" with d_b variable in Model Specification
	
	Scenario Outline: Check options in Model Info in the ARIMA - Model Specifics
		When find "FS_Mensal_Sanity_1" project
		And click to "FS_Mensal_Sanity_1" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		Then "<Model-Info>" should be visible in Model Info

		Examples:
			| Model-Info |
			| MASE		 |
			| MASEs		 |

	@V3.1 @TS-68 @MOD1476 @MOD1568
	Scenario Outline: Permitir criação de cluster de outlier para todas frequências de dados
		When find "<projectName>" project 
		And click to "<projectName>" Model Explorer
		And select "<y-name>" dependent variable
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		And it should be possible to check "do_c1" variable in Model Specification

		Examples:
			|	projectName 				|	y-name						| 	ModelList	|
			|	ts68_bergman 				|	ic_br_precos_comm_agro		|	87			|
			|	ML16-All-Dataset-Diario		|	media_7d_hidratado_comb		|	1			|

	@MOD1621 @MOD1645
	Scenario Outline: Incluir constante quando verificando por dependência linear
		When find "mod1621" project 
		And click to "mod1621" Model Explorer
		Then access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer

		Examples:
			|	projectName	|
			|	mod1621		|
			|	mod1645		|

	@MOD1615
	Scenario: Check "z_" in Y variable and log=TRUE with forecasts wrongs
		When find "mod1615" project
		And click to "mod1615" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		And I select "11" options in element "Model List Variable Select"
		Then it should be possible to check "True" in Transformation of the Model Info
		And it should be possible to check if "True" the Check Residuals charts
		And it should be possible to check the Actual and Model Fit chart
		And it should be possible to check the Actual and Forecast chart in "<ProjectName>"
		And it should be not have the 'x10' info in the "Annual Variation" histogram
		And it should be not have the 'x10' info in the "Annual Level" histogram

	@MOD1473 @MOD1568
	Scenario Outline: [Datasets Diários] Implementação de sazonalidade múltipla
		When find "<projectName>" project 
		And click to "<projectName>" Model Explorer
		And select "<y-name>" dependent variable
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modelspecifics" submenu in "arima" Model Explorer
		Then it should be possible to check "<month-var>" variable in Model Specification
		And it should be possible to check "<day-var>" variable in Model Specification

		Examples:
			|	projectName 			|	day-var		| month-var	| y-name		|
			|	ML16-All-Dataset-Diario |	d4i_Sun		|  not set	| sales			|
			|	ML16-All-Dataset-Diario |	d_dia_sab_ex|  d4i_Jan	| fluxo_dia		|
			|	ML16-All-Dataset-Diario |	d4i_Sun		|  d4i_Jan	| BCC			|
