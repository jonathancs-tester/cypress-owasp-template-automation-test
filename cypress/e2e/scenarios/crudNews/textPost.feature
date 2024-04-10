@4INTELLIGENCE @UI @SCENARIOS @TEXTNEWS @REGRESSION @CRUD
Feature: CRUD for Text News

	Background:
		Given insert "editor" credentials and login via "MFA"
		And access main page			
		And click to access the "Criar notícia" page

	@SANITY 
	Scenario: Create text news
		When to write a "text" post
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And click to create news button
		Then it should be possible to view the "text" post components
		And click to archive the "PIB" post

	@SANITY
	Scenario: Update text news
		When to write a "text" post
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And click to create news button
		And click to update a "text" post
		Then to update a "text" post to a "text" post
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And click to update news button
		And click to archive the "PIB" post

	@SANITY
	Scenario: Archive text news
		When to write a "text" post
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And click to create news button
		Then click to archive the "PIB" post

	@REGRESSION @F4-293
	Scenario Outline: Create text news without required field
		When to write a "text" post
		And insert "<title>" at "title"
		And insert "<body>" at "body"
		And insert "<editor>" at "editor"
		And insert "<postSection>" at "postSection"
		And click to create news button
		Then a error message should be visible

		Examples:
			| title | body  | editor | postSection |
			| empty | teste | teste  | PIB         |
			| teste | empty | teste  | PIB         |
			| teste | teste | empty  | PIB         |
			| teste | teste | teste  | empty       |
