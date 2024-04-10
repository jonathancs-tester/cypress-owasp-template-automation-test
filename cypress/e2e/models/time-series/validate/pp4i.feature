@PP4I
@4INTELLIGENCE @UI @BERGMAN @TIMESERIES @REGRESSION @STEP1
Feature: Pre Processing (pp4i) Validation

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @V3.2 @TS-73
	Scenario Outline: Check pre processamento (pp4i) package
		And find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "arima" menu in Model Explorer "time series" model
		And access to "modeldispersion" submenu in "arima" Model Explorer
		When change to last option in N Best Models of the Dispersion
		Then it should "<be>" possible to show "<explanatory_variable>" variable in Beta View of the Dispersion

		Examples:
			| ProjectName    		| be 		| BestModel	|	explanatory_variable |
			| ts-73-tc01    		| be		| 15		|	z_gap				 |
			| ts-73-tc2    			| not be	| 10		|	footer 				 |
			| ts-73-tc4   			| be		| 20		|	x_pib_rj 			 |
			| ts-73-tc5    			| not be	| 20		|	z_diesel	 		 |
			| ts-73-tc8    			| be		| 20		|	diesel			 	 |
			| ts-73-tc9    			| not be	| 3			|	xagropec 			 |
			| ts-73-tc9    			| be		| 3			|	v_comb 				 |
			| ts-73-tc12    		| not be	| 20		|	v_comb				 |



    