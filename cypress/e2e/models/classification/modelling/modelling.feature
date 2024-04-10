@MODELLING_CS_UI
@4INTELLIGENCE @UI @CREATEPROJECT @CLASSIFICATION @REGRESSION @MODELLING

Feature: Classification Modelling UI

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@SANITY @V3.0 @CS-32 @CS-83 @CS-133 @CS-173 @CS-66
	Scenario Outline: Modeling default datasets - SANITY
		And I click the "Create Project Button"
		And I click the "Classification Menu"
		When I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "<Dependent_variable>" options in element "Chart Dependent Variables"
		And I should see is equal to <columns> items of "Dependent Classification Chart Bars[name=<Dependent_variable>]"
		And I click the "Final Settings Button"
		Then I can see element "Begin Button"
		And I close the "Data Processing Modal" if exists
		And I click the "Begin Button"
		And I can see element "Modelling Started Modal"

		Examples:
			| ProjectName       | dataset                                   | Dependent_variable | columns |
			| salesprice_num1   | classification/salesprice_num1.xlsx       | saleprice          | 2       |
			| salesprice_num2   | classification/salesprice_num2.xlsx       | saleprice          | 3       |
			| salesprice_str1   | classification/salesprice_str1.xlsx       | saleprice          | 2       |
			| salesprice_str2   | classification/salesprice_str2.xlsx       | saleprice          | 3       |
			| salesprice_sanity | classification/salesprice.xlsx            | saleprice          | 3       |
			| vinhos_sanity     | classification/vinhos.csv                 | qualidade          | 3       |
			| vinhos_sanity     | classification/vinhos.xlsx                | qualidade          | 3       |
			| winequality       | classification/multiclass/winequality.csv | quality            | 6       |

	@SANITY @V3.0 @CS-32 @CS-83 @CS-133 @CS-173 @CS-66
	Scenario Outline: Modeling without Data Processing warning - SANITY
		And I click the "Create Project Button"
		And I click the "Classification Menu"
		When I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "<Dependent_variable>" options in element "Chart Dependent Variables"
		And I should see is equal to <columns> items of "Dependent Classification Chart Bars[name=<Dependent_variable>]"
		And I click the "Final Settings Button"
		Then I can see element "Begin Button"
		And I click the "Begin Button"
		And I can see element "Modelling Started Modal"

		Examples:
			| ProjectName      | dataset                                 | Dependent_variable | columns |
			| tramandai_rnd    | classification/tramandai_train_rnd.xlsx | bad_month          | 2       |
			| drug_200         | classification/multiclass/drug200.csv   | drug               | 5       |
			| glass            | classification/multiclass/glass.csv     | type               | 6       |
			| cs284-over30mob4 | classification/memory_leak_class.csv    | over30mob4         | 2       |

	@V3.2 @CS-70
	Scenario: Check See Requirements and download template
		When I click the "Create Project Button"
		And I click the "Classification Menu"
		And I click the "Begin Your Project Button"
		And I write "GiantNameGiantNameGiantNameGiantNameGiantNameGiantName" text in element "Project Name Input"
		When I click the "See Requirements Button"
		And I click external download in element "Download Example Button"
		Then I check if download size is greather than 200 kb
		And I clear download folder

	@V3.1 @CS-27
	Scenario: Not possible to send classification without explanatory variable
		When I click the "Create Project Button"
		And I click the "Classification Menu"
		And I click the "Begin Your Project Button"
		And I write "mushrooms_Sanity" text in element "Project Name Input"
		And I attach fixture "classification/mushrooms.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I click the "Delete Explanatory Variables Button"
		Then I can see text "Select at least one variable." in element "p"

	@V3.1 @CS-98 @CS-28 @CS-111 @CS-177 @CS-66
	Scenario Outline: Validate application error modal
		Given I click the "Create Project Button"
		And I click the "Classification Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		Then I click the "Select Variables Button"
		And I can see text "<Message>" in element "Error Modal"
		And I can see element "Cloud Error Img"

		Examples:
			| ProjectName            | dataset                                          | Message                                                                                          |
			| semTargetBinaria       | classification/errors/no_dependent_variable.xlsx | We did not find a classifiable variable in your dataset. Maximum number of allowed classes is 7. |
			| linhasInadequadas      | classification/diabetes_50linhas.csv             | Your dataset must have a minimum of 50 rows                                                      |
			| colunasInadequadas     | classification/diabetes_1coluna.xlsx             | Your dataset must have a minimum of 2 columns                                                    |
			| maisColunas_que_Linhas | classification/mushrooms_morecolumns.xlsx        | Your dataset must have more rows than columns                                                    |

	@V3.2 @CS-18 @CS-174
	Scenario Outline: Warning of dataset in step 2
		Given I click the "Create Project Button"
		And I click the "Classification Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		Then I click the "Select Variables Button"
		And I select "<Dependent_variable>" options in element "Chart Dependent Variables"
		When I can see text "<message>" in element "p"

		Examples:
			| ProjectName                       | dataset                                                          | Dependent_variable | message                                                                                                 |
			| unlabanced_nan_is_cat             | classification/unbalanced/dataset_unlabanced_nan_is_cat.xlsx     | saleprice          | Your dataset seems to be unbalanced. Our algorithms can handle it or the data provided can be verified. |
			| dataset_unlabanced_nan_is_not_cat | classification/unbalanced/dataset_unlabanced_nan_is_not_cat.xlsx | saleprice          | Your dataset seems to be unbalanced. Our algorithms can handle it or the data provided can be verified. |
			| dataset-rl                        | classification/unbalanced/rl.xlsx                                | class              | Your dataset seems to be unbalanced. Our algorithms can handle it or the data provided can be verified. |
			| glass                             | classification/multiclass/glass.csv                              | type               | Your dataset seems to be unbalanced. Our algorithms can handle it or the data provided can be verified. |
			| wineQuality                       | classification/multiclass/winequality.csv                        | quality            | Classes of quality with fewer than 6 occurrences were excluded from the modeling process.               |

	Scenario Outline: Check removing variable in step 3
		And I click the "Create Project Button"
		And I click the "Classification Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		When I click the "Select Variables Button"
		And I select "type" options in element "Chart Dependent Variables"
		And I click the "Final Settings Button"
		Then I can see element "Begin Button"
		And I close the "Data Processing Modal" if exists
		And I can see element "Begin Button"

		Examples:
			| ProjectName    | dataset                                        | message                                                                                                               |
			| remove_class_6 | classification/errors/glass_remove_class_6.csv | The following values appear less than the minimum amount required (6 times) on the target column and will be removed: |
