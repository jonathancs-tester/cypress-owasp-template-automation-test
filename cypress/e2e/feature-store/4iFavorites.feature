@4I_FAVORITES
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: CRUD of 4i favorites

    Background:
        Given insert "admin" credentials and login via "MFA"
        And delete "sanity-pre-defined-" garbage in "4i favorites"

    @SANITY
    Scenario: Create favorites
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "4I Favorites Button"
        When I click the "Create New Group Button"
        And I write "test-description" text in element "Group Description Input"
        And I write "sanity-pre-defined-${browser}" text in element "Group Name Input"
        And I click the "Create New Group Confirm Button"
        Then I can see element "Group Name Card[name=sanity-pre-defined]"
        And I click the "Group Card Menu[name=sanity-pre-defined]"
        And I click the "Group Card Delete Menu[name=sanity-pre-defined]"
        And I write "sanity-pre-defined-${browser}" text in element "Delete Group Input"
        And I click the "Delete Confirm Button"

    @SANITY
    Scenario: Edit favorites
        And delete "edit-fav-test" garbage in "4i favorites"
        And delete "sanity-test-new-fav" garbage in "4i favorites"
        And create a new "sanity-test-new-fav-" group in "4i favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "4I Favorites Button"
        And I click the "Group Card Menu[name=sanity-test-new-fav]"
        When I click the "Group Card Edit Menu[name=sanity-test-new-fav]"
        And I write "edit-fav-test-${browser}" text in element "Group Name Input"
        And I write "new-test-description" text in element "Group Description Input"
        And I click the "Edit Confirm Button"
        Then I can see element "Group Name Card[name=edit-fav-test]"
        # And I click the "Group Card Menu[name=edit-fav-test]"
        And I click the "Group Card Delete Menu[name=edit-fav-test]"
        And I write "edit-fav-test-${browser}" text in element "Delete Group Input"
        And I click the "Delete Confirm Button"

    Scenario Outline: Check favorites valid name range and description
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "4I Favorites Button"
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
    Scenario: Check view 4i favorites with user view
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        When I click the "Favorites Button"
        And I click the "4I Favorites Button"
        Then I can see element "Group Name Card[name=sanity-pre-defined]"
        And I can't see element "Group Card Menu[name=sanity-pre-defined]"
    
    Scenario: Check delete error with incorrect favorites name
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        When I click the "Favorites Button"
        And I click the "4I Favorites Button"
        And I click the "Group Card Menu[name=sanity-pre-defined]"
        And I click the "Group Card Delete Menu[name=sanity-pre-defined]"
        And I write "teste" text in element "Delete Group Input"
        Then I can see text "Must write the correct group name" in element "p"
    
    @SANITY
    Scenario: Check create favorites button with view user
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        When I click the "4I Favorites Button"
        Then I can't see element "Create New Group Button"
    
    Scenario: Check the favorites by clicking on the card
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "4I Favorites Button"
        When I click the "Favorites Card[name=sanity-pre-defined]"
        Then I can see text "sanity-pre-defined-${browser}" in element "h5"

    Scenario: Check download of series in group with indicator inactive
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I write "teste-download" text in element "Group Search Input"
        And I click the "4I Favorites Button"
        When I click the "Favorites Card[name=teste-download]"
        And I click the "Export Series Button"
        And I clear download folder
        And I intercept "**/download/**" route as "downloadSerie" with "GET" http verbs
        And I click the "Export XLXS format"
        And I wait "@downloadSerie" routes
        And I unzip download file
        Then I check if download size is greather than 23 kb
        And I check if data is correctly with following "cypress/fixtures/feature-store/Monthly.xlsx" file on sheet 1
        And I clear download folder

    Scenario: Check export of Data Table 
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "4I Favorites Button"
        When I click the "Ecomonic Group Card[name=pmc---pesquisa-mensal-do-comércio]"
        And I click the "Data Table Button"
        And I click the "Export Series Button"
        And I clear download folder
        And I intercept "**/download/**" route as "downloadDataTable" with "GET" http verbs
        And I click the "Export XLXS format"
        And I wait "@downloadDataTable" routes
        Then I check if download size is greather than 225 kb
        And I check if "BRA - Expanded Retail Sales Volume - PMC" data is finding in download file
        And I clear download folder    

    Scenario: Check download of series with freemium user
        And insert "freemium" credentials and login via "DEV"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I write "teste-download" text in element "Group Search Input"
        And I click the "4I Favorites Button"
        When I click the "Favorites Card[name=teste-download]"
        And I can't see element "Subscribe Alert Button"
        And I can't see element "Data Table Button"
        And I click the "Export Series Button"
        And I clear download folder
        And I intercept "**/download/xlsx**" route as "downloadFile" with "GET" http verbs
        And I click the "Export XLXS format"
        And I wait "@downloadFile" routes
        And I unzip download file
        Then I check if download size is greather than 21 kb
        And I check if data is correctly with following "cypress/fixtures/feature-store/Monthly_freemium.xlsx" file on sheet 1
        And I clear download folder       

    @SANITY
    Scenario: Delete a favorites serie of 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "4I Favorites Button" 
        And I click the "Search FS Button"
        And I write "BRA - Economic Activity Index" text in element "Search Indicators Input"
        And I click "BRA - Economic Activity Index - IBC-BR" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "4I Favorites Tab"
        And I click the "Select Favorites Card[name=sanity-pre-defined]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        When I click the "Delete Serie Button[name=BRGDP0001000OOML]"
        And I click the "Confirm delete series button[position=last]"
        Then I can't see element "Delete Serie Button[name=BRGDP0001000OOML]"
    
    
    # Scenario: Search favorites of 4i favorites
    #     And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And I click the "Favorites Button"
    #     # And I intercept "**api/v1/indicators**" route as "predefinedGroups" with "GET" http verbs
    #     And I click the "4I Favorites Button"
    #     # And I wait "@predefinedGroups" routes
    #     When I write "sanity-pre-defined-${browser}" text in element "Group Search Input"
    #     Then I can see element "Group Name Card[name=sanity-pre-defined]"
    #     And search from the date
        # And I can see element "Group Name Card[name=sanity-pre-defined]"

    Scenario: Create a Group of 4i favorites from the send series tab
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - GDP - IBGE" text in element "Search Indicators Input"
        And I click "BRA - GDP - IBGE" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "4I Favorites Tab"
        When I click the "Create new 4i group button"
        And I write "test-description" text in element "Group Description Input"
        And I write "sanity-pre-defined-${browser}" text in element "Group Name Input"
        And I click the "Create New Group Confirm Button"
        Then I can see element "Group Name Card[name=sanity-pre-defined]"

    Scenario: Send some series to 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "Chile" options in element "Select Country"
        And I write "CHL - Economic Activity Index" text in element "Search Indicators Input"
        And I click "CHL - Economic Activity Index" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "4I Favorites Tab"
        And I click the "Select Favorites Card[name=sanity-pre-defined]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        Then I can see element "Delete Serie Button[name=CLGDP0054000OOML]"
    
    Scenario Outline: Check favorites availability in 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "Argentina" options in element "Select Country"
        And I write "ARG - Interest rate - BADLAR" text in element "Search Indicators Input"
        And I click "ARG - Interest rate - BADLAR" name in "Indicator Card"
        And I select "Monthly - Geometric mean" options in element "Frequency Serie Select"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "4I Favorites Tab"
        And I click the "Select Favorites Card[name=sanity-pre-defined]"
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
		And I click the "4I Favorites Tab"
		Then I click the "Favorites Group Card[name=sanity-pre-defined]"

        Examples:
            | frequency      |
            | Monthly        |
            | Monthly,Yearly |

    Scenario: Search series of 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "Argentina" options in element "Select Country"
        And I write "ARG - Interest rate - BADLAR" text in element "Search Indicators Input"
        And I click "ARG - Interest rate - BADLAR" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "4I Favorites Tab"
        And I click the "Select Favorites Card[name=sanity-pre-defined]"
        And I click the "Add Button"
        And I click the "Go to Group Button"
        When I write "BADLAR" text in element "Search Series Input"
        Then I can see element "Delete Serie Button[name=ARINR0008000OGMG]"

    # @FS-1868
    # Scenario Outline: Check download permission in groups favorits with premium series
    #     And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And I write "BRA - Corn Harvested Area - Total" text in element "Search Indicators Input"
    #     And I click "BRA - Corn Harvested Area - Total" name in "Indicator Card"
    #     And I click the "Send to Group Button"
    #     And I click the "Continue Button"
    #     And I click the "4I Favorites Tab"
    #     And I click the "Select Favorites Card[name=sanity-pre-defined]"
    #     And I click the "Add Button"
    #     And I click the "Go to Group Button"
    #     And I can see element "Delete Serie Button[name=BRAGR0070000OOYL]"
    #     When insert "view" credentials and login via "MFA"
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And I click the "Favorites Button"
    #     And I click the "4I Favorites Button"
    #     And I click the "Favorites Card[name=sanity-pre-defined]"
    #     And I click the "Export Series Button"
    #     And I click the "Export XLXS format"
    #     Then the warning download error should be visible

    #     Examples:
    #         | format      |
    #         | XLXS        |
    #         | CSV         |

    Scenario Outline: Check export series of my favorites
        And delete "sanity-pre-defined-" garbage in "4i favorites"
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - GDP 4i" text in element "Search Indicators Input"
        And I click "BRA - GDP 4i" name in "Indicator Card"
        And I click the "Send to Group Button"
        And I click the "Continue Button"
        And I click the "4I Favorites Tab"
        And I click the "Select Favorites Card[name=sanity-pre-defined]"
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

    Scenario: Check 4i favorites table 
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "4I Favorites Button"
        When I click the "Ecomonic Group Card[name=igp-m---índice-geral-de-preços]"
        And I click the "Data Button 4i Card"
        And I can see text "-0.09" in element "td"
        Then I can see text "Jan/24" in element "th"
        And I click the "Data Tab Button[name=igp-m---índice-(ago/94-=-100)-0]"
        And I can see text "1,389.86" in element "td"
        And I can see text "BRA - IPA-M" in element "th"

    Scenario: Check notification alert
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click the "Favorites Button"
        And I click the "4I Favorites Button"
        And I click the "Subscribe Alert Button"
        When I click the "Ecomonic Group Card[name=pim---pesquisa-industrial-mensal]"
        And I click the "Data Table Button"
        And I click the "Subscribe Alert Button"
