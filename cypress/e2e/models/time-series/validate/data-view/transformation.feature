@DATAVIEW_TRANSFORMATION
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION 
Feature: Data View Transformation

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	Scenario: Check Historical Data without transformation
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Without_YoY_Acum12m" text in element "Project Name Input"
		And I attach fixture "time-series/weekly_cooking_reduzido.xlsx" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "yyyy-MM-dd" options in element "Format Date Select"
		And I can see element "Visualize Data Button"
		When I click the "Visualize Data Button"
		And click in "orig" transformation
		Then I can see text "Select at least one transformation." in element "Empty Historical Data Graph"