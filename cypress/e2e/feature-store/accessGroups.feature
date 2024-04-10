@ACCESS_GROUPS
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Check Indicators Groups menu 

    @SANITY
    Scenario Outline: Create access group
        Given insert "admin" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Access Group Button"
        When I click the "Create new access group button"
        And I write "teste_sanity" text in element "Access group name pt input"
        And I write "teste_sanity" text in element "Access group name en input"
        And I write "description test delete" text in element "Access group description pt input"
        And I write "description test delete" text in element "Access group description en input"
        And I select "<groupType>" options in element "Group access type input"
        And I click the "Continue Button"
        And I set "Select One Checkbox[name=<indicator>]" to checked
        And I click the "Add Indicator In Group Button"
        And I click the "Add Button[position=last]"
        And I write "<email>" text in element "Insert Clients"
        And I press "enter" sequence in element "Insert Clients"
        Then I click the "Add Button[position=last]"
        # And delete group of indicator
        
        Examples:
            | indicator                                  | email                     | groupType    |
            | arg---unemployment-rate---urban---test     | admin@4casthub.com.br     | Premium      |
            | bra---gdp---ibge                           | admin@4casthub.com.br     | Private      |

    @SANITY
    Scenario: Check the Pick4ME variables with user without permission premium
        Given insert "manager" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Models"
        And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Test project" text in element "Project Name Input"
		And I attach fixture "/time-series/Mensal/dataset_mensal_fake_1.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
        And I click the "Add Feature Store Button"
        When I click the "Pick4me Button"
        Then I can see element "Serie locked"

    Scenario: Check the FS variables with user without permission
        Given insert "manager" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Models"
        And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Test project" text in element "Project Name Input"
		And I attach fixture "/time-series/Mensal/dataset_mensal_fake_1.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
        And I click the "Add Feature Store Button"
        And I click the "4I Favorites Tab"
		And I write "teste-download" text in element "Group Search Input"
        When I click the "Favorites Group Card[name=teste-download]"
        Then I can see element "Serie locked"