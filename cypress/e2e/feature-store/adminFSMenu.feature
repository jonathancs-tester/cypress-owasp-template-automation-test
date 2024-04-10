@ADMIN_FS_MENU
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Check Feature Store Admin menu 

@SANITY
Scenario: Check the Feature Store Admin button with success
    Given insert "admin" credentials and login via "MFA"
    And access main page			
    When access "Feature Store Admin" application
    Then check if the items of the table are visible

Scenario Outline: Create a new indicator
    Given insert "admin" credentials and login via "MFA"
    And access main page		
    And access "Feature Store Admin" application
    When click in create new indicator
    And insert the "<Inputs>" inputs on "<Ordering>" ordering in "create" mode
    And click in proceed
    And select 'Ecuador' category
    And confirm 'create' new indicator
    Then the indicator should be visible

    Examples:
        | Inputs                                                                                                      |   Ordering                                                                      |
        | Test-sanity/Test/Test description/create an indicator test/EC - Ecuador/test/MTG - Meteorology/teste/Básico | name/short-name/description/fullDescription/país/source/setor/projections/tipo-de-acesso  | 

Scenario Outline: Edit an indicator
    Given insert "admin" credentials and login via "MFA"
    And do a new request with "success" to create a new indicator 'inactive' 
    And access main page		
    And access "Feature Store Admin" application
    When click in edit indicator
    And insert the "<Inputs>" inputs on "<Ordering>" ordering in "edit" mode
    And click in proceed
    And confirm 'edit' new indicator
    Then the indicator should be visible

    Examples:
        | Inputs                                                                                             | Ordering                                                                  |
        | Test-sanity/Test/Test description/create an indicator test/MX - Mexico/test/CAL - Statistics/teste | name/short-name/description/fullDescription/país/source/setor/projections | 

# @SANITY
# Scenario: Create Series in indicator ok
#     Given insert "admin" credentials and login via "MFA"
#     When do a new request with "success" to create a new indicator 'Test-sanity-indicator'
#     Then check if the 'Test-sanity-indicator' indicator was create
#     And access main page			
#     And access "Feature Store Admin" application
#     And access "created" indicator