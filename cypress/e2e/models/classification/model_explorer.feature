@MODEL_EXPLORER
@4INTELLIGENCE @UI @REGRESSION @CLASSIFICATION
Feature: Model Explorer for Classification

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @V3.1
	Scenario Outline: Check binary classification job finished with success
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "modelexplorer" menu in Model Explorer "classification" model

		Examples:
		| ProjectName    			| 
		| mushroom_sanity  			| 
		| cancer_sanity  			| 
		| small_dresses_sanity  	| 
		| titanic_sanity  			|
		| fetal_health_sanity  		| 
		| spotify_sanity  			| 
		| msme_credit_data  		| 
		| mushroom_num_reg  		| 
		| severe_decelerations  	|
		| target_nan_C64  			| 
		| binario_numerico_CS_69  	| 
		| binario_objeto_CS_69  	| 
		| classe_unica_CS_69  		| 
		| vinhos_sanity  			| 
		| hotel  					|
		| winequality  				|

	@SANITY @V3.6
	Scenario Outline: Check multiclass classification job finished with success
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "modelexplorer" menu in Model Explorer "classification" model

		Examples:
		| ProjectName   | 
		| glass  		| 
		| winequality  	| 
		| drug_200  	| 
    
	@SANITY @V3.0 @CS-83 @CS-104 @CS-172 @CS-101 @CS-169
	Scenario Outline: Check all model explorer features for each models
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "modelexplorer" menu in Model Explorer "classification" model
		And select '<model>' model
		Then check '<model>' model info
		And check performance
		And check model details table
		And check feature importance of "<model>"
		And check variable impacts of "<model>"
		And check confusion matrix of "<PositiveClass>"
		And check ROC curve

      Examples:
		| ProjectName    	| model					| PositiveClass			|
		| salesprice_sanity	| random-forest			| y						|
		| salesprice_num1  	| svm					| nan					|
		| salesprice_num2  	| gradient-boosting		| 2.0					|
		| salesprice_str1  	| lightgbm				| nan					|
		| salesprice_str2  	| xgboost				| y						|
		| vinhos_sanity  	| kneighbors			| bom					|
		| salesprice_num1  	| logistic-regression	| nan					|
		| sanity_pistache  	| logistic-regression	| Siirt_Pistachio		|	
