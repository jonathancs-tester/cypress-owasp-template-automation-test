@ADMIN_FS_MENU
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Check Feature Store Admin menu 

@SANITY
Scenario Outline: Create a new indicator
    Given insert "admin" credentials and login via "MFA"
    And I visit "/"		
	And I click the "Feature Store Admin Button"	
    When I click the "Create new indicator button"
    And I write "Test-sanity" text in element "Indicator name en input"
    And I write "Test-sanity" text in element "Indicator name pt input"
    And I write "Test" text in element "Indicator short name en input"
    And I write "Test" text in element "Indicator short name pt input"
    And I write "Test description" text in element "Indicator description en input"
    And I write "Test description" text in element "Indicator description pt input"
    And I write "create an indicator test" text in element "Indicator full description en input"
    And I write "create an indicator test" text in element "Indicator full description pt input"
    And I select "EC - Ecuador" options in element "Indicator country input"
    And I write "test" text in element "Indicator source en input"
    And I write "test" text in element "Indicator source pt input"
    And I write "teste" text in element "Indicator projections input"
    And I select "MTG - Meteorology" options in element "Indicator sector input"
    And I select "Básico" options in element "Indicator access type input"
    And I write "1.0" text in element "Indicator ranking input"
    And I click the "Proceed new indicator button"
    And I select "Ecuador" options in element "Indicator category input"
    And I intercept "**/api-feature-store-stg/api/v1/indicators?language=en-us" route as "createIndicator" with "POST" http verbs
    And I click the "Confirm create Indicator button"
    Then I check if response of "@createIndicator" route is equal "200"

    Examples:
        | Inputs                                                                                                      |   Ordering                                                                      |
        | Test-sanity/Test/Test description/create an indicator test/EC - Ecuador/test/MTG - Meteorology/teste/Básico/1.0 | name/short-name/description/fullDescription/país/source/setor/projections/tipo-de-acesso/ranking  | 

Scenario: Edit an indicator
    Given insert "admin" credentials and login via "MFA"
    And do a new request with "success" to create a new indicator "inactive"
    And I visit "/"		
	And I click the "Feature Store Admin Button"
    And I write "${indicator}" text in element "Search indicator admin input"
    When I click the "Edit indicator button"
    And I write "Test-sanity" text in element "Indicator name en input"
    And I write "Test-sanity" text in element "Indicator name pt input"
    And I write "Test" text in element "Indicator short name en input"
    And I write "Test" text in element "Indicator short name pt input"
    And I write "Test description" text in element "Indicator description en input"
    And I write "Test description" text in element "Indicator description pt input"
    And I write "create an indicator test" text in element "Indicator full description en input"
    And I write "create an indicator test" text in element "Indicator full description pt input"
    And I write "test" text in element "Indicator source en input"
    And I write "test" text in element "Indicator source pt input"
    And I write "teste" text in element "Indicator projections input"
    And I write "1.0" text in element "Indicator ranking input[position=first]"
    And I select "Básico" options in element "Indicator access type input"
    And I click the "Proceed new indicator button"
    And I intercept "**/api-feature-store-stg/api/v1/indicators/**" route as "createIndicator" with "PUT" http verbs
    And I click the "Confirm create Indicator button"
    Then I wait "@createIndicator" routes
    And I can see element "Edit indicator button[idCode=@indicatorCodeCreated]"

# @SANITY
# Scenario: Create Series in indicator ok
#     Given insert "admin" credentials and login via "MFA"
#     When do a new request with "success" to create a new indicator 'Test-sanity-indicator'
#     Then check if the 'Test-sanity-indicator' indicator was create
#     And I visit "/"		
#     And I click the "Feature Store Admin Button"
#     And access "created" indicator    