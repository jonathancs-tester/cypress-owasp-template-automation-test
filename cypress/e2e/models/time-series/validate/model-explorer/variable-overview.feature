@VARIABLE_OVERVIEW
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER @TS-134
Feature: Model Explorer - Variable Overview

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@SANITY @TS-144
	Scenario Outline: Check Model Sorting chart
		Given I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I intercept "**/models/business/impact/variables" route as "waitAISelection" with "GET" http verbs
		And I write "<ProjectName>" text in element "Search Project"
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I wait "@waitAISelection" routes
		And I click the "Menu Model Explorer[index=overview]"
		And I can see text "MAPE (%)" in element "Models's Sorting Chart"
		Then I select "<Accuracy>" options in element "Accuracy Criteria Select"
		And I can see text "<AccuracyChart>" in element "Models's Sorting Chart"

		Examples:
			| ProjectName           | Accuracy | AccuracyChart |
			| ui_diario_sanity      | RMSE     | RMSE          |
			| semanal_sanity        | MPE      | MPE (%)       |
			| quinzenal_sanity      | WMAPE    | WMAPE (%)     |
			| trimestral_sanity     | MASE     | MASE          |
			| semestral_sanity      | MASEs    | MASEs         |
			| anual_sanity          | WMAPE    | WMAPE (%)     |
			| fs_bimestral_sanity_1 | RMSE     | RMSE          |
			| noexploratory_sanity  | WMAPE    | WMAPE (%)     |

	@SANITY @TS-144
	Scenario: Check Forecast Dispersion chart
		Given I write "ui_diario_sanity" text in element "Search Project"
		And I intercept "**/models/business/impact/variables" route as "waitAISelection" with "GET" http verbs
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=ui_diario_sanity;position=first]"
		And I wait "@waitAISelection" routes
		And I click the "Menu Model Explorer[index=overview]"
		Then I select "9" options in element "N Best Model Select"
		And I can't see any of following text "Model 10" in element "Forecast Dispersion HighChart"

	@SANITY
	Scenario: Check change Y variable for multiple Y project
		Given I write "ml16-all-dataset-diario" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=ml16-all-dataset-diario;position=first]"
		And I click the "Menu Model Explorer[index=overview]"
		Then I select "fluxo_dia" options in element "Dependent Variable Select"
		And I can see text "MAPE (%)" in element "Models's Sorting Chart"

	@MOD1683 @MOD1777 @MOD1896 @TS-498 @MOD1621 @MOD1645 @TS-858 @TS-1046 @TS-1068 @TS-1088
	Scenario Outline: Check if contain model in Model Summary
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/models" route as "waitAISelection" with "GET" http verbs
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I wait "@waitAISelection" routes
		And I select "<y-var>" options in element "Dependent Variable Select"
		And I click the "Menu Model Explorer[index=overview]"
		And I use "<ModelType>" as "name" in template
		Then I can see element "Models's Summary Model Type Table"
		And I can see text "<models>" in element "Models's Summary Quantity Table"

		Examples:
			| ProjectName             | y-var                   | ModelType              | models |
			| ui_diario_sanity        | y_valor                 | elementary             | 5      |
			| semanal_sanity          | brazil_cooking_cooker_4 | elementary             | 3      |
			| quinzenal_sanity        | demand                  | elementary             | 3      |
			| trimestral_sanity       | pibd                    | elementary             | 5      |
			| semestral_sanity        | br_npim2                | elementary             | 3      |
			| anual_sanity            | pim                     | elementary             | 2      |
			| fs_bimestral_sanity_1   | y_comida1               | elementary             | 4      |
			| noexploratory_sanity    | caminhoes               | elementary             | 4      |
			| mod1683                 | geracao_energia         | elementary             | 4      |
			| mod1896                 | saldo_cagedservico_RJ   | elementary             | 5      |
			| mod1777                 | var54                   | forecast-combination   | 10     |
			| mod1683                 | geracao_energia         | arima                  | 119    |
			| mod1683                 | geracao_energia         | regularized-regression | 3      |
			| mod1683                 | geracao_energia         | random-forest          | 1      |
			| mod1645                 | export_acucar           | elementary             | 1      |
			| mod1621                 | fluxo_dia               | arima                  | 14     |
			| ml16-all-dataset-diario | demand                  | random-forest          | 1      |
			| ts1047                  | fs_lightabcr            | forecast-combination   | 11     |
			| ts1044_orig             | bracommoditiesindexicbr | elementary             | 5      |

	Scenario Outline: Modelling should not contain some models
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=<model>]"
		And I wait for element "Menu Model Explorer Without Validate[index=modelspecifics]" be disabled

		Examples:
			| ProjectName  | model                 |
			| seas_d_false | randomforest          |
			| seas_d_false | regularizedregression |

	@TS-1009
	Scenario Outline: Check MAPE contain valid values
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		Given I write "<ProjectName>" text in element "Search Project"
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=overview]"
		And I can see text "MAPE (%)" in element "Models's Sorting Chart"
		And I can't see any of following text "<y-value>" in element "Models's Sorting Y Values Chart"

		Examples:
			| ProjectName                    | y-value |
			| ts1009_ar_univ_nivel_comb_logt | 40      |