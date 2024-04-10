@MYPROJECTS_API
@4INTELLIGENCE @API @CREATEPROJECT @REGRESSION @TIMESERIES
Feature: My Project via API

	Background: Login
		Given insert "admin" credentials and login via "MFA"

	@SANITY
	Scenario Outline: Check download projects
		Then download project with "<id>" id and "<response>" response

    	Examples:
			| response 		| id 		               |
			| not found     | 63890828232d3a48ce2e3a42 |
			| bad request   | 123					   |

	@TS-6 @V3.2
	Scenario Outline: Update the project overview columns 
		And get first "<project>" id
		When update "<requestBody>" in project overview columns
		Then check the "<status_code>" and "<responseBody>" in project API

    	Examples:
			| project 		           				 |	requestBody		| status_code	| 	responseBody							|
			| ML02-15Y-Dataset-All-Sanity_with_error |	MASEs			| Success		|	MASEs									|
			| ML02-15Y-Dataset-All-Sanity_with_error |	MASES			| Bad Request	|	value is not a valid enumeration member	|			
			| ML02-15Y-Dataset-All-Sanity_with_error | 					| Bad Request	|	ensure this value has at least 1 items	|