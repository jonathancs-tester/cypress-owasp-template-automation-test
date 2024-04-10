@UNDERSTAND_RESULTS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: Understand Results
	
	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
	
 	@TS-491 @TS-495 @TS-611
	Scenario Outline: Check variables with greater effect
	    Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "aiselection" menu in Model Explorer "time series" model
		And I select frequency "<Frequency>" in "Card Results"
		And I can see element "Understanding the Result"
		And I select "<Data>" options in element "Data Results Select"
		Then I can see text "<Variable>" in element "Understanding the Result"
		
       Examples:
			| ProjectName						 | Frequency | Variable								| Data       |
			| check_variable_with_greater_effect | original  | outlier								| 2022-11-01 |
			| ts495								 | annual 	 | seasonality							| 2022       |		
			| dataset_36obs						 | annual 	 | No insight available for this date	| 2018       |		