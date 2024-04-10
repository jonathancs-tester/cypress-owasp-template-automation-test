@4INTELLIGENCE @UI @SCENARIOS @IMAGENEWS @REGRESSION @CRUD
Feature: CRUD for Image News

	Background:
		Given insert "editor" credentials and login via "MFA"
		And access main page			
		And click to access the "Criar notícia" page

	@SANITY
	Scenario: Create image news	
		When to write a "image" post
		And upload the image
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "imageSource"
		And click to create news button
		Then it should be possible to view the "image" post components
		And click to archive the "PIB" post

	@SANITY
	Scenario: Update image news
		And to write a "image" post
		And upload the image
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "imageSource"
		And click to create news button
		And it should be possible to view the "image" post components
		When click to update a "image" post
		Then to update a "image" post to a "image" post
		And upload the image
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "source"
		And click to update news button
		And click to archive the "PIB" post

	@SANITY
	Scenario: Archive image news
		And to write a "image" post
		And upload the image
		And insert "titleInfo" at "title"
		And insert "bodyInfo" at "body"
		And insert "editorInfo" at "editor"
		And insert "PIB" at "postSection"
		And insert "sourceInfo" at "imageSource"
		And click to create news button
		Then click to archive the "PIB" post

	@REGRESSION @F4-316
	Scenario Outline: Create image news without required field
		When to write a "image" post
		And upload the image
		And insert "<title>" at "title"
		And insert "<editor>" at "editor"
		And insert "<postSection>" at "postSection"
		And insert "<source>" at "imageSource"
		And click to create news button
		Then a error message should be visible

		Examples:
			| title | source | editor | postSection |
			| empty | teste  | teste  | PIB         |
			| teste | empty  | teste  | PIB         |
			| teste | teste  | empty  | PIB         |
			| teste | teste  | teste  | empty       |

	@REGRESSION
	Scenario: Create image news without upload image
		When to write a "image" post
		And insert "teste" at "title"
		And insert "teste" at "editor"
		And insert "PIB" at "postSection"
		And insert "teste" at "imageSource"
		And click to create news button
		Then a error message should be visible
