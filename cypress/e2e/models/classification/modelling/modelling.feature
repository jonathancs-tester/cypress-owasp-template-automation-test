@MODELLING_CS_UI
@4INTELLIGENCE @UI @CREATEPROJECT @CLASSIFICATION @REGRESSION @MODELLING

Feature: Classification Modelling UI

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @V3.0 @CS-32 @CS-83 @CS-133 @CS-173 @CS-66
	Scenario Outline: Modeling default datasets - SANITY
		Given start a new project creation
		And select "classification" projects
		And insert "<ProjectName>" at "ProjectName" field
		And upload a valid "<dataset>" dataset and go to step 2
		And select "<Dependent_variable>" dependent variable
		And check "<Dependent_variable>" in dependent chart with <columns>
        And go to step 3	
		And click Data Processing modal
		Then request modelling
		And modelling must be requested successfully

		Examples:
			| ProjectName 		    | dataset 								  	|	Dependent_variable	| columns |
			| salesprice_num1      	| classification/salesprice_num1.xlsx     	|	saleprice			|	2	  |
			| salesprice_num2      	| classification/salesprice_num2.xlsx     	|	saleprice			|	3	  |
			| salesprice_str1      	| classification/salesprice_str1.xlsx     	|	saleprice			|	2	  |
			| salesprice_str2      	| classification/salesprice_str2.xlsx     	|	saleprice			|	3	  |
			| salesprice_sanity 	| classification/salesprice.xlsx	      	|	saleprice			|	3	  |
			| vinhos_sanity      	| classification/vinhos.csv		      	  	|	qualidade			|	3	  |
			| vinhos_sanity      	| classification/vinhos.xlsx		      	|	qualidade			|	3	  |
			| tramandai_rnd      	| classification/tramandai_train_rnd.xlsx 	|	bad_month			|	2	  |
			| drug_200		      	| classification/multiclass/drug200.csv   	|	drug				|	5	  |
			| glass      			| classification/multiclass/glass.csv	  	|	type				|	6	  |
			| winequality      		| classification/multiclass/winequality.csv	|	quality				|	6	  |

	@V3.2 @CS-70
	Scenario: Check See Requirements and download template
		When start a new project creation
		And select "classification" projects
		And insert "See_Requirements" at "ProjectName" field
		Then click to see requirements
		And click to download template and check its is greather than 200 kB
	
	@V3.1 @CS-27
	Scenario: Not possible to send classification without explanatory variable
		Given start a new project creation
		And select "classification" projects
		And insert "mushrooms_Sanity" at "ProjectName" field
		And upload a valid "classification/mushrooms.xlsx" dataset and go to step 2
		And I click the "Delete Explanatory Variables Button"
        Then a message "Select at least one variable." error must be showed

	@V3.1 @CS-98 @CS-28 @CS-111 @CS-177 @CS-66
	Scenario Outline: Validar modal de erros na aplicação
		Given start a new project creation
		And select "classification" projects
		And insert "<ProjectName>" at "ProjectName" field
		When upload a valid "<dataset>" dataset
		And try to access next step
		Then it should not be possible to go to step 2
        And a message "<Message>" error must be showed with image

		Examples:
			| ProjectName 		    | dataset 								  		  			|	Message											|
			| semTargetBinaria     	| classification/errors/no_dependent_variable.xlsx	 		|	We did not find a classifiable variable in your dataset. Maximum number of allowed classes is 7.		|
			| linhasInadequadas    	| classification/diabetes_50linhas.csv   		  			|	Your dataset must have a minimum of 50 rows		|
			| colunasInadequadas	| classification/diabetes_1coluna.xlsx    		  			|	Your dataset must have a minimum of 2 columns	|
			| maisColunas_que_Linhas| classification/mushrooms_morecolumns.xlsx	      			|	Your dataset must have more rows than columns	|

	@V3.2 @CS-18 @CS-174
	Scenario Outline: Warning of dataset in step 2
		Given start a new project creation
		And select "classification" projects
		And insert "<ProjectName>" at "ProjectName" field
		And upload a valid "<dataset>" dataset and go to step 2
		And select "<Dependent_variable>" dependent variable
		Then check "<message>" warning in dataset unbalanced

		Examples:
			| ProjectName 		    			| dataset 								  		  					|	Dependent_variable	| message			| 
			| unlabanced_nan_is_cat				| classification/unbalanced/dataset_unlabanced_nan_is_cat.xlsx		|	saleprice			| Your dataset seems to be unbalanced. Our algorithms can handle it or the data provided can be verified. 					|
			| dataset_unlabanced_nan_is_not_cat | classification/unbalanced/dataset_unlabanced_nan_is_not_cat.xlsx	|	saleprice			| Your dataset seems to be unbalanced. Our algorithms can handle it or the data provided can be verified.					|
			| dataset-rl 						| classification/unbalanced/rl.xlsx									|	class				| Your dataset seems to be unbalanced. Our algorithms can handle it or the data provided can be verified.					|
			| glass      						| classification/multiclass/glass.csv	  							|	type				| Your dataset seems to be unbalanced. Our algorithms can handle it or the data provided can be verified.					|
			| wineQuality   					| classification/multiclass/winequality.csv	  						|	quality				| Classes of quality with fewer than 6 occurrences were excluded from the modeling process.					|

	Scenario Outline: Check removing variable in step 3
		Given start a new project creation
		And select "classification" projects
		And insert "<ProjectName>" at "ProjectName" field
		And upload a valid "<dataset>" dataset and go to step 2
		And select "type" dependent variable
		And go to step 3
		Then the message "<message>" should be visible

		Examples:
			| ProjectName 		| dataset 								  		  		|	message 																													|
			| remove_class_6	| classification/errors/glass_remove_class_6.csv		|	The following values appear less than the minimum amount required (6 times) on the target column and will be removed:		|
