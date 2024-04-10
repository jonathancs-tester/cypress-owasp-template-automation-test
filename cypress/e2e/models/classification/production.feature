@MODEL_PRODUCTION
@4INTELLIGENCE @UI @REGRESSION @CLASSIFICATION
Feature: Model in Production for Classification

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @V3.0 @CS-95
	Scenario Outline: Check performance of models in production
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "modelexplorer" menu in Model Explorer "classification" model
		And select '<model>' model
		And I click the "Send to Production Classification"
		And check performance

      Examples:
		| ProjectName    	| model					| PositiveClass		|
		| diabetes_sanity  	| random-forest			| tested_negative	|
		| diabetes_sanity  	| svm					| tested_negative	|
		| diabetes_sanity  	| gradient-boosting		| tested_negative	|
		| diabetes_sanity  	| lightgbm				| tested_negative	|
		| diabetes_sanity  	| xgboost				| tested_negative	|
		| diabetes_sanity  	| kneighbors			| tested_negative	|
		| diabetes_sanity  	| logistic-regression	| tested_negative	|
