@OVERVIEW_WORKSPACE
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @WORKSPACE
Feature: Workspace - Overview

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@TS-937 @TS-936 @TS-941
	Scenario: Adjust forecast value for Results chart
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebaroverview]"
		When I click the "Enable Edition Button"
		And I can see element "Download Results Blocked Tooltip"
		And I click the "Expand Category Button[name=regiao-outras-regioes]"
		And I click the "Expand Category Button[name=regiao-outras-regioes-tipo-comercial]"
		And I click the "Historical Edit Grid Input[name=regiao-outras-regioes;position=first]"
		And I click the "Forecast Edit Grid Input[name=0;position=first]"
		And I write "987654321" text in element "Forecast Edit Grid Input[name=0;position=first]"
		And I click the "Historical Edit Grid Input[name=regiao-outras-regioes;position=first]"
		And I wait for element "Download Results Button" be disabled
		And I click the "Save Edition Button"
		And I clear download folder
		Then I click the "Download Results Button"
		And I click the "Download Current Data Button"
		And I check if download size is greather than 200 kb
		And I check if "987654321" data is finding in download file
		And I check if "total" data is finding in download file
		And I clear download folder

	@TS-100
	Scenario: Verify filters sidebar for overview
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebaroverview]"
		And I can see text "Original" in element "Selected Frequency Text[position=0]"
		And I can see text "Original" in element "Selected Frequency Text[position=1]"
		And I can see text "Level" in element "Selected Transformation Text[position=0]"
		And I can see text "Level" in element "Selected Transformation Text[position=1]"
		When I click the "Open Filters Sidebar Button"
		And I select frequency "annual" in "Filter Sidebar"
		And I click the "Filter Radio[name=variation-%-(yoy)]"
		And I click the "Filter Radio[name=adjusted]"
		And I click the "Calendar DatePicker[name=filter-period]"
		And I click "2020" name in "Select Date Calendar DatePicker"
		And I click "2021" name in "Select Date Calendar DatePicker"
		And I click the "Close Filters Sidebar Button"
		And I can see text "Annual" in element "Selected Frequency Text[position=0]"
		And I can see text "Annual" in element "Selected Frequency Text[position=1]"
		And I can see text "Variation" in element "Selected Transformation Text[position=0]"
		And I can see text "Variation" in element "Selected Transformation Text[position=1]"
		And I can see text "Adjusted" in element "Selected Forecast Text[position=0]"
		And I click the "Download Results Button"
		And I click the "Download All Data Button"
		And I check if download size is greather than 200 kb
		And I clear download folder

	@TS-941
	Scenario: Not possible adjust forecast value with another user adjusting
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "mensal_all_with_pick4me" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_all_with_pick4me;position=first]"
		And I write "mensal_sanity_lags" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_sanity_lags;position=first]"
		And I click the "Confirm Workspace Button"
		And I write "conflict_adjust_user" text in element "Workspace Name Input"
		And I write "conflict_adjust_user" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		When I click the "Invite Users Button"
		And I write "read-project@4casthub.com" text in element "Add Share User Input"
		And I click the "Share Confirm Button"
		And I select "Can edit" options in element "Sharing User Role Select[name=read-project@4casthub.com]"
		And I click the "Publish Button"
		And I can see only one of following text "We are creating a preview of your workspace. This process may take a few minutes, please come back later." in element "Publish/Preview Description Modal"
		And I can't see element "Error Modal"
		And I click the "OK Button"
		And I wait for element "Access Workspace Button" be enabled
		And I click the "Access Workspace Button"
		And I click the "Menu Model Explorer[index=workspacesidebaroverview]"
		And I click the "Enable Edition Button"
		Then insert "read_project" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I can see element "Workspace Name Card[name=conflict_adjust_user]"
		And I click the "Workspace Name Card[name=conflict_adjust_user;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebaroverview]"
		And I click the "Enable Edition Button"
		And I can see text "is currently editing this workspace, please come back later." in element "Warning Description Modal"
		And insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I intercept "**@4casthub.com.br" route as "deleteWorkspace" with "DELETE" http verbs
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Menu Workspace Button[name=conflict_adjust_user;position=first]"
		And I click the "Delete My Project Menu[name=conflict_adjust_user;position=first]"
		And I write "conflict_adjust_user" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"
		And I wait "@deleteWorkspace" routes

	@TS-982
	Scenario: Not enabled adjust edition mode
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "anual_golden" text in element "Search Project"
		And I click the "My Project Card Template[name=anual_golden;position=first]"
		And I click the "Confirm Workspace Button"
		And I write "not_enabled_edition_mode" text in element "Workspace Name Input"
		And I write "not_enabled_edition_mode" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		And I click the "Publish Button"
		And I can see only one of following text "We are creating a preview of your workspace. This process may take a few minutes, please come back later." in element "Publish/Preview Description Modal"
		And I can see element "Access Workspace Button"
		And I can't see element "Error Modal"
		And I click the "OK Button"
		And I click the "Access Workspace Button"
		And I click the "Menu Model Explorer[index=workspacesidebaroverview]"
		Then I can't see element "Enable Edition Button"
		And I click the "Models Header Button"
		And I intercept "**@4casthub.com.br" route as "deleteWorkspace" with "DELETE" http verbs
		And I click the "Menu Workspace Button[name=not_enabled_edition_mode;position=first]"
		And I click the "Delete My Project Menu[name=not_enabled_edition_mode;position=first]"
		And I write "not_enabled_edition_mode" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"
		And I wait "@deleteWorkspace" routes

	@TS-937 @TS-939
	Scenario: Check series info for Result's Comparison
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebaroverview]"
		And I intercept "**&data_type=adjusted" route as "waitAdjusted" with "GET" http verbs
		And I click the "Open Filters Sidebar Button"
		And I select frequency "annual" in "Filter Sidebar"
		And I click the "Close Filters Sidebar Button"
		And I wait "@waitAdjusted" routes
		And I click the "Open Hierarchical Button"
		When I click the "Select One Checkbox[name=container-outras-regioes]"
		And I click the "Select One Checkbox[name=container-norte]"
		And I click the "Select One Checkbox[name=container-sul]"
		And I click the "Select One Checkbox[name=container-sudeste]"
		And I click the "Show Hierarchical Button[name=norte]"
		Then I can see element "Select Only 4 Series Tooltip"
		And I can see text "Outras Regioes" in element "Result's Comparison Legend Chart"
		And I can see text "Norte" in element "Result's Comparison Legend Chart"
		And I can see text "Sul" in element "Result's Comparison Legend Chart"
		And I can see text "Sudeste" in element "Result's Comparison Legend Chart"

	@CS-411
	Scenario: Verify inflation in Result chart
		And I intercept "**&data_type=adjusted" route as "waitAdjusted" with "GET" http verbs
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebaroverview]"
		And I wait "@waitAdjusted" routes
		And I wait for element "Enable Edition Button" be enabled
		And I get after info in "Historical Edit Grid Input[name=regiao-outras-regioes;position=first]"
		And I can see text "Nominal value" in element "Selected Inflation Text[position=first]"
		When I click the "Open Filters Sidebar Button"
		And I click the "Filter Radio[name=real]"
		And I click the "Close Filters Sidebar Button"
		And I wait "@waitAdjusted" routes
		And I wait for element "Enable Edition Button" be enabled
		And I get before info in "Historical Edit Grid Input[name=regiao-outras-regioes;position=first]"
		Then I can see text "Real value" in element "Selected Inflation Text"
		And I compare after info is not equal before info

	@CS-411
	Scenario: Verify inflation in Result Result's Comparison chart
		And I click the "Workspace Button"
		And I click the "Workspace Name Card[name=consumo_energia;position=first]"
		And I click the "Menu Model Explorer[index=workspacesidebaroverview]"
		And I wait for element "Enable Edition Button" be enabled
		And I click the "Open Hierarchical Button"
		When I click the "Show Hierarchical Button[name=outras-regioes]"
		And I click the "Show Hierarchical Button[name=outras-regioes-comercial]"
		And I click the "Select One Checkbox[name=container-com_mw]"
		And I get after info in "Result's Comparison Ys Chart"
		And I click the "Open Filters Sidebar Button"
		And I click the "Filter Radio[name=real]"
		And I click the "Close Filters Sidebar Button"
		And I wait for element "Enable Edition Button" be enabled
		Then I get before info in "Result's Comparison Ys Chart"
		And I compare after info is not equal before info