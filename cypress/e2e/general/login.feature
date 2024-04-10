@LOGIN
@4INTELLIGENCE @UI @GENERAL @LOGIN @REGRESSION
Feature: Login to 4intelligence application

	@SANITY @F4-152 @F4-467
	Scenario: Login and logout with admin user
		When insert "admin" credentials and login via "MFA"
		And access main page			
		Then it should be possible to access the "Models" with "admin" user
		And it should be possible to access the "Feature Store" with "admin" user
		# And it should be possible to access the "Scenarios" with "admin" user
		And it should be possible to access the "Feature Store Menu" with "admin" user

	@SANITY @F4-467
	Scenario: Login with view user
		When insert "view" credentials and login via "MFA"
		And access main page			
		Then it should be possible to access the "Models" with "view" user
		And it should be possible to access the "Feature Store" with "view" user
		# And it should be possible to access the "Scenarios" with "view" user

	Scenario: Login with Feature Store user
		When insert "feature_store" credentials and login via "MFA"
		And access main page			
		And it should be possible to access the "Feature Store" with "feature_store" user
		And it should not be possible to access the "Models" with "feature_store" user