@ACCESS_GROUPS
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Check Indicators Groups menu 

    @SANITY
    Scenario Outline: Crud groups of indicators
        Given insert "admin" credentials and login via "MFA"
        And access main page			
        And access "Access groups" application
        When click in create a new group of indicator
        And insert the requested informations with "test-sanity"
        And insert "<indicator>" indicator in group
        And click in confirm
        And insert "<email>" user in group
        And click in confirm
        Then the group "test-sanity" should be created
        And edit the created group
        And insert the requested informations with "test-sanity-edited"
        And the group "test-sanity-edited" should be created
        And delete group of indicator

        Examples:
            | indicator     | email                     |
            | AREMP0085     | admin@4casthub.com.br     |

    @SANITY
    Scenario Outline: Check the Pick4ME variables with user without permission
        Given insert "manager" credentials and login via "MFA"
        And access main page			
        And access "Models" application
        And start a new project creation
		And select "time-series" projects
        And insert "<ProjectName>" at "ProjectName" field
		And upload a valid "<dataset>" dataset and go to step 2
        When search for pick for me variables
		And click in Start the magic in Pick for me
        Then the "<variable>" variable should be disabled

        Examples:
            | ProjectName           | dataset                                 | variable               | 
            | projeto_mensal        | time-series/Mensal/dataset_mensal_fake_1.xlsx  | BRA - PIM - Durable    |

    Scenario Outline: Check the FS variables with user without permission
        Given insert "manager" credentials and login via "MFA"
        And access main page			
        And access "Models" application
        And start a new project creation
		And select "time-series" projects
        And insert "<ProjectName>" at "ProjectName" field
		And upload a valid "<dataset>" dataset and go to step 2
        And click in add feature store variables
        And click in '4i-favorites' tab
		And search "<group>"
        When click "<group>" card
        Then the "<variable>" variable should be disabled

        Examples:
            | ProjectName           | dataset                                 | variable               |  group              |
            | projeto_mensal        | time-series/Mensal/dataset_mensal_fake_1.xlsx  | BRA - PIM - Durable    |  teste-nao-apagar-  |    
    