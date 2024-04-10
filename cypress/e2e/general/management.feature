@MANAGEMENT
@4INTELLIGENCE @UI @GENERAL @REGRESSION @MANAGEMENT
Feature: Management - User Control

	Scenario: No Admin button found
		When insert "view" credentials and login via "MFA"
		And access main page
		Then it should not be possible to acess admin management

	@SANITY
	Scenario: Check user and authority
		Given insert "admin" credentials and login via "MFA"
		And access main page
		When access "4CastHub Management" application
		Then it should be possible to find "admin_user" with "isFaaS" authority

	@SANITY @V2.6
	Scenario Outline: Create user with managers and check license
		Given insert "<manager>" credentials and login via "MFA"
		And access main page
		And access user control
		And it should be not list "<manager>"
		And block all users "Active"
		And it should be check the "<initial_license>" license value
		When add new user
		Then it should be check the "<final_license>" license value
		
		Examples:
			| manager 					| initial_license 	| final_license |
			| manager  					| 1					| 2				|
			| manager_without_project 	| 0					| 1				|

	Scenario: Check if create users button disabled when request failed
		Given insert "manager" credentials and login via "MFA"
		And access main page
		And error in list users request
		And access user control
		Then it should not be possible to create new user

	@SANITY
	Scenario Outline: check create and delete manager in user control tab
		Given insert "admin" credentials and login via "MFA"
		And access main page
		And access user control
		And create new customer
		When insert new manager in created Group
		And edit license
		And enter visualize customer page
		And it should be check the "<initial_license>" license value
		And add new user
		And it should be check the "<final_license>" license value
		And back to customer list page
		Then delete manager
		
		Examples:
			| initial_license | final_license 	|
			| 0				  | 1				|
			