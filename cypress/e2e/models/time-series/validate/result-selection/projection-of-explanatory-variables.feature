@PROJECTION_OF_EXPLANATORY_VARIABLES
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: Projection Of Explanatory Variables
	
	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		
	@TS-372 @AISELECTION
	Scenario Outline: Show variables in Projection - Ai Selection
	    Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "aiselection" menu in Model Explorer "time series" model
		And I select frequency "<Frequency>" in "Card Results"
		And I can see element "Result Container Chart"
		Then I select "<Variable>" options in element "Projection os Explanatory Variables Select"
		
       Examples:
			| ProjectName	| Frequency | Variable        |
			| dataset_exp_z	| annual    | z_fs_taxa_selic |

	@TS-411 @USERSELECTION
	Scenario Outline: Show variables in Projection - User Selection
	    Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "userselection" menu in Model Explorer "time series" model
		Then I select "<Variable>" options in element "Projection os Explanatory Variables Select"
		
       Examples:
			| ProjectName	 | Variable        |
			| dataset_exp_z	 | z_fs_taxa_selic |

    @SANITY @AISELECTION
    Scenario Outline: Check AI selection errors message
        When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "aiselection" menu in Model Explorer "time series" model
		Then I can see text "<message>" in element "Error Mensage Explanatory Variables Chart"
		And I can see text "<message>" in element "Error Mensage Potential Impacts Chart"

        Examples:
			| ProjectName       | message    										|
			| mod1827_v1  		| No explanatory variable to be displayed.   		|
