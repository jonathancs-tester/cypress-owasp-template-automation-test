@MY_FAVORITES
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: CRUD of my favorites

    Background:
        Given insert "admin" credentials and login via "MFA"
        And delete "sanity-test-new-fav" garbage in "My favorites"

    @SANITY
    Scenario: Create my favorites
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        When click in create new favorites "on feature store tab"
        And edit favorites icon
        And I write "test-description" text in element "Group Description Input"
        And create a new favorites "sanity-test-new-fav"
        Then the favorites "sanity-test-new-fav" should be visible
        And delete "sanity-test-new-fav"

    @SANITY
    Scenario: Edit my favorites
        And delete "edit-favorites-test" garbage in "My favorites"
        And create a new "sanity-test-new-fav" group in "My favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        When edit "sanity-test-new-fav" favorites to "edit-favorites-test"
        And edit "new-test-description" description
        Then the favorites "edit-favorites-test" should be visible
        And click "edit-favorites-test" card
        And name "edit-favorites-test" should be visible
        And description "new-test-description" should be visible
        And back to Series Groups
        And delete "edit-favorites-test"

    Scenario Outline: Check favorites valid name range
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        When click in create new favorites "on feature store tab"
        And try to create a new favorites without name
        And should not be possible register without name
        And create a new favorites "<GroupName>"
        And should not be possible to insert a name outside the character range "<GroupName>"
        And click in cancel 
        Then the registre tab should be closed

        Examples:
            |           GroupName            |
            | xx                             |
            | xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|

    @SANITY
    Scenario: Check view my favorites with user view
        And create a new "sanity-test-new-fav" group in "My favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And the favorites "sanity-test-new-fav" should be visible
        And insert "view" credentials and login via "MFA"
        And access main page
        And access "Feature Store" application
        Then should not be possible to visualize the "sanity-test-new-fav" favorites
        And insert "admin" credentials and login via "MFA"
        And access main page
        And access "Feature Store" application

    Scenario: Check delete error with incorrect favorites name
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And click in create new favorites "on feature store tab"
        And create a new favorites "sanity-test-new-fav" 
        And the favorites "sanity-test-new-fav" should be visible
        When try to delete "sanity-test-new-fav" favorites with incorrect name
        Then the delete button should not be enabled
        And an error message should be presented
    
    Scenario: Check the favorites of myGroups by clicking on the card
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And click in create new favorites "on feature store tab"
        And I insert "test-description" in element "Group Description Input"
        And create a new favorites "sanity-test-new-fav" 
        And the favorites "sanity-test-new-fav" should be visible
        When click "sanity-test-new-fav" card
        Then name "sanity-test-new-fav" should be visible
        And description "test-description" should be visible

    @SANITY
    Scenario: Delete a favorites serie of My favorites
        And create a new "sanity-test-new-fav" group in "My favorites" through the API        
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And the favorites "sanity-test-new-fav" should be visible
        And enter the Indicators List Tab
        And select the "ARG - CPI" card name with code "ARPRC0114000OOML"
        And click in send to a favorites
        And click in continue send series
        And send to "sanity-test-new-fav" favorites of "My favorites"
        When click in delete button of "ARPRC0114000OOML"
        And click in cancel button
        And the "ARPRC0114000OOML" serie should be visible
        And there should be 1 series
        And click in delete button of "ARPRC0114000OOML"
        And click in confirm button
        Then the "ARPRC0114000OOML" serie should not be visible
        And there should be 0 series

    Scenario: Search favorites of My favorites
        And create a new "sanity-test-new-fav" group in "My favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And the favorites "sanity-test-new-fav" should be visible
        When search "sanity-test-new-fav"
        Then only "sanity-test-new-fav" favorites should be visible
        And search from the date
        And the favorites "sanity-test-new-fav" should be visible

    Scenario: Create a Group of My favorites from the send series tab
        And access main page
        And access "Feature Store" application
        And enter the Indicators List Tab
        And select the "ARG - CPI" card name with code "ARPRC0114000OOML"
        And click in send to a favorites
        And click in continue send series
        And click in create new favorites "on send series tab of my favorites"
        When create a new favorites "sanity-test-new-fav" 
        Then the favorites "sanity-test-new-fav" should be visible

    Scenario: Send some series to my favorites
        And create a new "sanity-test-new-fav" group in "My favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And the favorites "sanity-test-new-fav" should be visible
        And enter the Indicators List Tab
        And search the "CHL - Economic Activity Index" indicator
        And click in "CHL - Economic Activity Index" indicator
        And click in send to a favorites
        And select continue
        And send to "sanity-test-new-fav" favorites of "My favorites"
        Then the "CLGDP0054000OOML" serie should be visible
        And there should be 1 series

    Scenario Outline: Check favorites availability in My favorites
        And create a new "sanity-test-new-fav" group in "My favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And the favorites "sanity-test-new-fav" should be visible
        And enter the Indicators List Tab
        And search the "ARG - Interest rate - BADLAR" indicator
        And click in "ARG - Interest rate - BADLAR" indicator
        And select "Monthly" frequency
        And click in send to a favorites
        And select continue
        And send to "sanity-test-new-fav" favorites of "My favorites"
        When access "Models" app menu
        And start a new project creation
		And select "time-series" projects
        And insert "Test project" at "ProjectName" field
        And upload a valid "/time-series/Mensal/dataset_mensal_fake_1.xlsx" dataset and go to step 2
        Then check availability of "sanity-test-new-fav" favorites with "<frequency>" frequency in "My favorites"

        Examples:
            | frequency      |
            | Monthly        |
            | Monthly,Yearly |

    Scenario: Check the sequence of the series in favorites
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
        When send to "sanity-test-new-fav" favorites of "My favorites"
        Then the sequence of "sanity-test-new-fav" test favorites should be ok

    Scenario: Search series of My favorites
        And create a new "sanity-test-new-fav" group in "My favorites" through the API
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And the favorites "sanity-test-new-fav" should be visible
        And enter the Indicators List Tab
        And search the "ARG - Interest rate - BADLAR" indicator
        And click in "ARG - Interest rate - BADLAR" indicator
        And click in send to a favorites
        And click in continue send series
        And send to "sanity-test-new-fav" favorites of "My favorites"
        When search for the "Broad Consumer"
        Then the "ARINR0008000OODX" serie should be visible
    
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

    Scenario Outline: Check disable export series of my favorites
        And access main page			
        And access "Feature Store" application
        And access 'My favorites' FS tab
        And the favorites "teste" should be visible
        When click "teste" card
        Then check download file is disabled
