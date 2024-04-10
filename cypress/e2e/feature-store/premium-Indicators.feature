@PREMIUM_INDICATORS
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Premium Indicators

    Background:
        Given insert "admin" credentials and login via "MFA"
        And I visit "/"		
        And I click the "Feature Store Button"

    @SANITY
    Scenario: Check Indicators premium page
        When I click the "Premium groups indicators"
        Then I can see text "ARG - Unemployment Rate - Urban - Test" in element "Indicator Card"


        
    