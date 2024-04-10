@PREDICT
@4INTELLIGENCE @UI @REGRESSION @CLASSIFICATION
Feature: Predictions for Classification

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
    
    @SANITY @V3.0 @CS-80 @CS-81 @CS-78 @CS-124 @CS-165 
	Scenario Outline: Upload dataset for predictions with success
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "modelexplorer" menu in Model Explorer "classification" model
		And select '<model>' model
		And I click the "Send to Production Classification"
		And click to change the dataset
		And upload a valid "<dataset>" dataset
		And click to upload button
		And click Ok for warning message
		Then It should be possible to find "Probability" in Predict result
		And It should be possible to find "<variable>" in Predict result
		And It should be possible to find 500 rows in Predict result
		And check download CSV format and greather than 200 kB
      
	  Examples:
		| ProjectName    	| model							|	dataset 									| 	variable 	|
		| diabetes_sanity  	| random-forest					|	classification/diabetes.xlsx 				|	class 		|
		| diabetes_sanity  	| svm							|	classification/diabetes.xlsx 				|	class 		|
		| diabetes_sanity  	| gradient-boosting				|	classification/diabetes.csv 				|	class 		|
		| diabetes_sanity  	| lightgbm						|	classification/diabetes.csv 				|	class 		|
		| diabetes_sanity  	| xgboost						|	classification/diabetes_semicolon.csv		|	class 		|
		| diabetes_sanity  	| kneighbors					|	classification/diabetes_semicolon.csv		|	class 		|
		| diabetes_sanity  	| logistic-regression			|	classification/diabetes.xlsx 				|	class 		|
		| diabetes_sanity  	| logistic-regression			| 	classification/diabetes_more_1000_lines.xlsx|	class 		|
		| spotify_sanity  	| random-forest					|	classification/spotify.xlsx 				|	mode 		|
		| autralia_rainfall	| random-forest					|	classification/australia-rainfall-small.xlsx|	year 		|


	@V3.0 @CS-29
	Scenario Outline: Upload dataset for predictions with error
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "modelinproduction" menu in Model Explorer "classification" model
		And upload a valid "<dataset>" dataset
		And click to upload button
		Then the "<error>" error is showed

      Examples:
		| ProjectName     | dataset 									| error 																					|
		| diabetes_sanity | classification/mushrooms.xlsx 				| Mandatory columns are missing for prediction.												|
		| diabetes_sanity | time-series/Mensal/dataset_mensal_fake_1.csv 		| Mandatory columns are missing for prediction.												|
		| diabetes_sanity | classification/diabetes_remove_column.xlsx 	| Mandatory columns are missing for prediction.												|	
		| hotel			  | classification/hotel_12mb.xlsx 				| Your dataset needs to have a size equal to or less than 6.5MB to perform the prediction.	|

	Scenario: Check API predict infos
		When find "spotify" project
		And click to "spotify_sanity" Model Explorer
		And access to "modelinproduction" menu in Model Explorer "classification" model
		Then click in predict API infos button
		And check informations of API predict card