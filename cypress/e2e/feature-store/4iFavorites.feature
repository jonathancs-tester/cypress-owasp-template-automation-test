@4I_FAVORITES
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: CRUD of 4i favorites

    Background:
        Given insert "admin" credentials and login via "MFA"
        And delete "sanity-pre-defined-" garbage in "4i favorites"

    @SANITY 
    Scenario: Create favorites
        And access main page			
        And access "Feature Store" application
        And access '4i favorites' FS tab
        When click in create new favorites "on feature store tab"
        And insert description "test-description"
        And create a new favorites "sanity-pre-defined-"
        Then the favorites "sanity-pre-defined-" should be visible
        And delete "sanity-pre-defined-"

    @SANITY
    Scenario: Edit favorites
        And delete "edit-fav-test" garbage in "4i favorites"
        And delete "sanity-test-new-fav" garbage in "4i favorites"
        And create a new "sanity-test-new-fav" group in "4i favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access '4i favorites' FS tab
        When edit "sanity-test-new-fav" favorites to "edit-fav-test"
        And edit "new-test-description" description
        Then the favorites "edit-fav-test" should be visible
        And click "edit-fav-test" card
        And name "edit-fav-test" should be visible
        And description "new-test-description" should be visible
        And back to Series Groups
        And delete "edit-fav-test"

    Scenario Outline: Check favorites valid name range and description
        And access main page
        And access "Feature Store" application
        And access '4i favorites' FS tab
        When click in create new favorites "on feature store tab"
        And try to create a new favorites without name
        And should not be possible register without name
        And create a new favorites "<GroupName>"
        Then should not be possible to insert a name outside the character range "<GroupName>"
        And should not be possible to create a favorites without description
        And click in cancel 
        And the registre tab should be closed

        Examples:
            |           GroupName            |
            | xx                             |
            | xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|


    @SANITY
    Scenario: Check view 4i favorites with user view
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page
        And access "Feature Store" application
        And access '4i favorites' FS tab
        And the favorites "sanity-pre-defined-" should be visible
        And insert "view" credentials and login via "MFA"
        And access main page
        When access "Feature Store" application
        And access '4i favorites' FS tab
        Then the favorites "sanity-pre-defined-" should be visible
        And menu favorites button should not exist

    Scenario: Check delete error with incorrect favorites name
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page
        And access "Feature Store" application
        And access '4i favorites' FS tab
        And the favorites "sanity-pre-defined-" should be visible
        When try to delete "sanity-pre-defined-" favorites with incorrect name
        Then the delete button should not be enabled
        And an error message should be presented
    
    @SANITY
    Scenario: Check create favorites button with view user
        And insert "view" credentials and login via "MFA"
        And access main page
        And access "Feature Store" application
        When access '4i favorites' FS tab
        Then create 4i favorites button should be disabled
        And menu favorites button should not exist
    
    Scenario: Check the favorites by clicking on the card
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page
        And access "Feature Store" application
        And access '4i favorites' FS tab
        And the favorites "sanity-pre-defined-" should be visible
        When click "sanity-pre-defined-" card
        Then name "sanity-pre-defined-" should be visible
        And description "test-description" should be visible

    Scenario: Check download of series in group with indicator inactive
        And insert "view" credentials and login via "MFA"
        And access main page
        And access "Feature Store" application
        And access '4i favorites' FS tab
        And the favorites "teste-download-" should be visible
        When click "teste-download-" card
        And click export series of favorites
        And I clear download folder
        And select 'XLXS' format file
        And I unzip download file
        Then I check if download size is greather than 200 kb
        And I check if data is correctly with following data:
        | row    |data          |   value   |
        | 13     |1/1/2020 00:0 |   25727   |   
        And I clear download folder      

    @SANITY
    Scenario: Delete a favorites serie of 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page
        And access "Feature Store" application
        And access '4i favorites' FS tab 
        And the favorites "sanity-pre-defined-" should be visible
        And enter the Indicators List Tab
        And select the "ARG - CPI" card name with code "ARPRC0114000OOML"
        And click in send to a favorites
        And click in continue send series
        And send to "sanity-pre-defined-" favorites of "4i favorites"
        And click in delete button of "ARPRC0114000OOML" 
        And click in cancel button
        And the "ARPRC0114000OOML" serie should be visible
        When click in delete button of "ARPRC0114000OOML"
        And click in confirm button
        Then the "ARPRC0114000OOML" serie should not be visible

   Scenario: Search favorites of 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page
        And access "Feature Store" application
        And access '4i favorites' FS tab 
        And the favorites "sanity-pre-defined-" should be visible
        When search "sanity-pre-defined-"
        Then only "sanity-pre-defined-" favorites should be visible
        And search from the date
        And the favorites "sanity-pre-defined-" should be visible
    
    Scenario: Create a Group of 4i favorites from the send series tab
        And access main page
        And access "Feature Store" application
        And enter the Indicators List Tab
        And select the "ARG - CPI" card name with code "ARPRC0114000OOML"
        And click in send to a favorites
        And click in continue send series
        When click in create new favorites "on send series tab of 4i favorites"
        And insert description "sanity-pre-defined-"
        And create a new favorites "sanity-pre-defined-"
        Then the favorites "sanity-pre-defined-" should be visible

    Scenario: Send some series to 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access '4i favorites' FS tab 
        And the favorites "sanity-pre-defined-" should be visible
        And enter the Indicators List Tab
        And search the "CHL - Economic Activity Index" indicator
        And click in "CHL - Economic Activity Index" indicator
        And click in send to a favorites
        And select continue
        And send to "sanity-pre-defined-" favorites of "4i favorites"
        Then the "CLGDP0054000OOML" serie should be visible
        And there should be 1 series
    
    Scenario Outline: Check favorites availability in 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access '4i favorites' FS tab 
        And the favorites "sanity-pre-defined-" should be visible
        And enter the Indicators List Tab
        And search the "ARG - Interest rate - BADLAR" indicator
        And click in "ARG - Interest rate - BADLAR" indicator
        And select "Monthly" frequency
        And click in send to a favorites
        And select continue
        And send to "sanity-pre-defined-" favorites of "4i favorites"
        When access "Models" app menu
        And start a new project creation
        And select "time-series" projects
        And insert "Test project" at "ProjectName" field
        And upload a valid "/time-series/Mensal/dataset_mensal_fake_1.xlsx" dataset and go to step 2
        Then check availability of "sanity-pre-defined-" favorites with "<frequency>" frequency in "4i favorites"

        Examples:
            | frequency      |
            | Monthly        |
            | Monthly,Yearly |

    Scenario: Search series of 4i favorites
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access '4i favorites' FS tab
        And the favorites "sanity-pre-defined-" should be visible
        And enter the Indicators List Tab
        And search the "ARG - Interest rate - BADLAR" indicator
        And click in "ARG - Interest rate - BADLAR" indicator
        And click in send to a favorites
        And click in continue send series
        And send to "sanity-pre-defined-" favorites of "4i favorites"
        When search for the "BADLAR"
        Then the "ARINR0008000OODX" serie should be visible

    Scenario Outline: Check download permission in groups favorits with premium series
        And create a new "sanity-pre-defined-" group in "4i favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access '4i favorites' FS tab
        And the favorites "sanity-pre-defined-" should be visible
        And enter the Indicators List Tab
        And search the "BRA - GDP - 4intelligence" indicator
        And click in "BRA - GDP - 4intelligence" indicator
        And click in send to a favorites
        And click in continue send series
        And send to "sanity-pre-defined-" favorites of "4i favorites"
        And search for the "PIB"
        And the "BRGDP0081000ROML" serie should be visible
        When insert "view" credentials and login via "MFA"
        And access main page			
        And access "Feature Store" application
        And access '4i favorites' FS tab
        And click "sanity-pre-defined-" card
        And click export series of favorites
        And select '<format>' format file
        Then the warning download error should be visible

        Examples:
            | format      |
            | XLXS        |
            | CSV         |

    Scenario Outline: Check export series of my favorites
        And create a new "sanity-test-new-fav" group in "My favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And the favorites "sanity-test-new-fav" should be visible
        And enter the Indicators List Tab
        And search the "BRA - GDP - 4intelligence" indicator
        And click in "BRA - GDP - 4intelligence" indicator
        And click in send to a favorites
        And click in continue send series
        And send to "sanity-test-new-fav" favorites of "My favorites"
        When click export series of favorites
        Then check "<fileType>" download file is greather than 1 kB

        Examples:
            | fileType |
            | csv      |
            | excel    |