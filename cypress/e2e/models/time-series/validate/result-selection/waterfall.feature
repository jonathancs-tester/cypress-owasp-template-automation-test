@WATERFALL
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: Waterfall
	
	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

    @SANITY @TS-337 @AISELECTION
	Scenario Outline: Check Waterfall chart for AI selection
	    Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "aiselection" menu in Model Explorer "time series" model
		And I can see element "Understanding the Result"
		And I wait for element "See More Impacts Collapse" be enabled
		And I click the "See More Impacts Collapse"
		Then I get value reference a Cards
		And I click the "Understanding Results Waterfall Button"
		And I get value reference a Waterfall
		And I compare cards with Waterfall
		
       Examples:
			| ProjectName			| 
			| Massa_Com_Exclusao	| 
			| Massa_Sem_Exclusao	|
			