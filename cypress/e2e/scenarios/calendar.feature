@4INTELLIGENCE @UI @SCENARIOS @CALENDAR @REGRESSION
Feature: F4-229: Calendar

	@F4-1341
	Scenario Outline: Check Calendar Table's should be renderized
		Given insert "<userType>" credentials and login via "MFA"
		And access main page			
		When access "Calendário" tab
		And check Calendar Table's tabs
		#And check time columm order
		Then Calendar Table's should be renderized

		Examples:
			| userType |
			| admin    |
			| view     |
			| editor   |

