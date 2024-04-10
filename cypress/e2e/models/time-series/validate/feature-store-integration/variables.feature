@FEATURE_STORE_VARIABLES
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION
Feature: Feature Store Variables

	@SANITY
	Scenario: Check the feature store variables in model
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		And I use "fs_nikkei225_jp_1" as "name" in template
		When find "UI_FS_Mensal_Variables_1" project
		And click to "UI_FS_Mensal_Variables_1" Model Explorer
		And I can see element "Feature Store Variables Button"
		And I click the "Feature Store Variables Button"
		And I can see text "y_test_fin" in element "Feature Store Variables SideBar"
		And I can see text "fs_nikkei225_jp_1" in element "Feature Store Variables SideBar"
		And I can see text "NIKKEI225" in element "Feature Store Variables SideBar"
		Then I open the "Feature Store Variable New Tab Button"
		And I can see text "Japan" in element "Region Serie Select"
		And I can see text "Monthly - End of period" in element "Frequency Serie Select"
		And I can see text "Original" in element "Primary Transformation Serie Select"
		And I can see text "Level" in element "Secondary Transformation Serie Select"

	Scenario: Check the feature store variables in clone pŕoject
		Given insert "view" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		And I use "fs_nikkei225_jp_1" as "name" in template
		When find "UI_FS_Mensal_Variables_1" project
		And click to "UI_FS_Mensal_Variables_1" Model Explorer
		And I can see element "Feature Store Variables Button"
		And I click the "Feature Store Variables Button"
		And I can see text "y_test_fin" in element "Feature Store Variables SideBar"
		And I can see text "fs_nikkei225_jp_1" in element "Feature Store Variables SideBar"
		And I can see text "NIKKEI225" in element "Feature Store Variables SideBar"
		Then I open the "Feature Store Variable New Tab Button"
		And I can see text "Japan" in element "Region Serie Select"
		And I can see text "Monthly - End of period" in element "Frequency Serie Select"
		And I can see text "Original" in element "Primary Transformation Serie Select"
		And I can see text "Level" in element "Secondary Transformation Serie Select"
	
	Scenario: Check not contain the feature store variables in model
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		When find "Semanal_Sanity" project
		And click to "Semanal_Sanity" Model Explorer
		And I wait for element "Feature Store Variables Button" be disabled

	Scenario: Check not contain the feature store variables for user without permission
		And insert "read_project" credentials and login via "MFA"
		And access main page			
		And access "Models" application
		When find "UI_FS_Mensal_Variables_1" project
		And click to "UI_FS_Mensal_Variables_1" Model Explorer
		And I wait for element "Feature Store Variables Button" be disabled