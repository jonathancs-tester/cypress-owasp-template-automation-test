@PRIVATE_INDICATORS
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Private Indicators

    @SANITY
    Scenario: User with access for private indicator
        Given insert "admin" credentials and login via "MFA"
        When I visit "/feature-store/indicators/BRPRC0002"
        Then I can see element "Frequency Serie Select"

    Scenario: User without access for private indicator
        Given insert "view" credentials and login via "MFA"
        When I visit "/feature-store/indicators/BRPRC0002"
        Then I can't see element "Frequency Serie Select"	
    