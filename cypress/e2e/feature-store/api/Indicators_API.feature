@INDICATORS_LIST_API
@4INTELLIGENCE @API @FEATURE_STORE @REGRESSION
Feature: Check Indicators List from API

Background:
    Given insert "admin" credentials and login via "MFA"

    #200
    @SANITY
    Scenario: Create new indicator with success
        When do a new request with "success" to create a new indicator 'inactive'
        And inactive 'created' indicator
        Then the 'created' indicator should be inactive
        And do a new request with "already created" to create a new indicator 'inactive'
        And do a new request with "non sequential id" to create a new indicator 'inactive'

    #404
    Scenario: Try to create new indicator with not found
        Then do a new request with "not found" to create a new indicator 'inactive'

    #401
    Scenario: Try to create new indicator with unauthorized
        Then do a new request with "unauthorized" to create a new indicator 'inactive'
    
    #401
    Scenario: Try to create new indicator with bad request
        Then do a new request with "bad request" to create a new indicator 'inactive'

    Scenario Outline: Download all series from indicator with csv/xlsx format
        Then download all series of "BRIND0076" indicator in "<file>" format with "<status>"

        Examples:
            | status        | file  |
            | unauthorized  | csv   |
            | success       | csv   |
            | not found     | csv   |
            | unauthorized  | xlsx  |
            | success       | xlsx  |
            | not found     | xlsx  |

    Scenario Outline: Download some series from indicator with csv/xlsx format
        Then download "BRPRC0046000OOML" series of "BRPRC0046" indicator in "<file>" format with "<status>"

        Examples:
            | status        | file  |
            | unauthorized  | csv   |
            | success       | csv   |
            | unauthorized  | xlsx  |
            | success       | xlsx  |

    Scenario Outline: Check serie download error indicator inative with view user
        Given insert "view" credentials and login via "MFA"
        Then download "ARPRC0114000OAQL" series of "ARPRC0114" indicator in "<file>" format with "<status>"

        Examples:
            | status        | file  |
            | not found     | csv   |
            | not found     | xlsx  |
    
    # @SANITY Cenário travando os testes
    # Scenario: Check if inactive indicator when delete the last indicator serie
    #     And do a new request with "success" to create a new indicator 'active'
    #     And check if the 'test indicator name' indicator was create
    #     And create a new serie on "created" indicator with 'success'
    #     When delete "created" serie on 'created' indicator with 'success'
    #     Then the 'created' indicator should be inactive

    # Scenario: Inactive all test indicators
    #     Then Inactive all 'test' indicators