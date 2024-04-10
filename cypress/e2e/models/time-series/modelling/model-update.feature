@MODEL_UPDATE_API
@4INTELLIGENCE @API @CREATEPROJECT @TIMESERIES @REGRESSION @MODELLING
Feature: Model update

	Background: Login
		Given insert "admin" credentials and login via "MFA"
	
  @CS-258
	Scenario Outline: Check Model update validate
		When send to model_update "<base64>" project with this "<project_id>" id and status code 400
    Then compare response with this "<response_json>" object
		
        Examples:
        | base64                                           | project_id                | response_json          |
        |time-series/validate_MU_scenarios/scenario_1.json | 64bad4fa8c2475e2595b41db  | validate_1.json        |
        |time-series/validate_MU_scenarios/scenario_2.json | 64bad4fa8c2475e2595b41db  | validate_2.json        |
        |time-series/validate_MU_scenarios/scenario_3.json | 64bad4fa8c2475e2595b41db  | validate_3.json        |
        |time-series/validate_MU_scenarios/scenario_4.json | 64bad4fa8c2475e2595b41db  | validate_4.json        |
        |time-series/validate_MU_scenarios/scenario_5.json | 64bad4fa8c2475e2595b41db  | validate_5.json        |
        |time-series/validate_MU_scenarios/scenario_6.json | 64bad4fa8c2475e2595b41db  | validate_6.json        |
        |time-series/validate_MU_scenarios/scenario_7.json | 64bad4fa8c2475e2595b41db  | validate_7.json        |
        |time-series/validate_MU_scenarios/scenario_8.json | 64bad4fa8c2475e2595b41db  | validate_8.json        |
        |time-series/validate_MU_scenarios/scenario_9.json | 64bad4fa8c2475e2595b41db  | validate_9.json        |
        |time-series/validate_MU_scenarios/scenario_10.json | 64bad4fa8c2475e2595b41db | validate_10.json        |
        |time-series/validate_MU_scenarios/scenario_11.json | 64bad4fa8c2475e2595b41db | validate_11.json        |
        |time-series/validate_MU_scenarios/scenario_12.json | 64bad4fa8c2475e2595b41db | validate_12.json        |

  @test
  Scenario Outline: Send to model update
    Then send to model_update "<base64>" project with this "<project_id>" id and status code 200

        Examples:
        | base64                                                          | project_id                |
        |time-series/model-update/all_modeling_mensal_base64.json          | 64c107eafd81de0cddc82c66  |
        |time-series/model-update/all_modeling_mensal_base64_partial.json  | 64c256dff4c3c7ac38c97b08  |
        |time-series/model-update/mdias_mensal_base64.json                 | 64ba7764a994889e09e9b0b9  |

	@TS-97 @TS-140
	Scenario Outline: Model Update project from Base64
		When send a model update "<file>" in "<version>" API

		Examples:
			| version 	| file    											| 
			| v1  		| time-series/model-update/m_update_partial_success	| 
			| v1  		| time-series/model-update/m_update_com_yname_iguais| 