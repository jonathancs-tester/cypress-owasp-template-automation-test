@4INTELLIGENCE @UI @SCENARIOS @CHARTNEWS @REGRESSION @CRUD
Feature: CRUD for Serie News

	Background:
		Given insert "editor" credentials and login via "MFA"
		And access main page			
		And click to access the "Criar notícia" page

	@SANITY
	Scenario: Create serie news
		When to write a "chart" post
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "chartSource"
		And insert "projectionInfo" at "projection"
		And insert "elaborationInfo" at "elaboration"
		And click to select chart
		And insert "BRGDP0013000ROQL" at "chartCode"
		And insert "gráfico de barras verticais" at "chartType"
		And click confirm chart settings button
		And click to create news button
		Then it should be possible to view the "chart" post components
		And click to archive the "PIB" post

	@SANITY
	Scenario: Update serie news
		And to write a "chart" post
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "chartSource"
		And insert "projectionInfo" at "projection"
		And insert "elaborationInfo" at "elaboration"
		And click to select chart
		And insert "BRGDP0002000ROQL" at "chartCode"
		And insert "gráfico de barras verticais" at "chartType"
		And click confirm chart settings button
		And click to create news button
		And it should be possible to view the "chart" post components
		When click to update a "chart" post
		Then to update a "chart" post to a "chart" post
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "chartSource"
		And insert "projectionInfo" at "projection"
		And insert "elaborationInfo" at "elaboration"
		And click to select chart
		And insert "BRGDP0002000ROQL" at "chartCode"
		And insert "gráfico de barras verticais" at "chartType"
		And click confirm chart settings button
		And click to update news button
		And click to archive the "PIB" post

	@SANITY
	Scenario: Archive serie news
		And to write a "chart" post
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "chartSource"
		And insert "projectionInfo" at "projection"
		And insert "elaborationInfo" at "elaboration"
		And click to select chart
		And insert "BRGDP0013000ROQL" at "chartCode"
		And insert "gráfico de barras verticais" at "chartType"
		And click confirm chart settings button
		And click to create news button
		Then click to archive the "PIB" post

	@REGRESSION @F4-316
	Scenario Outline: Create serie news without required field
		When to write a "chart" post
		And insert "<title>" at "title"
		And insert "<editor>" at "editor"
		And insert "<postSection>" at "postSection"
		And insert "<source>" at "chartSource"
		And insert "<projection>" at "projection"
		And insert "<elaboration>" at "elaboration"
		And click to select chart
		And insert "<chartCode>" at "chartCode"
		And insert "<chartType>" at "chartType"
		And click confirm chart settings button
		And click to create news button
		Then a error message should be visible

		Examples:
			| title | source    | editor | postSection | projection | elaboration | chartCode        | chartType                   |
			| empty | chartInfo | teste  | PIB         | teste      | teste       | BRGDP0013000ROQL | gráfico de barras verticais |
			| teste | empty     | teste  | PIB         | teste      | teste       | BRGDP0013000ROQL | gráfico de barras verticais |
			| teste | chartInfo | empty  | PIB         | teste      | teste       | BRGDP0013000ROQL | gráfico de barras verticais |
			| teste | chartInfo | teste  | empty       | teste      | teste       | BRGDP0013000ROQL | gráfico de barras verticais |
			| teste | chartInfo | teste  | PIB         | empty      | teste       | BRGDP0013000ROQL | gráfico de barras verticais |
			| teste | chartInfo | teste  | PIB         | teste      | empty       | BRGDP0013000ROQL | gráfico de barras verticais |
			| teste | chartInfo | teste  | PIB         | teste      | teste       | empty            | gráfico de barras verticais |
			| teste | chartInfo | teste  | PIB         | teste      | teste       | BRGDP0013000ROQL | empty                       |

	@REGRESSION
	Scenario: Create serie news without chart
		When to write a "chart" post
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "chartSource"
		And insert "projectionInfo" at "projection"
		And insert "elaborationInfo" at "elaboration"
		And click to create news button
		Then a error message should be visible
