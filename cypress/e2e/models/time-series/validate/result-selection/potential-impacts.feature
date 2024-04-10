@POTENTIAL_IMPACTS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: Potential Impacts
	
	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

    @SANITY @TS-176 @AISELECTION
	Scenario Outline: Visualize Potencial impacts chart
	    Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "aiselection" menu in Model Explorer "time series" model
		And I can see element "Potential Impacts Chart"
		Then I click the "Potential Impacts See More Impacts Button"
		And I can see element "Potential Impacts Chart"
	
       Examples:
			| ProjectName      				 	| 
			| UI_FS_Mensal_Sanity_1  			|
			| Mensal_Sanity_lags  				| 
			| TS135_Mensal_Sanity  				| 		

	@SANITY @TS-176 @AISELECTION
	Scenario Outline: Not possible to visualize the Potencial impacts chart
		Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "aiselection" menu in Model Explorer "time series" model
		And I can see element "Potential Impacts Chart"
		Then I wait for element "Potential Impacts See More Impacts Button" be disabled
		
	Examples:
				| ProjectName      				 	| 
				| TS135_Diario  					|	
				| mod1627			  				| 			
	
	@TS-347	@TS-501 @AISELECTION
	Scenario Outline: Check exclusion variable in AI Selection
	    Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "aiselection" menu in Model Explorer "time series" model
		And I can see element "Understanding the Result"
		And I click the "See More Impacts Collapse"
		Then I can see only one of following text "massahabitual,rendanacionalbruta,rendahabitual" in element "Results Cards" 
		And I can see element "Potential Impacts Chart"
		And I click the "Potential Impacts See More Impacts Button"
		And I can see only one of following text "massahabitual,rendanacionalbruta,rendahabitual" in element "Potential Impacts Chart"

       Examples:
			| ProjectName						 | 
			| Massa_Com_Exclusao				 | 
			| Massa_Sem_Exclusao				 | 