@INDICATORS_GROUPS_API
@4INTELLIGENCE @API @FEATURE_STORE @REGRESSION
Feature: Check Indicators List from API

Background:
    Given insert "admin" credentials and login via "MFA"

    #200
    @SANITY
    Scenario: CRUD of indicator in group
        And create new group of indicator
        When insert 'AREMP0085' indicator in created group
        And check if group contains 'AREMP0085' indicator
        Then delete 'AREMP0085' indicator in created group

    Scenario: CRUD of user in group
        And create new group of indicator
        When insert 'view_user' in created group
        And check if group contains 'view_user'
        Then delete user in created group