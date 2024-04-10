@PREMIUM_INDICATORS
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Check Indicators List from UI

Background:
        Given insert "admin" credentials and login via "MFA"
        And access main page			
        And access "Feature Store" application

    @SANITY
    Scenario: Check Indicators premium page
        When I click the "Premium groups indicators"
        Then check "Unemployment rate indicates the moving average of the last three months of the ratio between unemployed people and the economically active population." description, "Indec" source and, "4intelligence" projection in the "ARG - Unemployment Rate - Urban" indicator


        
    