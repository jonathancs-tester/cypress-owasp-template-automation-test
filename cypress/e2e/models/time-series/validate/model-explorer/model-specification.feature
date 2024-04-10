@MODEL_SPECIFICATION
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER @TS-134
Feature: Model Explorer - Model Specificantion

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@MOD1827
	Scenario Outline: Check if contain allowdrift parameter
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I can see only one of following text "drift" in element "Model Specification Variable Table"

		Examples:
			| ProjectName |
			| mod1827_v1  |

	Scenario: Check 'Intercept' variable exibition according to Arima's 'd' option
		Given I write "sanity_mensal" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=sanity_mensal;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then I can see text "d = 0" in element "ARIMA Order Model Info"
		And I can see only one of following text "intercept" in element "Model Specification Variable Table"

	Scenario: Check dummies variables of a dataset that already had dummies
		Given I write "ui_fs_bimestral_sanity_1" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=ui_fs_bimestral_sanity_1;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then I can't see any of following text "d4i" in element "Model Specification Variable Table"
		And I can see text "d_b" in element "Model Specification Variable Table"

	Scenario Outline: Check dummies variables (Add seasonal dummies?) set false
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then I can't see any of following text "d4i" in element "Model Specification Variable Table"

		Examples:
			| ProjectName      |
			| sanity_mensal    |
			| semestral_sanity |
			| anual_sanity     |

	@V3.1 @TS-68 @MOD1476 @MOD1568
	Scenario Outline: Permitir criação de cluster de outlier para todas frequências de dados
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I select "<y-name>" options in element "Dependent Variable Select"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		And I select "<ModelList>" options in element "Model List Variable Select"
		And I can see only one of following text "do_c1" in element "Model Specification Variable Table"

		Examples:
			| ProjectName             | y-name                  | ModelList |
			| ts68_bergman            | ic_br_precos_comm_agro  | 89        |
			| ml16-all-dataset-diario | media_7d_hidratado_comb | 1         |

	@MOD1473 @MOD1568
	Scenario Outline: [Datasets Diários] Implementação de sazonalidade múltipla
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I select "<y-name>" options in element "Dependent Variable Select"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then I can see only one of following text "<month-var>" in element "Model Specification Variable Table"
		And I can see only one of following text "<day-var>" in element "Model Specification Variable Table"

		Examples:
			| ProjectName             | day-var      | month-var | y-name    |
			| ml16-all-dataset-diario | d4i_Sun      | jan       | sales     |
			| ml16-all-dataset-diario | d_dia_sab_ex | d4i_Jan   | fluxo_dia |
			| ml16-all-dataset-diario | d4i_Sun      | d4i_Jan   | BCC       |

	@TS-1061
	Scenario Outline: Cálculo de p-valor Ljung-Box teste
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I write "<ProjectName>" text in element "Search Project"
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=<ProjectName>;position=first]"
		And I click the "Menu Model Explorer[index=arima]"
		And I click the "Menu Model Explorer[index=modelspecifics]"
		Then I get after info in "Ljung-Box p-value"
		And I compare after value is greater than "<value>" value

		Examples:
			| ProjectName            | value |
			| ts1061-ljung-box-value | 0.05  |