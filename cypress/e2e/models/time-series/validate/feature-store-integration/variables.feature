@FEATURE_STORE_VARIABLES
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @FEATURE_STORE_INTEGRATION
Feature: Feature Store Variables

	@SANITY
	Scenario: Check the feature store variables in model
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"
		And I use "fs_agriculture_ipa_m_br_6191" as "name" in template
		And I write "ui_fs_mensal_variables_1" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=ui_fs_mensal_variables_1;position=first]"
		And I can see element "Feature Store Variables Button"
		And I click the "Feature Store Variables Button"
		And I can see text "y_test_fin" in element "Feature Store Variables SideBar"
		And I can see text "fs_agriculture_ipa_m_br_6191" in element "Feature Store Variables SideBar"
		And I can see text "Agriculture - IPA-M" in element "Feature Store Variables SideBar"
		Then I open the "Feature Store Variable New Tab Button"
		And I can see text "Brazil" in element "Region Serie Select"
		And I can see text "Monthly" in element "Frequency Serie Select"
		And I can see text "Original" in element "Primary Transformation Serie Select"
		And I can see text "Level" in element "Secondary Transformation Serie Select"

	Scenario: Check the feature store variables in clone pŕoject
		Given insert "read_project" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"
		And I use "fs_agriculture_ipa_m_br_6191" as "name" in template
		And I write "ui_fs_mensal_variables_1" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=ui_fs_mensal_variables_1;position=first]"
		And I can see element "Feature Store Variables Button"
		And I click the "Feature Store Variables Button"
		And I can see text "y_test_fin" in element "Feature Store Variables SideBar"
		And I can see text "fs_agriculture_ipa_m_br_6191" in element "Feature Store Variables SideBar"
		And I can see text "Agriculture - IPA-M" in element "Feature Store Variables SideBar"
		Then I open the "Feature Store Variable New Tab Button"
		And I can see text "Brazil" in element "Region Serie Select"
		And I can see text "Monthly" in element "Frequency Serie Select"
		And I can see text "Original" in element "Primary Transformation Serie Select"
		And I can see text "Level" in element "Secondary Transformation Serie Select"
	
	Scenario: Check not contain the feature store variables in model
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"
		And I write "semanal_sanity" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=semanal_sanity;position=first]"
		And I wait for element "Feature Store Variables Button" be disabled

	Scenario: Check not contain the feature store variables for user without permission
		And insert "read_project" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"
		And I write "ui_fs_mensal_variables_1" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		When I click the "My Project Card Template[name=ui_fs_mensal_variables_1;position=first]"
		And I wait for element "Feature Store Variables Button" be disabled