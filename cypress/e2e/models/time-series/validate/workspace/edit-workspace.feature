@EDIT_WORKSPACE
@4INTELLIGENCE @WORKSPACE @TIMESERIES @REGRESSION
Feature: Workspace - Edit

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"

	@TS-813
	Scenario: User blocked due to other user editing
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "mensal_all_with_pick4me" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_all_with_pick4me;position=first]"
		And I write "mensal_sanity_lags" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_sanity_lags;position=first]"
		And I click the "Confirm Workspace Button"
		And I write "editblocktest" text in element "Workspace Name Input"
		And I write "editblocktest" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		When I click the "Invite Users Button"
		And I write "read-project@4casthub.com" text in element "Add Share User Input"
		And I click the "Share Confirm Button"
		And I select "Can edit" options in element "Sharing User Role Select[name=read-project@4casthub.com]"
		And I click the "Edit Workspace Button"
		And I can see element "Workspace Name Input"
		Then insert "read_project" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I can see element "Workspace Name Card[name=editblocktest]"
		And I click the "Menu Workspace Button[name=editblocktest;position=first]"
		And I click the "Control Painel Menu Button[name=editblocktest;position=first]"
		And I click the "Edit Workspace Button"
		Then I can see text "is currently editing this workspace, please come back later." in element "Warning Description Modal"
		And insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I intercept "**@4casthub.com.br" route as "deleteWorkspace" with "DELETE" http verbs
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Menu Workspace Button[name=editblocktest;position=first]"
		And I click the "Delete My Project Menu[name=editblocktest;position=first]"
		And I write "editblocktest" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"
		And I wait "@deleteWorkspace" routes

	@TS-1066
	Scenario: Block creating a new release with different frequencies
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "mensal_sanity_lags" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_sanity_lags;position=first]"
		And I click the "Confirm Workspace Button"
		And I write "editnewrelease" text in element "Workspace Name Input"
		And I write "editnewrelease" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		And I click the "Edit Workspace Button"
		And I click the "Add New Project Button"
		And I click the "Search Project"
		And I write "mensal_sanity_lags" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_sanity_lags;position=first]"
		And I write "anual" text in element "Search Project"
		Then I can see element "Only Same Projects Frequency Tooltip"
		And I wait for element "Confirm Workspace Button" be disabled
		And I click the "Cancel Select Project Button"
		And I click the "Models Header Button"
		And I intercept "**@4casthub.com.br" route as "deleteWorkspace" with "DELETE" http verbs
		And I click the "Menu Workspace Button[name=editnewrelease;position=first]"
		And I click the "Delete My Project Menu[name=editnewrelease;position=first]"
		And I write "editnewrelease" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"
		And I wait "@deleteWorkspace" routes
