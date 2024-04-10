@MY_FAVORITES
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: CRUD of my favorites

    Background:
        Given insert "admin" credentials and login via "MFA"
        And delete "sanity-test-new-fav-" garbage in "My favorites"

    @SANITY
    Scenario: Create my favorites
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        When I click the "Create New Group Button"
        And I write "test-description" text in element "Group Description Input"
        And I write "sanity-test-new-fav-${browser}" text in element "Group Name Input"
        And I click the "Create New Group Confirm Button"
        Then I can see element "Group Name Card[name=sanity-test-new-fav]"
        And I click the "Group Card Menu[name=sanity-test-new-fav]"
        And I click the "Group Card Delete Menu[name=sanity-test-new-fav]"
        And I write "sanity-test-new-fav-${browser}" text in element "Delete Group Input"
        And I click the "Delete Confirm Button"

    @SANITY
    Scenario: Edit my favorites
        And delete "edit-favorites-test-" garbage in "My favorites"
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "Group Card Menu[name=sanity-test-new-fav]"
        When I click the "Group Card Edit Menu[name=sanity-test-new-fav]"
        And I write "edit-favorites-test-${browser}" text in element "Group Name Input"
        And I write "new-test-description" text in element "Group Description Input"
        And I click the "Edit Confirm Button"
        Then I can see element "Group Name Card[name=edit-favorites-test]"
        And I click the "Group Card Delete Menu[name=edit-favorites-test]"
        And I write "edit-favorites-test-${browser}" text in element "Delete Group Input"
        And I click the "Delete Confirm Button"

    Scenario Outline: Check favorites valid name range
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        When I click the "Create New Group Button"
        And I click the "Create New Group Confirm Button"
        And I can see text "Required field" in element "p"
        And I write "<GroupName>" text in element "Group Name Input"
        Then I can see text "<warning>" in element "p"

        Examples:
        |           GroupName            | warning                                     |   
        | xx                             | Name must be at least 3 characters          |
        | xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx| Name must be at most 30 characters          |

    @SANITY
    Scenario: Check view my favorites with user view
        And create a new "sanity-test-new-fav" group in "My favorites" through the API
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        When I click the "Favorites Button"
        Then I can't see element "Group Name Card[name=sanity-test-new-fav]"

    Scenario: Check delete error with incorrect favorites name
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "Group Card Menu[name=sanity-test-new-fav]"
        And I click the "Group Card Delete Menu[name=sanity-test-new-fav]"
        And I write "teste" text in element "Delete Group Input"
        Then I can see text "Must write the correct group name" in element "p"
    
    Scenario: Check the favorites of myGroups by clicking on the card
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        When I click the "Favorites Card[name=sanity-test-new-fav]"
        Then I can see text "sanity-test-new-fav-${browser}" in element "h5"

    @SANITY
    Scenario: Delete a favorites serie of My favorites
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API        
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - GDP - IBGE" text in element "Search Indicators Input"
        And I click "BRA - GDP - IBGE" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "Select Favorites Card[name=sanity-test-new-fav]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        When I click the "Delete Serie Button[name=BRGDP0002000ROQL]"
        And I click the "Confirm delete series button[position=last]"
        Then I can't see element "Delete Serie Button[name=BRGDP0002000ROQL]"

    # Scenario: Search favorites of My favorites
    #     And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And I click the "Favorites Button"
    #     When I write "sanity-test-new-fav-${browser}" text in element "Group Search Input"
    #     Then I can see element "Group Name Card[name=sanity-test-new-fav]"
    #     And search from the date
    #     And I can see element "Group Name Card[name=sanity-test-new-fav]"

    Scenario: Create a Group of My favorites from the send series tab
        And I visit "/"		
		And I click the "Feature Store Button"
        And enter the Indicators List Tab
        And I write "BRA - GDP - IBGE" text in element "Search Indicators Input"
        And I click "BRA - GDP - IBGE" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        When I click the "Create new my group button"
        And I write "test-description" text in element "Group Description Input"
        And I write "sanity-test-new-fav-${browser}" text in element "Group Name Input"
        And I click the "Create New Group Confirm Button"
        Then I can see element "Group Name Card[name=sanity-test-new-fav]"

    Scenario: Send some series to my favorites
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "Chile" options in element "Select Country"
        And I write "CHL - Economic Activity Index" text in element "Search Indicators Input"
        And I click "CHL - Economic Activity Index" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "Select Favorites Card[name=sanity-test-new-fav]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        Then I can see element "Delete Serie Button[name=CLGDP0054000OOML]"

    Scenario Outline: Check favorites availability in My favorites
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "Argentina" options in element "Select Country"
        And I write "ARG - Interest rate - BADLAR" text in element "Search Indicators Input"
        And I click "ARG - Interest rate - BADLAR" name in "Indicator Card"
        And I select "Monthly - Geometric mean" options in element "Frequency Serie Select"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "Select Favorites Card[name=sanity-test-new-fav]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        When And I click the "Models Header Button"
        And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Test project" text in element "Project Name Input"
		And I attach fixture "/time-series/Mensal/dataset_mensal_fake_1.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I select "do not set" options in element "Format Date Select"
        And I click the "Add Feature Store Button"
        And I click the "My Favorites Tab"
		Then I click the "Favorites Group Card[name=sanity-test-new-fav]"

        Examples:
            | frequency      |
            | Monthly        |
            | Monthly,Yearly |
    
    Scenario: Check the sequence of the series in favorites
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - GDP 4i" text in element "Search Indicators Input"
        And I click "BRA - GDP 4i" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "Select Favorites Card[name=sanity-test-new-fav]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        Then the sequence of "sanity-test-new-fav-" test favorites should be ok

    Scenario: Search series of My favorites
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "Argentina" options in element "Select Country"
        And I write "ARG - Interest rate - BADLAR" text in element "Search Indicators Input"
        And I click "ARG - Interest rate - BADLAR" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "Select Favorites Card[name=sanity-test-new-fav]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        When I write "BADLAR" text in element "Search Series Input"
        Then I can see element "Delete Serie Button[name=ARINR0008000OGMG]"
    
    Scenario Outline: Check export series of my favorites
        And create a new "sanity-test-new-fav-" group in "My favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - GDP 4i" text in element "Search Indicators Input"
        And I click "BRA - GDP 4i" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "Select Favorites Card[name=sanity-test-new-fav]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        When I click the "Export Series Button"
        And I click the "Export XLXS format"
        Then I check if download size is greather than 20 kb
        And I clear download folder

        Examples:
            | fileType |
            | csv      |
            | excel    |