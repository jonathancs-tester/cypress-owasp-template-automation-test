@MODEL_PRODUCTION
@4INTELLIGENCE @UI @REGRESSION @CLASSIFICATION
Feature: Model in Production for Classification

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @V3.0 @CS-95
	Scenario Outline: Check performance of models in production
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		When I click the "Label Model[name=explorer]"
		And I click the "Model List Radio[model=<model>]"
		And I click the "Send to User Selection Button"
		Then I can see element "Check Performance Value[name=accuracy]" is not be empty
		And I can see element "Check Performance Value[name=precision]" is not be empty
		And I can see element "Check Performance Value[name=recall]" is not be empty
		And I can see element "Check Performance Value[name=f1-score]" is not be empty
		And I can see element "Check Performance Value[name=rocauc]" is not be empty

      Examples:
		| ProjectName    	| model					| PositiveClass		|
		| diabetes_sanity  	| random-forest			| tested_negative	| 
		| diabetes_sanity  	| svm					| tested_negative	|
		| diabetes_sanity  	| gradient-boosting		| tested_negative	|
		| diabetes_sanity  	| lightgbm				| tested_negative	|
		| diabetes_sanity  	| xgboost				| tested_negative	|
		| diabetes_sanity  	| kneighbors			| tested_negative	|
		| diabetes_sanity  	| logistic-regression	| tested_negative	|