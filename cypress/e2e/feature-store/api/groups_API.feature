@GROUPS_API
@4INTELLIGENCE @API @FEATURE_STORE @REGRESSION
Feature: Check groups List from API

Background:
    Given insert "admin" credentials and login via "MFA"

    @SANITY
    Scenario Outline:Create new group and edit tests
        When create a new "Test-sanity-group" group in "My favorites" through the API
        And save Id from 'Test-sanity-group' group
        Then edit the group to 'sanity-test-new-group' with '<status>'
        And delete "<deleteGroup>" garbage in "My favorites"

        Examples:
            | status        | deleteGroup           |
            | unauthorized  | Test-sanity-group     |
            | success       | sanity-test-new-group |
            | bad request   | Test-sanity-group     |
            | not found     | Test-sanity-group     |
    
    Scenario Outline: Download series csv/xlsx
        When create a new "Test-sanity-group" group in "My favorites" through the API
        And save Id from 'Test-sanity-group' group
        And insert "BRPRC0046000OOML" serie with "success"
        Then download series with "<status>" in "<file>" format
        And delete "Test-sanity-group" garbage in "My favorites"

        Examples:
            | status        | file  |
            | unauthorized  | csv   |
            | success       | csv   |
            | not found     | csv   |
            | unauthorized  | xlsx  |
            | success       | xlsx  |
            | not found     | xlsx  |
    
    Scenario Outline: Get series from group
        When create a new "Test-sanity-group" group in "My favorites" through the API
        And save Id from 'Test-sanity-group' group
        And insert "BRPRC0046000OOML" serie with "success"
        Then search "BRPRC0046000OOML" series with "<status>"
        And delete "Test-sanity-group" garbage in "My favorites"

        Examples:
            | status        |
            | unauthorized  |
            | success       |
            | not found     |

    Scenario Outline: Insert series in group
        When create a new "Test-sanity-group" group in "My favorites" through the API
        And save Id from 'Test-sanity-group' group
        Then insert "BRPRC0046000OOML" serie with "<status>"
        And delete "Test-sanity-group" garbage in "My favorites"

        Examples:
            | status        |
            | unauthorized  |
            | success       |
            | not found     | 

    Scenario Outline: Insert inactive series in group with view user
        Given insert "view" credentials and login via "MFA"    
        When create a new "Test-sanity-group" group in "My favorites" through the API
        And save Id from 'Test-sanity-group' group
        Then insert "ARPRC0114000OAQL" serie with "<status>"
        And delete "Test-sanity-group" garbage in "My favorites"
        
        Examples:
            | status        |    
            | not found     |       
    
    Scenario Outline: Delete series in group
        When create a new "Test-sanity-group" group in "My favorites" through the API
        And save Id from 'Test-sanity-group' group
        And insert "BRPRC0046000OOML" serie with "success"
        Then delete "BRPRC0046000OOML" serie with "<status>"
        And delete "Test-sanity-group" garbage in "My favorites"

        Examples:
            | status        |
            | unauthorized  |
            | success       |
            | not found     |