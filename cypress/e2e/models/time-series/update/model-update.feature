@MODEL_UPDATE_API
@4INTELLIGENCE @API @CREATEPROJECT @TIMESERIES @REGRESSION @MODELLING
Feature: Model update

  Background: Login
    Given insert "admin" credentials and login via "MFA"

  @CS-258 @CS-497
  Scenario Outline: Check Model update validate
    When search "All_Mensal_4castHub_lag" id in response API
    And send to model_update "<base64>" project with this "@projectID" id and status code 400
    Then compare response with this "<response_json>" object

    Examples:
      | base64                                             | response_json    |
      | time-series/validate_MU_scenarios/scenario_1.json  | validate_1.json  |
      | time-series/validate_MU_scenarios/scenario_2.json  | validate_2.json  |
      | time-series/validate_MU_scenarios/scenario_3.json  | validate_3.json  |
      | time-series/validate_MU_scenarios/scenario_4.json  | validate_4.json  |
      | time-series/validate_MU_scenarios/scenario_5.json  | validate_5.json  |
      | time-series/validate_MU_scenarios/scenario_6.json  | validate_6.json  |
      | time-series/validate_MU_scenarios/scenario_7.json  | validate_7.json  |
      | time-series/validate_MU_scenarios/scenario_8.json  | validate_8.json  |
      | time-series/validate_MU_scenarios/scenario_9.json  | validate_9.json  |
      | time-series/validate_MU_scenarios/scenario_10.json | validate_10.json |
      | time-series/validate_MU_scenarios/scenario_11.json | validate_11.json |
      | time-series/validate_MU_scenarios/scenario_12.json | validate_12.json |

  Scenario Outline: Send to model update
    And search "<projectName>" id in response API
    Then send to model_update "<base64>" project with this "@projectID" id and status code 200

    Examples:
      | base64                                                           | projectName                       |
      | time-series/model-update/all_modeling_mensal_base64.json         | All_Mensal_modelling              |
      | time-series/model-update/all_modeling_mensal_base64_partial.json | All_Mensal_partial_success        |
      | time-series/model-update/mdias_mensal_base64.json                | teste_mdias_dataset_70y           |
      | time-series/model-update/dataset_diario_fake_4.json              | UI_Diario_Sanity                  |
      | time-series/model-update/teste_stl_arima_univ.json               | upt_stl_arim_univ                 |
      | time-series/model-update/dataset_fs_pim_mar2002.json             | FS_pim_mar2002                    |
      | time-series/model-update/cs_497_upt_mult_y_nomes_parecidos.json  | cs_497_upt_mult_y_nomes_parecidos |


  @CS-359
  Scenario Outline: Check project models
    And search "<projectName>" id in response API
    Then I search for project "@projectID" model names and ID's

    Examples:
      | base64                                                           | projectName                |
      | time-series/model-update/all_modeling_mensal_base64.json         | All_Mensal_modelling       |
      | time-series/model-update/all_modeling_mensal_base64_partial.json | All_Mensal_partial_success |
      | time-series/model-update/mdias_mensal_base64.json                | teste_mdias_dataset_70y    |