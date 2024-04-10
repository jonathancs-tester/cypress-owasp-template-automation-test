@PREDICT
@4INTELLIGENCE @UI @REGRESSION @CLASSIFICATION
Feature: Predictions for Classification

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"
    
    @SANITY @V3.0 @CS-80 @CS-81 @CS-78 @CS-124 @CS-165
	Scenario Outline: Upload dataset for predictions with success
		When I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Label Model[name=explorer]"
		And I click the "Model List Radio[model=<model>]"
		And I click the "Send to User Selection Button"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Upload Dataset Button"
		And I click the "Warning Modal Button"
		Then I can see text "Probability" in element "Predict Result Table"
		And I can see text "<variable>" in element "Predict Result Table"
		And I can see text "50" in element "Predict Result Table"
		And I click the "Download Prediction Button"
		And I check if download size is greather than 200 kb
		And I clear download folder
      
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
		When I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Label Model[name=inproduction]"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Upload Dataset Button"
		Then I can see text "<error>" in element "Error Modal"

      Examples:
		| ProjectName     | dataset 										| error 																					|
		| diabetes_sanity | classification/mushrooms.xlsx 					| Mandatory columns are missing for prediction.												|
		| diabetes_sanity | time-series/Mensal/dataset_mensal_fake_1.csv 	| Mandatory columns are missing for prediction.												|
		| diabetes_sanity | classification/diabetes_remove_column.xlsx 		| Mandatory columns are missing for prediction.												|	
		| hotel			  | classification/hotel_12mb.xlsx 					| Your dataset needs to have a size equal to or less than 6.5MB to perform the prediction.	|

	Scenario: Check API predict infos 
		When I write "spotify" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=spotify_sanity;position=first]" 
		And I click the "Label Model[name=inproduction]"
		Then I click the "Call Via Api Button"
		And I can see element "See Documentation Button"