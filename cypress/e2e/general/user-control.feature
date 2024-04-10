@USER_CONTROL
@4INTELLIGENCE @UI @GENERAL @REGRESSION @USER_CONTROL
Feature: Management - User Control

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @V2.6
	Scenario: Create customer without manager and invite new users
		And I intercept "**/clients?**" route as "waitClient" with "GET" http verbs
		And I click the "User Settings Button"
		And I click the "User Control Button"
		And I click the "User Setting Modal[position=first]"
		And I wait "@waitClient" routes
		And I click the "Register Customer Button"
		And I write "qa-without-manager" random text in element "Customer Name Input"
		And I write "3" text in element "Number of License Input"
		And I set "SSO Toggle" to checked
		And I set "Select One Checkbox[name=time-series]" to checked
		And I set "Select One Checkbox[name=classification]" to checked
		And I set "Select One Checkbox[name=feature-store]" to checked
		And I click the "Register Button[position=1]"
		And I wait "@waitClient" routes
		And I click the "Visualize Customer Button[position=first]"
		And I click the "Invite New User Button"
		And I write "user-qa@4casthub.com.br" random text in element "User Email Input"
		And I click the "Register Button"
		And I click the "OK Button"
		Then I can see text "1" in element "License Quantity"
		And I click the "Status Button[position=first]"
		And I click the "Blocked Option Button"
		And I click the "Status Button[position=first]"
		And I click the "Delete User Button[position=first]"
		And I click the "Confirm delete Customer user"
		And I can see text "0" in element "License Quantity"

	@SANITY @V2.6
	Scenario: Create customer without manager and invite new users
		And I intercept "**/clients?**" route as "waitClient" with "GET" http verbs
		And I click the "User Settings Button"
		And I click the "User Control Button"
		And I click the "User Setting Modal[position=first]"
		And I wait "@waitClient" routes
		And I click the "Register Customer Button"
		And I write "qa-without-manager" random text in element "Customer Name Input"
		And I write "3" text in element "Number of License Input"
		And I set "SSO Toggle" to checked
		And I set "Select One Checkbox[name=time-series]" to checked
		And I set "Select One Checkbox[name=classification]" to checked
		And I set "Select One Checkbox[name=feature-store]" to checked
		And I click the "Add Manager Button"
		And I write "manager-qa@4casthub.com.br" random text in element "Manager Email Input"
		And I click the "Register Button[position=1]"
		And I wait "@waitClient" routes
		And I click the "Visualize Customer Button[position=first]"
		And I click the "Status Button[position=first]"
		And I wait for element "Blocked Option Button" be disabled
		And I click the "Menu Modal[position=first]"
		And I click the "Invite New User Button"
		And I write "user-qa@4casthub.com.br" random text in element "User Email Input"
		And I click the "Register Button"
		And I click the "OK Button"
		Then I can see text "2" in element "License Quantity"
		And I click the "Delete User Button[position=last]"
		And I click the "Confirm delete Customer user"
		And I can see text "1" in element "License Quantity"