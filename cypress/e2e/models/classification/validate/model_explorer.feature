@MODEL_EXPLORER
@4INTELLIGENCE @UI @REGRESSION @CLASSIFICATION
Feature: Model Explorer for Classification

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @V3.1
	Scenario Outline: Check binary classification job finished with success
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Label Model[name=explorer]"

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
		| target_nan_c64  			| 
		| binario_numerico_cs_69  	| 
		| binario_objeto_cs_69  	| 
		| classe_unica_cs_69  		| 
		| vinhos_sanity  			| 
		| hotel  					|
		| winequality  				|

	@SANITY @V3.6 
	Scenario Outline: Check multiclass classification job finished with success
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Label Model[name=explorer]"

		Examples:
		| ProjectName   | 
		| glass  		| 
		| winequality  	| 
		| drug_200  	| 
    
	@SANITY @V3.0 @CS-83 @CS-104 @CS-172 @CS-101 @CS-169
	Scenario Outline: Check all model explorer features for each models
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Label Model[name=explorer]"
		And I click the "Model List Radio[model=<model>]"
		Then I can see text "<modelinfo>" in element "Model Info Max Features[element=<element>]"
		And I can see element "Check Performance Value[name=accuracy]" is not be empty
		And I can see element "Check Performance Value[name=precision]" is not be empty
		And I can see element "Check Performance Value[name=recall]" is not be empty
		And I can see element "Check Performance Value[name=f1-score]" is not be empty
		And I can see element "Check Performance Value[name=rocauc]" is not be empty
		And I click the "Show Table Button"
		And I can see element "Fill Numeric Values" is not be empty
		And I can see element "Fill Categorical Values" is not be empty
		And I can see element "Scaling" is not be empty
		And I can see element "Encoding" is not be empty
		And I can see element "Balancing" is not be empty
		And I can see element "Feature Selection" is not be empty
		And I can see element "Classifier" is not be empty
		And I can see element "Feature Importance Graph"
		And I can see element "Variable Impacts Chart"
		And I can see text "Selected model" in element "Roc Curve Chart" 
		And I can see text "Random model" in element "Roc Curve Chart" 

      Examples:
		| ProjectName    	| model					| PositiveClass			| modelinfo | element 	   | numvaleus | fillcategorical | scaling  | encoding | balancing | featureselection | classifier         |
		| salesprice_sanity	| random-forest			| y						| sqrt 		| max-features | zero      | mode            | robust   | onehot   | none      | variance         | randomForest       |
		| salesprice_num2  	| gradient-boosting		| 2.0					| 100       | n-estimators | zero      | mode            | robust   | label    | weights   | variance         | gradientBoosting   |
		| salesprice_str1  	| lightgbm				| nan					| 31        | num-leaves   | mean      | mode            | minmax   | onehot   | weights   | none             | lgbm               |
		| salesprice_str2  	| xgboost				| y						| gbtree	| booster 	   | median    | mode            | robust   | label    | none      | variance         | xgboost            |
		| salesprice_num1  	| logistic-regression	| nan					| lbfgs 	| solver 	   | zero      | mode            | none     | label    | weights   | none             | logisticRegression |
		| sanity_pistache  	| logistic-regression	| Siirt_Pistachio		| lbfgs 	| solver 	   | median    | keep            | standard | onehot   | none      | variance         | logisticRegression |	


	@SANITY @V3.0 @CS-83 @CS-104 @CS-172 @CS-101 @CS-169
	Scenario Outline: Check all model explorer features for each models fail graph
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Label Model[name=explorer]"
		And I click the "Model List Radio[model=<model>]"
		Then I can see text "<modelinfo>" in element "Model Info Max Features[element=<element>]"
		And I can see element "Check Performance Value[name=accuracy]" is not be empty
		And I can see element "Check Performance Value[name=precision]" is not be empty
		And I can see element "Check Performance Value[name=recall]" is not be empty
		And I can see element "Check Performance Value[name=f1-score]" is not be empty
		And I can see element "Check Performance Value[name=rocauc]" is not be empty
		And I click the "Show Table Button"
		And I can see element "Fill Numeric Values" is not be empty
		And I can see element "Fill Categorical Values" is not be empty
		And I can see element "Scaling" is not be empty
		And I can see element "Encoding" is not be empty
		And I can see element "Balancing" is not be empty
		And I can see element "Feature Selection" is not be empty
		And I can see element "Classifier" is not be empty
		And I can see element "Feature Importance Fail Graph"
		And I can see element "Variable Impacts Fail Chart"
		And I can see text "Selected model" in element "Roc Curve Chart" 
		And I can see text "Random model" in element "Roc Curve Chart" 

      Examples:
		| ProjectName    	| model					| PositiveClass			| modelinfo | element 	   | numvaleus | fillcategorical | scaling  | encoding | balancing | featureselection | classifier         |
		| salesprice_num1  	| svm					| nan					| rbf 		| kernel 	   | zero      | keep            | standard | label    | none      | variance         | svm                |
		| vinhos_sanity  	| kneighbors			| bom					| uniform   | weights 	   | zero      | keep            | robust   | label    | weights   | rfe              | kneighbors         |
