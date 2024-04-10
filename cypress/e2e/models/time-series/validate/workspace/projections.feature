@PROJECTIONS_WORKSPACE
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @WORKSPACE
Feature: Workspace - Projections

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@TS-1006
	Scenario: Verify filters sidebar for projections
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebarprojections]"
		When I click the "Open Filters Sidebar Button"
		And I select frequency "annual" in "Filter Sidebar"
		And I wait for element "Select One Checkbox[name=variation]" be enabled
		And I set "Select One Checkbox[name=variation]" to checked
		And I click the "Latest Data Toggle"
		And I click the "Close Filters Sidebar Button"
		Then I can see element "Result Container Chart"
		And I can see text "Annual" in element "Selected Frequency Text[position=first]"
		And I can see text "Annual" in element "Selected Frequency Text[position=1]"
		And I can't see element "Selected Latest Data Text"
		And I can see text "Variation" in element "Result Container Chart"
		And I can see text "Variation" in element "Explanatory Variables Chart"

	@CS-450 @CS-459 @CS-454
	Scenario: Verify inflation in Understanding the Result
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebarprojections]"
		And I can see element "Understanding the Result"
		And I get after info in "Annual Summary Level Table"
		And I can see text "Nominal value" in element "Selected Inflation Text[position=first]"
		And I can see text "inflation" in element "Understanding the Result"
		When I click the "Open Filters Sidebar Button"
		And I click the "Filter Radio[name=real]"
		And I click the "Close Filters Sidebar Button"
		And I get before info in "Annual Summary Level Table"
		Then I can see element "Understanding the Result"
		And I can see text "Real value" in element "Selected Inflation Text"
		And I can't see any of following text "inflation" in element "Understanding the Result"
		And I compare after info is not equal before info

	@TS-945 @TS-1005
	Scenario: Verify ajusted value in Understanding the Result
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebarprojections]"
		And I can see element "Understanding the Result"
		And I get after info in "Annual Summary Level Table"
		And I can see text "Adjusted" in element "Selected Forecast Text[position=first]"
		When I click the "Open Filters Sidebar Button"
		And I click the "Filter Radio[name=original;position=last]"
		And I click the "Close Filters Sidebar Button"
		And I get before info in "Annual Summary Level Table"
		Then I can see element "Understanding the Result"
		And I can see text "Original" in element "Selected Forecast Text"
		And I compare after info is not equal before info

	@CS-416
	Scenario: Verify ajusted value in Result Container Chart
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebarprojections]"
		And I can see element "Result Container Chart"
		And I can see text 0 attribute height in element "Result Forecast Column Chart"
		And I should see is equal to 12 items of "Result Forecast Column Chart"
		And I can see text "Adjusted" in element "Selected Forecast Text[position=first]"
		When I click the "Open Filters Sidebar Button"
		And I click the "Filter Radio[name=original;position=last]"
		And I click the "Close Filters Sidebar Button"
		Then I can see element "Result Container Chart"
		And I can see text "Original" in element "Selected Forecast Text"
		And I can see text 211 attribute height in element "Result Forecast Column Chart"
			
	@CS-451
	Scenario: Check inflation in potencial impacts
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=mensal_sem_agregacao;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebarprojections]"
		And I can see element "Potential Impacts Chart"
		And I get after info in "Potential Impacts Value Chart[position=first]"
		And I can see text "Nominal value" in element "Selected Inflation Text[position=first]"
		When I click the "Open Filters Sidebar Button"
		And I click the "Filter Radio[name=real]"
		And I click the "Close Filters Sidebar Button"
		And I get before info in "Potential Impacts Value Chart[position=first]"
		Then I can see element "Potential Impacts Chart"
		And I can see text "Real value" in element "Selected Inflation Text"
		And I compare after info is not equal before info

	@CS-501
	Scenario: Export xlsx for Projections
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebarprojections]"
		When I can see element "Export Dowload Button"
		And I click the "Export Dowload Button"
		Then I check if download size is greather than 200 kb
		And I check if "forecast" data is finding in download file
		And I clear download folder