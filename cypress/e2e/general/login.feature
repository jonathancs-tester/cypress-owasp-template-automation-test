@LOGIN
@4INTELLIGENCE @UI @GENERAL @LOGIN @REGRESSION
Feature: Login to 4intelligence application

	@SANITY @F4-152 @F4-467
	Scenario: Login and logout with admin user
		Given insert "admin" credentials and login via "MFA"
		When I visit "/"
		Then I wait for element "Models" be enabled
		And I wait for element "Feature Store Button" be enabled
		And I wait for element "Feature Store Admin Button" be enabled
		And I wait for element "Access Group Button" be enabled
		And I wait for element "4casthub Admin Button" be enabled

	@SANITY @F4-467
	Scenario: Login with view user
		Given insert "view" credentials and login via "MFA"
		When I visit "/"
		Then I wait for element "Models" be enabled
		And I wait for element "Feature Store Button" be enabled
		And I can't see element "Feature Store Admin Button"
		And I can't see element "Access Group Button"
		And I can't see element "4casthub Admin Button"

	Scenario: Login with Feature Store user
		Given insert "feature_store" credentials and login via "MFA"
		When I visit "/"
		Then I visit "/models/projects"
		And I wait for element "Feature Store Button" be enabled
		And I can't see element "Feature Store Admin Button"
		And I can't see element "Access Group Button"
		And I can't see element "4casthub Admin Button"

	Scenario: Check 4casthub admin users authorities
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		When I click the "4casthub Admin Button"
		Then I can see element "Users Authorities Table"