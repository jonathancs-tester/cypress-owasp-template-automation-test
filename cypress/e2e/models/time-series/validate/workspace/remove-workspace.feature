@REMOVE_WORKSPACE
@4INTELLIGENCE @WORKSPACE @TIMESERIES @REGRESSION
Feature: Workspace - Remove
	# time_series user não tem role de workpace
	# view user tem a role de workspace mas não deve ter workspace
	# read_project user (customer assisted user) tem a role de workspace e terá os projetos compartilhados
	# Funciona para projetos bergman acima de v0.5.2

	@TS-673 @TS-833
	Scenario: Workspace requires at least one editor to manage changes.
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I intercept "**/users/admin-firefox@4casthub.com.br" route as "deleteWorkspace" with "DELETE" http verbs
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "mensal_all_with_pick4me" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_all_with_pick4me;position=first]"
		And I write "mensal_sanity_lags" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_sanity_lags;position=first]"
		And I click the "Confirm Workspace Button"
		And I write "unable-owner-sharetest" text in element "Workspace Name Input"
		And I write "unable-owner-sharetest" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		And I click the "Invite Users Button"
		And I write "read-project@4casthub.com" text in element "Add Share User Input"
		And I click the "Share Confirm Button"
		And I select "Can edit" options in element "Sharing User Role Select[name=read-project@4casthub.com]"
		And I click the "Invite Users Button"
		And I write "automation-test@4casthub.com" text in element "Add Share User Input"
		And I click the "Share Confirm Button"
		And I select "Can view" options in element "Sharing User Role Select[name=automation-test@4casthub.com]"
		When I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Menu Workspace Button[name=unable-owner-sharetest;position=first]"
		And I click the "Delete My Project Menu[name=unable-owner-sharetest;position=first]"
		And I write "unable-owner-sharetest" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"
		And I wait "@deleteWorkspace" routes
		Then insert "read_project" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Menu Workspace Button[name=unable-owner-sharetest;position=first]"
		And I click the "Delete My Project Menu[name=unable-owner-sharetest;position=first]"
		And I can see only one of following text "Last editor" in element "Warning Title Modal"
		And I can see only one of following text "You are the last editor, remove all viewers before deleting the workspace from your account." in element "Warning Description Modal"
		And I click the "Control Painel Warning Button"
		And I can see element "No Access Owner User Text"
		And I click the "Sharing User Role Select[name=read-project@4casthub.com]"
		And I can see element "Unable Switch Viewer Icon"

