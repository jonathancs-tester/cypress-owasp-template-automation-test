@SELECT_VARIABLE_WORKSPACE
@4INTELLIGENCE @WORKSPACE @TIMESERIES @REGRESSION
Feature: Workspace - Select Variable

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	@TS-672 @TS-758
	Scenario: Check warnings validation for duplicate variable name
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		When I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "semanal_sanity" text in element "Search Project"
		And I click the "My Project Card Template[name=semanal_sanity;position=1]"
		And I click the "My Project Card Template[name=semanal_sanity;position=2]"
		And I click the "Confirm Workspace Button"
		And I write "WorkspaceTest" text in element "Workspace Name Input"
		And I write "WorkspaceTest" text in element "Workspace Description Input"
		Then I can see element "Select variable Warning"
		And I can see element "Duplicate Name Y Warning Icon"
		And I wait for element "Save Workspace Button" be disabled
		And I write "Variavel_1" text in element "Workspace Variable Name Input[position=first]"
		And I can't see element "Select variable Warning"
		And I wait for element "Save Workspace Button" be enabled

	@TS-672 @TS-758
	Scenario: Check no warnings validation when remove the project
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		When I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "semanal_sanity" text in element "Search Project"
		And I click the "My Project Card Template[name=semanal_sanity;position=1]"
		And I click the "My Project Card Template[name=semanal_sanity;position=2]"
		And I click the "Confirm Workspace Button"
		And I write "WorkspaceTest" text in element "Workspace Name Input"
		And I write "WorkspaceTest" text in element "Workspace Description Input"
		Then I can see element "Select variable Warning"
		And I can see element "Duplicate Name Y Warning Icon"
		And I wait for element "Save Workspace Button" be disabled
		And I click the "Add New Project Button"
		And I click the "Search Project"
		And I write "semanal_sanity" text in element "Search Project"
		And I click the "My Project Card Template[name=semanal_sanity;position=2]"
		And I click the "Confirm Workspace Button"
		And I can't see element "Select variable Warning"
		And I wait for element "Save Workspace Button" be enabled

	@TS-672 @TS-758
	Scenario: Unchecked duplicate variable name
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		When I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "semanal_sanity" text in element "Search Project"
		And I click the "My Project Card Template[name=semanal_sanity;position=1]"
		And I click the "My Project Card Template[name=semanal_sanity;position=2]"
		And I click the "Confirm Workspace Button"
		Then I can see element "Select variable Warning"
		And I set "Select Variable Checkbox[position=first]" to unchecked
		And I can't see element "Select variable Warning"
		And I wait for element "Save Workspace Button" be disabled
		And I set "Select Variable Checkbox[position=1]" to unchecked
		And I wait for element "Save Workspace Button" be disabled

	@TS-758
	Scenario: Check warnings for model id invalid
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "semanal_sanity" text in element "Search Project"
		And I click the "My Project Card Template[name=semanal_sanity;position=1]"
		And I click the "My Project Card Template[name=semanal_sanity;position=2]"
		And I click the "Confirm Workspace Button"
		And I write "WorkspaceTest" text in element "Workspace Name Input"
		And I write "WorkspaceTest" text in element "Workspace Description Input"
		And I can see element "Select variable Warning"
		And I write "Variavel_1" text in element "Workspace Variable Name Input[position=first]"
		And I can't see element "Select variable Warning"
		When I write "invalid" text in element "Workspace Model Id Input[position=first]"
		Then I can see element "Select variable Warning"
		And I wait for element "Save Workspace Button" be disabled

	@TS-714
	Scenario: Check Model Update information available or not available
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		When I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "ui_diario_sanity" text in element "Search Project"
		And I click the "My Project Card Template[name=ui_diario_sanity;position=first]"
		And I click the "Confirm Workspace Button"
		Then I select "Update 1" options in element "Model Update Select[position=first]"