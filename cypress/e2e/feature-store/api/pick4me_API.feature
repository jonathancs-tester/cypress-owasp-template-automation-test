@PICK4ME_API
@4INTELLIGENCE @API @REGRESSION @CRUD
Feature: Feature Store pick for me

	@SANITY
	Scenario Outline: Pick for me integration
		Given insert "admin" credentials and login via "MFA"
        When do a request with "<bodyType>"

        Examples:
            | bodyType           |
            |  anual.txt         |   
            |  diario.txt        | 
            |  mensal.txt        | 
            |  multiple_y.txt    | 
            |  zipped_body_1.txt | 