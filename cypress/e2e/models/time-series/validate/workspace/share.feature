@SHARE_WORKSPACE
@4INTELLIGENCE @WORKSPACE @TIMESERIES @REGRESSION
Feature: Workspace - Share
# time_series user não tem role de workpace
# view user tem a role de workspace mas não deve ter workspace
# read_project user (customer assisted user) tem a role de workspace e terá os projetos compartilhados
# Funciona para projetos bergman acima de v0.5.2

    @SANITY @TS-673
	Scenario Outline: Share Workspace for edit and view user with success
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I intercept "**/users/admin-firefox@4casthub.com.br" route as "deleteWorkspace" with "DELETE" http verbs
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "mensal_all_with_pick4me" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_all_with_pick4me;position=first]"
		And I write "mensal_sanity_lags" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_sanity_lags;position=first]"
		And I click the "Confirm Workspace Button"
		And I write "sharetest" text in element "Workspace Name Input"
		And I write "sharetest" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		When I click the "Invite Users Button"
		And I write "read-project@4casthub.com" text in element "Add Share User Input"
		And I click the "Share Confirm Button"
		And I select "<role>" options in element "Sharing User Role Select[name=read-project@4casthub.com]"
		Then insert "read_project" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I intercept "**/users/read-project@4casthub.com" route as "deleteWorkspaceReadUser" with "DELETE" http verbs
		And I can see element "<icon>"
		And I can see element "Workspace Name Card[name=sharetest]"
		And I click the "Menu Workspace Button[name=sharetest;position=first]"
		And I click the "Delete My Project Menu[name=sharetest;position=first]"
		And I write "sharetest" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"
		And I wait "@deleteWorkspaceReadUser" routes
		And I can't see element "Workspace Name Card[name=sharetest]"
		And insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Menu Workspace Button[name=sharetest;position=first]"
		And I click the "Delete My Project Menu[name=sharetest;position=first]"
		And I write "sharetest" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"
		And I wait "@deleteWorkspace" routes

		Examples:
			| role     | icon              |
			| Can view | You Can View Icon |
			| Can edit | You Can Edit Icon |

	@TS-673
	Scenario: Share Workspace for remove user with sucess
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
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
		And I write "remove-user-sharetest" text in element "Workspace Name Input"
		And I write "remove-user-sharetest" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		When I click the "Invite Users Button"
		And I write "read-project@4casthub.com" text in element "Add Share User Input"
		And I click the "Share Confirm Button"
		And I select "Can view" options in element "Sharing User Role Select[name=read-project@4casthub.com]"
		And I select "Remove" options in element "Sharing User Role Select[name=read-project@4casthub.com]"
		And I click the "Confirm Remove User Button"
		Then insert "read_project" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I can't see element "Workspace Name Card[name=remove-user-sharetest]"