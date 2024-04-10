@INDICATORS_LIST
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Check Indicators List from UI

Background:
        Given insert "admin" credentials and login via "MFA"

    @SANITY
    Scenario: Check the Indicators List of Feature Store
        And access main page			
        And access "Feature Store" application
        And check "CPI shows the price change in the economy over a given period of time." description, "Indec" source and, "4intelligence" projection in the "ARG - CPI" indicator
        And select the "ARG - CPI" card name with code "ARPRC0114000OOML"
        Then check the elements of the card
    
    Scenario: Check the failed to load indicators
        And access main page			
        And access "Feature Store" application
        When enter the Indicators List Tab with error
        Then it should not be possible to check the indicators list
    
    @SANITY
    Scenario: Check the elements of the Indicators card 
        And access main page			
        And access "Feature Store" application
        And search the "BRA - Broad" indicator
        When select the "BRA - Broad Consumer Price Index - CPI" card name with code "BRPRC0046"
        And check the elements of the card
        And check the 'BRPRC0046000OOML' series graphic
        And change to line graphic
        And check the 'BRPRC0046000OOML' series graphic
        And change to area graphic
        And check the 'BRPRC0046000OOML' series graphic
        And change graphic filters
        Then check the 'BRPRC0046BSBOOMM' series graphic

    Scenario Outline: Check export series
        And access main page			
        And access "Feature Store" application
        And select the "ARG - CPI" card name with code "ARPRC0114000OOML"
        When click export series
        And select export
        Then check "<fileType>" download file is greather than 1 kB

        Examples:
            | fileType |
            | csv      |
            | excel    |

    Scenario Outline: Check disable export more than 100 series 
        And access main page			
        And access "Feature Store" application
        And search the "BRA - Average Air Temperature" indicator
        And select the "BRA - Average Air Temperature" card name with code "BRMTG0029ATBOODL"
        When click export series
        And select "region" option in modal
        Then check download file is disabled

        Examples:
            | fileType |
            | csv      |
            | excel    |

    Scenario: Check the number of combination series 
        And access main page			
        And access "Feature Store" application
        And search the "PER - GDP" indicator
        And click in "PER - GDP" indicator
        When click in send to a group
        Then the number of warnings should be ok
    
    Scenario: Check the indicator through the filters
        And access main page			
        And access "Feature Store" application
        And click in "Brazil" sub category
        And click in "Economic activity" sub category
        And click in "Real sector" sub category
        And click in "Industry" sub category
        Then check "Index calculated based on the flow of heavy vehicles in toll roads." description, "ABCR" source and, "4intelligence" projection in the "BRA - ABCR Index - Heavy Vehicles" indicator

    Scenario: Check visualize desactive Indicator
        And access main page			
        And access "Feature Store" application
        When search the "teste inativo" indicator
        Then the "teste inativo" indicator should not be visible
    
    Scenario: Check change graphic unit and if is in english
        And access main page			
        And access "Feature Store" application
        And search the "BRA - New Loans - Total - Companies" indicator
        When click in "BRA - New Loans - Total - Companies" indicator
        Then check if unit of "BRCRD0005000OOML" graphic will be changed with the "BRCRD0005000ROML" serie of "Real" in 'primary' filter

    Scenario Outline: Check if filters are navigation kind Breadcumb
        And access main page			
        And access "Feature Store" application
        And click in "Brazil" sub category
        And click in "Economic activity" sub category
        And click in "Real sector" sub category
        And click in "Industry" sub category
        Then check "<filters>" filter should be visible

        Examples:
            | filters                                       |
            | Brazil,Economic activity,Real sector,Industry |
    
    Scenario: Check the filters when export serie
        And access main page			
        And access "Feature Store" application
        And search the "BRA - Broad" indicator
        And select the "BRA - Broad Consumer Price Index - CPI" card name with code "BRPRC0046"
        When change graphic filters
        And click export series
        Then the 'Brazil', 'Monthly', 'Original' and 'Month-over-month' filters should be selected
    
    Scenario Outline: Check search indicators
        And access main page			
        And access "Feature Store" application
        And search the "<search>" indicator
        And click in "<indicator>" indicator
        When click to return
        Then the search fiel should be have "<indicator>"

        Examples:
            | search            | indicator                                 |
            | IPCA              | BRA - Broad Consumer Price Index - CPI   |
            | indice            | BRA - Broad Consumer Price Index - CPI   |
            | bebidas básicos   | BRA - Basic Foods and Beverages, Mainly for Industry - PIM   |
            | BRPRC0046         | BRA - Broad Consumer Price Index - CPI   |

    Scenario: Check graphic limits of series
        And access main page			
        And access "Feature Store" application
        And search the "ARG - CPI" indicator
        When click in "ARG - CPI" indicator
        Then check if estimated value is four years ahead

    Scenario: Check indicators number
        And access main page			
        And access "Feature Store" application
        Then check "World" indicators number in Quick Search is equal pagination number with "WDL - Cocoa Price"
    
    # Scenario Outline: Check if datas of export series is ok
    #     And check observations of "<indicatorCode>" indicator and "<serieCode>" serie with "success"
    #     And check projections of "<indicatorCode>" indicator and "<serieCode>" serie with "success"
    #     And access main page			
    #     And access "Feature Store" application
    #     And search the "<indicator>" indicator
    #     And select the "<indicator>" card name with code "<serieCode>"
    #     When click export series
    #     And select export
    #     Then check "<fileType>" download file contains correct data on "<frequency>" frequency in "<sheet>" sheet

    #     Examples:
    #         | fileType | indicator                           | indicatorCode | serieCode          | frequency                   | sheet     |
    #         | excel    | ARG - CPI                           | ARGDP0110     | ARPRC0114000OOML   | Quarterly                   |   Quarterly |
    
    Scenario Outline: Check if datas of export series is not zero
        And access main page			
        And access "Feature Store" application
        And search the "<indicator>" indicator
        And select the "<indicator>" card name with code "<serieCode>"
        When click export series
        And select export
        Then check "<fileType>" download file not contains data with zero on "<frequency>" frequency in "<sheet>" sheet

        Examples:
            | fileType | indicator                                      | indicatorCode | serieCode          | frequency                    | sheet                      |
            | excel    | BRA - Broad Consumer Price Index - CPI        | BRPRC0046     | BRPRC0046000OOML   | Monthly                      | Monthly   |

    @SANITY
    Scenario: Check if the indicators number in node changes when edit the indicator node
        And access main page			
        And access "Feature Store" application
        And click in "Ecuador" sub category
        And click in "Economic activity" sub category
        And get the number of indicators in each sub category
        And do a new request with "success" to create a new indicator 'active'
        And access main page			
        And access "Feature Store" application
        And click in "Ecuador" sub category
        And click in "Economic activity" sub category
        And check if the number of indicators in each sub category change when 'created'
        When edit created indicator through API
        And access main page			
        And access "Feature Store" application
        And click in "Ecuador" sub category
        And click in "Economic activity" sub category
        Then check if the number of indicators in each sub category change when 'edited'
        And inactive 'created' indicator
        And the 'created' indicator should be inactive

    @SANITY
    Scenario Outline: Check indicator premium
        And create new group of indicator
        And insert 'AREMP0085' indicator in created group
        And insert 'view_user' in created group
        And insert "view" credentials and login via "MFA"
        And access main page			
        And access "Feature Store" application
        And search the "ARG - Unemployment Rate - Urban" indicator
        When select the "ARG - Unemployment Rate - Urban" card name with code "AREMP0085000OOQL"
        And check the elements of the card
        And check the 'AREMP0085000OOQL' series graphic
        And click export series
        And select export
        And check "<fileType>" download file is greather than 1 kB
        And insert "admin" credentials and login via "MFA"
        And access main page
        Then delete user in created group
        And insert "view" credentials and login via "MFA"
        And access main page			
        And access "Feature Store" application
        And search the "ARG - Unemployment Rate - Urban" indicator
        And select "ARG - Unemployment Rate - Urban" indicator without permission
        And the graphic should be not visible
        And check table of series infos
        And the exports series should not be visible
        And insert "admin" credentials and login via "MFA"
        And access main page			
        And access "Access groups" application
        And delete group of indicator

        Examples:
            | fileType |
            | csv      |
            | excel    |

    @FS1802
    Scenario Outline: Check modal of premium groups
        Given insert "<user>" credentials and login via "MFA" 
        And access main page			
        And access "Feature Store" application
        When search the "BRA - Rainfall" indicator
        Then click in modal of groups premium in "BRA - Rainfall" indicator
        And the modal should be visible with following data:
            | indicators                                          |
            | BRA - Average Air Temperature                       |
            | BRA - Maxium Air Temperature                        |
            | BRA - Minimum Air Temperature                       |
            | BRA - Number of days in month with rainfall         |
            | BRA - Relative Humidity                             |
            | BRA - Rainfall                                      |

        Examples:
            | user      |
            | admin     |
            | view      |

    Scenario Outline: Check if the search result is ordained
        And access main page			
        And access "Feature Store" application
        And I intercept "**/api/v1/indicators**" route as "searchIndicators" with "GET" http verbs
        When I write "<searchText>" text in element "Search Indicators Input"
        And I wait "@searchIndicators" routes
        Then I use "1" as "position" in template
        And I can see text "<textCard>" in element "Nth Indicator Card"

        Examples:
            | searchText        | textCard                                                      |
            | pib               | BRA - GDP - IBGE                                              |
            | pmc               | BRA - Sales - Monthly Survey of Trade - PMC                   |
            | ipca              | BRA - Broad Consumer Price Index - CPI                        |
            | selic             | BRA - Selic Rate - Ex-Post                                    |
            | pim               | BRA - Monthly Survey of Industry - Physical Production - PIM  |