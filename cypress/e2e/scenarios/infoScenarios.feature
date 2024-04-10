@4INTELLIGENCE @UI @SCENARIOS @CHECK_TABS @REGRESSION
Feature: Check Cenarios page

	@SANITY
	Scenario Outline: Add news and check at mainly tabs
		Given insert "editor" credentials and login via "MFA"
		And access main page
		And clear data with "titleInfo" title in "<tabName>" tab
		And click to access the "Criar notícia" page
		When a post is write a at "<tabName>" post
		And click to create news button
		And access "<tabName>" tab
		And check if news were posted
		Then it should be possible check "<tabName>" news and delete them

		Examples:
			| tabName   	|
			| Destaques 	|
			| Politica  	|
			| PIB Regional  |

	@SANITY
	Scenario Outline: Add news and check at International's tabs
		Given insert "editor" credentials and login via "MFA"
		And access main page
		And clear data with "titleInfo" title in "<tabName>" tab
		And click to access the "Criar notícia" page
		When a post is write a at "<tabName>" post
		And click to create news button
		And access "<tabName>" tab
		And check if news were posted
		Then it should be possible check "<tabName>" news and delete them

		Examples:
			| tabName |
			| EUA     |
			| UE      |
			| China   |

	Scenario: Check Maintenance image when I have network error
		Given insert "editor" credentials and login via "MFA"
		And access main page
		When simulate network error in series endpoint
		And access "Emprego" tab
		Then maintenance page should be renderized

	@SANITY @F4-454
	Scenario Outline: Add news and check at Conjuntura's tabs
		Given insert "editor" credentials and login via "MFA"
		And access main page
		And clear data with "titleInfo" title in "<tabName>" tab
		And click to access the "Criar notícia" page
		When a post is write a at "<tabName>" post
		And click to create news button
		And access "<tabName>" tab
		And check if news were posted
		Then it should be possible check "<tabName>" news and delete them

		Examples:
			| tabName   |
			| Industria |
			| Emprego   |
			| Varejo    |
			| Credito   |
			| Inflacao  |
			| Fiscal    |
			| Externo   |
			| Monetaria |

	@SANITY
	Scenario: Login as isAdmin and check Projeções page
		Given insert "admin" credentials and login via "MFA"
		And access main page
		When access "Projeções" tab
		Then all projection table data should be renderized

	@F4-380
	Scenario: Check if not possible to view the Politica tab
		Given insert "ocb" credentials and login via "MFA"
		And access main page
		Then it should not be possible to access Politica tab

	@F4-450
	Scenario Outline: Login as view and check Politica tab
		When insert "view" credentials and login via "MFA"
		And access main page
		And access "<tabName>" tab
		Then check if it is possible to view "<text>" data

		Examples:
			| tabName  | text      |
			| Politica | Bolsonaro |

	@SANITY
	Scenario Outline: Check details with one or multiple charts
		Given insert "stg" credentials and login via "MFA"
		And access main page
		When click "Cestas-GE" in Indicadores menu
		And click to more details in "<code>" indicator
		Then it should be possible list "<count>" indicators	

		Examples:
			| code  												| count  	|
			| BRPRC0300000OOML-BRPRC0308000OOML-BRPRC0306000OOML 	| 3	 		|
			| BRPRC0024000OOMM 										| 1	 		|