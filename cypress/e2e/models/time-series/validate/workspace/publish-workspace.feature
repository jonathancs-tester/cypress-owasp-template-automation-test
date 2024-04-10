@PREVIEW_WORKSPACE
@4INTELLIGENCE @WORKSPACE @TIMESERIES @REGRESSION
Feature: Workspace - Preview/Publish
	# time_series user não tem role de workpace
	# view user tem a role de workspace mas não deve ter workspace
	# read_project user (customer assisted user) tem a role de workspace e terá os projetos compartilhados
	# Funciona para projetos bergman acima de v0.5.2

	@SANITY @TS-696 @TS-853 @TS-878 @TS-1074
	Scenario: Preview workspace 
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		When I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "anual_sanity" text in element "Search Project"
		And I click the "My Project Card Template[name=anual_sanity;position=first]"
		And I write "contribuicao_anual_pib_agro" text in element "Search Project"
		And I click the "My Project Card Template[name=contribuicao_anual_pib_agro;position=first]"
		And I click the "Confirm Workspace Button"
		Then I write "workspacepreview" text in element "Workspace Name Input"
		And I write "workspacepreview" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		And I click the "Create Preview Button"
		And I can see only one of following text "We are creating a preview of your workspace. This process may take a few minutes, please come back later." in element "Publish/Preview Description Modal"
		And I can't see element "Error Modal"
		And I click the "OK Button"
		And I wait for element "Visualize Preview Button" be enabled
		And I can see text "Preview" in element "Visualize Preview Button"
		And I click the "Visualize Preview Button"
		And I wait for element "Menu Model Explorer[index=workspacesidebaroverview]" be enabled
		And I wait for element "Menu Model Explorer[index=workspacesidebarprojections]" be enabled
		Then I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I can see only one of following text "workspacepreview" in element "Workspace Name Card[name=workspacepreview;position=first]"
		And I can see only one of following text "workspacepreview" in element "Workspace Description Card[name=workspacepreview;position=first]"
		And I intercept "**@4casthub.com.br" route as "deleteWorkspace" with "DELETE" http verbs
		And I click the "Menu Workspace Button[name=workspacepreview;position=first]"
		And I click the "Delete My Project Menu[name=workspacepreview;position=first]"
		And I write "workspacepreview" text in element "Input Confirm Delete"
		And I click the "Delete Confirm Button"
		And I wait "@deleteWorkspace" routes
	
	@SANITY @TS-696 @TS-853 @TS-878 @TS-1074 @CS-451
	Scenario: Publish workspace without agreggation
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		When I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "mensal_pequeno_sazonal" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_pequeno_sazonal;position=first]"
		And I write "mensal_pequeno_wmape_median" text in element "Search Project"
		And I click the "My Project Card Template[name=mensal_pequeno_wmape_median;position=first]"
		And I click the "Confirm Workspace Button"
		And I set "Select One Checkbox[name=inflate-series?]" to checked
		And I write "mensal_sem_agregacao" text in element "Workspace Name Input"
		And I write "mensal_sem_agregacao" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		And I click the "Publish Button"
		And I can see only one of following text "We are creating a preview of your workspace. This process may take a few minutes, please come back later." in element "Publish/Preview Description Modal"
		And I can see element "Access Workspace Button"
		And I can't see element "Error Modal"
		And I click the "OK Button"
		And I click the "Access Workspace Button"
		And I wait for element "Menu Model Explorer[index=workspacesidebaroverview]" be enabled
		And I wait for element "Menu Model Explorer[index=workspacesidebarprojections]" be enabled
		Then I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I can see only one of following text "mensal_sem_agregacao" in element "Workspace Name Card[name=mensal_sem_agregacao;position=first]"
		And I can see only one of following text "mensal_sem_agregacao" in element "Workspace Description Card[name=mensal_sem_agregacao;position=first]"

	@TS-814
	Scenario: Ensure a single data frequency is selected
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		When I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "semanal_sanity" text in element "Search Project"
		And I click the "My Project Card Template[name=semanal_sanity;position=first]"
		And I write "quinzenal_sanity" text in element "Search Project"
		Then I wait for element "My Project Card Template[name=quinzenal_sanity;position=first]" be disabled
		And I can see element "Different Project Warning Icon"

	@TS-670
	Scenario: Check user without permission for workspace
		Given insert "time_series" credentials and login via "MFA"
		And I visit "/"
		When I click the "Models"
		Then I can't see element "Workspace Button"

	@TS-670
	Scenario: Check user without workspace
		Given insert "view" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		When I click the "Workspace Button"
		Then I can see text "No workspaces found, start by creating one." in element "No Workspace Message Card"
