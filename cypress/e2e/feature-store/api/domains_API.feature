@DOMAINS_API
@4INTELLIGENCE @API @FEATURE_STORE @REGRESSION
Feature: Check Domains

Background:
    Given insert "admin" credentials and login via "MFA"

    @SANITY
    Scenario Outline: Get domains
        Then get domains with '<status>'

        Examples:
            | status        |
            | unauthorized  |
            | success       |
            | not found     |