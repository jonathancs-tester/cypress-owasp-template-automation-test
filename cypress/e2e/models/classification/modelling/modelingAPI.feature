@MODELLING_CS_API
@4INTELLIGENCE @API @CREATEPROJECT @REGRESSION @CLASSIFICATION @MODELLING
Feature: Classification Modelling API

	Background: Login
		Given insert "admin" credentials and login via "MFA"
    
  @V3.0
	Scenario Outline: Upload classification dataset
		Then upload classification dataset '<dataset>' with '<ProjectName>' project name and '<Status>' status

      Examples:
      | ProjectName 		        | dataset 							|  Status          |
      | mushroom_sanity         | mushrooms.xlsx     	  |  Success         |
      | mushroom_sanity         | mushrooms.xlsx     	  |  Unauthorized    |
      | mushroom_sanity         | mushrooms.xlsx     	  |  Not found       |
      | mushroom_sanity         | mushrooms.xlsx     	  |  Bad request     |
      | #mushroom_sanity        | mushrooms.xlsx     	  |  Bad request     |
      | cereal_sanity           | cereal.xlsx     	    |  Bad request     |
  
  @V3.0
	Scenario Outline: Select classification variables
		When upload classification dataset '<dataset>' with '<ProjectName>' project name and 'Success' status
    Then select variables with '<Status>' status with "<depedent_variable>" dependent variable

      Examples:
      | ProjectName 		        | dataset 							|  Status          | depedent_variable          |
      | mushroom_sanity         | mushrooms.xlsx     	  |  Success         | class                      |
      | mushroom_sanity         | mushrooms.xlsx     	  |  Unauthorized    | class                      |
      | mushroom_sanity         | mushrooms.xlsx     	  |  Not found       | class                      |
      | mushroom_sanity         | mushrooms.xlsx     	  |  Bad request     | class                      |

  @V3.1 @CS-39
	Scenario Outline: Validar colunas que precisam ser eliminadas no dataset
		When upload classification dataset '<dataset>' with '<ProjectName>' project name and 'Success' status
    And select variables with 'Success' status with "default" dependent variable
    Then validate dataset in classification
    And check "Variables will be removed due to misleading missing values:" message with "missing" warning for "<missing_var>" in validate dataset
    And check "Variables will be removed due to excess of unique values:" message with "type" warning for "<type_var>" in validate dataset
    And check "lines will be removed due to misleading missing values" message with "rows" warning for "<rows_var>" in validate dataset

      Examples:
      | ProjectName 		        | dataset 							   |  type_var          | missing_var | rows_var    |
      | credit_dropcol1         | credit_dropcol1.xlsx     |  to_many_unique    | not have    | not have    |
      | credit_dropcol2         | credit_dropcol2.xlsx     |  to_many_unique    | a3          | not have    |
      | credit_dropcol3         | credit_dropcol3.xlsx     |  to_many_unique    | a3,a6       | not have    |
      | credit_dropcol4         | credit_dropcol4.xlsx     |  not have          | a3,a6       | not have    |
      | credit_drop_rows        | credit_drop_rows.xlsx    |  not have          | not have    | 11          |

  @V3.0 @SANITY @CS-66 @CS-284
  Scenario Outline: Send to modeling - Binary Datasets
		When upload classification dataset '<dataset>' with '<ProjectName>' project name and 'Success' status
    And select variables with 'Success' status with "<depedent_variable>" dependent variable
    And validate dataset in classification
    Then send to classification modeling with '<Status>'

      Examples:
      | ProjectName 		        | dataset 							                  |  Status          | depedent_variable          |
      | mushroom_sanity         | mushrooms.xlsx                          |  Success         | class                      |
      | cancer_sanity           | cancer.xlsx                             |  Success         | diagnosis                  |
      | small_dresses_sanity    | small_dresses-sales-small.xlsx          |  Success         | class                      |
      | diabetes_sanity         | diabetes.csv                            |  Success         | class                      |
      | titanic_sanity          | titanic_train.xlsx                      |  Success         | survived                   |
      | fetal_health_sanity     | fetal_health.xlsx                       |  Success         | severe_decelerations       |
      | spotify_sanity          | spotify.xlsx                            |  Success         | mode                       |
      | msme_credit_data        | msme_credit_data.xlsx                   |  Success         | label                      |
      | mushroom_num_reg        | mushrooms.xlsx                          |  Success         | class                      |
      | severe_decelerations    | severe_decelerations.xlsx               |  Success         | severe_decelerations       |
      | target_nan_C64          | dataset_target_nan.xlsx                 |  Success         | saleprice                  |
      | binario_numerico_CS_69  | dataset_binario_numerico_nan.xlsx       |  Success         | saleprice                  |
      | binario_objeto_CS_69    | dataset_binario_objeto_nan.xlsx         |  Success         | saleprice                  |
      | classe_unica_CS_69      | dataset_classe_unica_nan.xlsx           |  Success         | saleprice                  |
      | hotel                   | hotel_12mb.xlsx                         |  Success         | hotel                      |
      | sanity_pistache         | pistache_with_at.xlsx                   |  Success         | class                      |
      | autralia_rainfall       | australia-rainfall.xlsx                 |  Success         | year                       |
      | cs284-over30mob4        | memory_leak_class.csv                   |  Success         | over30mob4                 |

  @V3.0 @SANITY
  Scenario Outline: Send to modeling removing a variable in step 2
		When upload classification dataset '<dataset>' with '<ProjectName>' project name and 'Success' status
    And select variables with 'Removing' status with "<depedent_variable>" dependent variable
    And validate dataset in classification
    Then send to classification modeling with '<Status>'

      Examples:
      | ProjectName 		        | dataset 							                  |  Status          | depedent_variable          |
      | mushroom_sanity         | mushrooms.xlsx                          |  Success         | class                      |
      | cancer_sanity           | cancer.xlsx                             |  Success         | diagnosis                  |