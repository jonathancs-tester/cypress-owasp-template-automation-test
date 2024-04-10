@SERIES_API
@4INTELLIGENCE @API @FEATURE_STORE @REGRESSION
Feature: Check Series

Background:
    Given insert "admin" credentials and login via "MFA"

    Scenario Outline: Get all series from indicator
        Then get all series of "BRPRC0046" indicator with "<status>"

        Examples:
            | status        |
            | unauthorized  |
            | success       |
            | not found     |

    Scenario Outline: Get all series
        Then get all series with "<status>"

        Examples:
            | status        |
            | unauthorized  |
            | not found     |

    Scenario Outline: Get series by id
        Then get "BRPRC0046000OOML" series with "<status>"

        Examples:
            | status        |
            | unauthorized  |
            | success       |
            | not found     |

    Scenario: Delete series by id
        And do a new request with "success" to create a new indicator 'inactive'
        And create a new serie on "created" indicator with 'success'
        When delete "created" serie on 'created' indicator with 'success'

    Scenario Outline: Check edit series roules
        Then edit "<serie>" serie to "<accessType>" access on "<indicator>" indicator with "<status>"

        Examples:
            | indicator     | serie              | accessType   | status          |
            | BRPRC0046     | BRPRC0046000OAQL   | default      | success         |
            | BRPRC0046     | BRPRC0046000OAQL   | freemium     | success         |
            | BRGDP0043     | BRGDP0043000OOML   | freemium     | bad request     |
            | AREMP0085     | AREMP0085000OEYB   | freemium     | bad request     |
            
    # @TS-192 -> cenario que gera serie em manutençao e da problema no cache do pick4me
    # Scenario: Edit series by id
    #     And do a new request with "success" to create a new indicator 'inactive'
    #     And check if the 'test indicator name' indicator was create
    #     And create a new serie on "created" indicator with 'success'
    #     Then edit "created" serie on 'created' indicator with 'success'
    #     And delete "created" serie on 'created' indicator with 'success'