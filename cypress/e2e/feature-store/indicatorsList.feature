@INDICATORS_LIST
@4INTELLIGENCE @UI @FEATURE_STORE @REGRESSION
Feature: Check Indicators List from UI

Background:
        Given insert "admin" credentials and login via "MFA"

    @SANITY
    Scenario: Check the Indicators List of Feature Store
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - GDP - IBGE" text in element "Search Indicators Input"
        When I click "BRA - GDP - IBGE" name in "Indicator Card"
        Then check the elements of the card
    
    Scenario: Check the failed to load indicators
        And I visit "/"		
		And I click the "Feature Store Button"
        When enter the Indicators List Tab with error
        Then I can see text "Unable to load indicators." in element "Failed Indicators"
    
    @SANITY
    Scenario: Check the elements of the Indicators card 
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - Broad" text in element "Search Indicators Input"
        When I click "BRA - Broad Consumer Price Index - CPI" name in "Indicator Card"
        And I can see element "Series Chart"
        And I click the "Type Historical Data Graph Line Button"
        And I can see element "Series Chart"
        And I click the "Type Historical Data Graph Area Button"
        Then I can see element "Series Chart"
        And I can see text "Last forecast Update" in element "Last Update Projection"

    Scenario Outline: Check export series
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - Economic Activity Index" text in element "Search Indicators Input"
        And I click "BRA - Economic Activity Index - IBC-BR" name in "Indicator Card"
        When I click the "Export Button"
        And I click the "Export Series Button"
        And I click the "Export <fileType> format"
        Then I check if download size is greather than 20 kb
        And I clear download folder

        Examples:
            | fileType |
            | CSV      |
            | XLXS     |

    # Scenario: Check disable export more than 100 series 
    #     And I visit "/"		
	# 	And I click the "Feature Store Button"
    #     And I write "BRA - Average Air Temperature" text in element "Search Indicators Input"
    #     And I click "BRA - Average Air Temperature" name in "Indicator Card"
    #     When I click the "Export Button"
    #     And I set "Select One Checkbox[name=region]" to checked
    #     Then I wait for element "Export Button" be disabled

    Scenario: Check the number of combination series 
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "Peru" options in element "Select Country"
        And I write "PER - GDP" text in element "Search Indicators Input"
        And I click "PER - GDP" name in "Indicator Card"
        When I click the "Export Button"
        Then the number of warnings should be ok
    
    Scenario: Check the indicator through the filters
        And I visit "/"		
		And I click the "Feature Store Button"
        And I click "Economic activity" name in "Sub Category FS Menu"
        And I click "Real sector" name in "Sub Category FS Menu"
        And I click "Industry" name in "Sub Category FS Menu"
        Then I can see text "BRA - Vehicle Traffic on Toll Roads - ABCR" in element "Indicator Card"

    Scenario: Check visualize desactive Indicator
        And I visit "/"		
		And I click the "Feature Store Button"
        When I write "teste inativo" text in element "Search Indicators Input"
        Then I can't see any of following text "teste inativo" in element "Indicator Card"
    
    Scenario: Check change graphic unit and if is in english
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - New Loans - Total - Companies" text in element "Search Indicators Input"
        When I click "BRA - New Loans - Total - Companies" name in "Indicator Card"
        And I get before info in "Unit chart"
        And I select "Year over year" options in element "Secondary Transformation Serie Select"
        And I get after info in "Unit chart"
        Then I compare after info is not equal before info

    # # Scenario Outline: Check if filters are navigation kind Breadcumb
        # And I visit "/"		
		# And I click the "Feature Store Button"
    # #  
    # #     And I click "Economic activity" name in "Sub Category FS Menu"
    # #     And I click "Real sector" name in "Sub Category FS Menu"
    # #     And I click "Industry" name in "Sub Category FS Menu"
    # #     Then check "<filters>" filter should be visible

    # #     Examples:
    # #         | filters                                       |
    # #         | Brazil,Economic activity,Real sector,Industry |
    
    # Scenario: Check the filters when export serie
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #  
    #     And I write "BRA - Broad Consumer Price Index - CPI" text in element "Search Indicators Input"
    #     And I click "BRA - Broad Consumer Price Index - CPI" name in "Indicator Card"
    #     When I select "Month over month" options in element "Secondary Transformation Serie Select"
    #     And I select "Monthly" options in element "Frequency Serie Select"
    #     And I select "Original" options in element "Primary Transformation Serie Select"
    #     And I click the "Export Button"
    #     Then the 'Brazil', 'Monthly', 'Original' and 'Month-over-month' filters should be selected
    
    Scenario Outline: Check search indicators
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "<search>" text in element "Search Indicators Input"
        And I click "<indicator>" name in "Indicator Card"
        When I click the "Back Button"
        Then I can see text "<indicator>" in element "Indicator Card"

        Examples:
            | search            | indicator                                 |
            | CPI               | BRA - Broad Consumer Price Index - CPI   |
            | índice de preços  | BRA - Broad Consumer Price Index - CPI   |
            | bebidas básicos   | BRA - Basic Foods and Beverages, Mainly for Industry - PIM   |
            | BRPRC0046         | BRA - Broad Consumer Price Index - CPI   |

    # Scenario: Check graphic limits of series
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #  
    #     And I write "BRA - GDP - IBGE" text in element "Search Indicators Input"
    #     And I intercept "**/observations**,**/projections**" route as "waitObservations,waitProjections" with "GET,GET" http verbs
    #     When I click "BRA - GDP - IBGE" name in "Indicator Card"
    #     And I wait "@waitObservations,@waitProjections" routes
    #     Then check if estimated value is four years ahead

    # Scenario: Check indicators number
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And I select "Argentina" options in element "Select Country"
    #     Then check "external-sector" indicators number in Quick Search is equal pagination number with "ARG - Direct Investment"
    
    # Scenario Outline: Check if datas of export series is ok
    #     And check observations of "<indicatorCode>" indicator and "<serieCode>" serie with "success"
    #     And check projections of "<indicatorCode>" indicator and "<serieCode>" serie with "success"
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And search the "<indicator>" indicator
    #     And select the "<indicator>" card name with code "<serieCode>"
    #     When click export series
    #     And select export
    #     Then check "<fileType>" download file contains correct data on "<frequency>" frequency in "<sheet>" sheet

    #     Examples:
    #         | fileType | indicator                           | indicatorCode | serieCode          | frequency                   | sheet     |
    #         | excel    | BRA - GDP - IBGE                           | ARGDP0110     | ARPRC0114000OOML   | Quarterly                   |   Quarterly |

    Scenario Outline: Check if datas of export series is not zero
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "<indicator>" text in element "Search Indicators Input"
        And I click "<indicator>" name in "Indicator Card"
        When I click the "Export Button"
        And I click the "Export Series Button"
        And I clear download folder 
        And I click the "Export <fileType> format"
        # Then check "<fileType>" download file not contains data with zero on "<frequency>" frequency in "<sheet>" sheet #TODO

        Examples:
            | fileType | indicator                                      | indicatorCode | serieCode          | frequency                    | sheet                      |
            | XLXS    | BRA - Broad Consumer Price Index - CPI        | BRPRC0046     | BRPRC0046000OOML   | Monthly                      | Monthly   |

    # @SANITY
    # Scenario: Check if the indicators number in node changes when edit the indicator node
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And I select "Ecuador" options in element "Select Country"
    #     And I click "Economic activity" name in "Sub Category FS Menu"
    #     And get the number of indicators in each sub category
    #     And do a new request with "success" to create a new indicator 'active'
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And I select "Ecuador" options in element "Select Country"
    #     And I click "Economic activity" name in "Sub Category FS Menu"
    #     And check if the number of indicators in each sub category change when 'created'
    #     When edit created indicator through API
        # And I visit "/"		
		# And I click the "Feature Store Button"
    #     And I select "Ecuador" options in element "Select Country"
    #     And I click "Economic activity" name in "Sub Category FS Menu"
    #     Then check if the number of indicators in each sub category change when 'edited'
    #     And inactive 'created' indicator
    #     And the 'created' indicator should be inactive

    @SANITY
    Scenario Outline: Check indicator premium
        And Delete all indicators groups test   
        And create new group of indicator "<access_group>"
        And insert '<indicatorCode>' indicator in created group
        And insert 'view_user' in created group
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "<country>" options in element "Select Country"
        And I write "<indicator>" text in element "Search Indicators Input"
        When I click "<indicator>" name in "Indicator Card"
        And I click the "Export Button"
        And I click the "Export Series Button"
        And I clear download folder 
        And I click the "Export <fileType> format"
        And I check if download size is greather than 1 kb
        And insert "admin" credentials and login via "MFA"
        And I visit "/"	
        Then delete user in created group
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "<country>" options in element "Select Country"
        And I write "<indicator>" text in element "Search Indicators Input"
        And I click "<indicator>" name in "Indicator Card"
        And I can see text "Upgrade to get access!" in element "Needs payment modal"
        And I can't see element "Export Button"
        And insert "admin" credentials and login via "MFA"
        And Delete all indicators groups test
        And I clear download folder

        Examples:
            | fileType | access_group   | indicatorCode | indicator                               | country     |
            | CSV      | premium        | AREMP0085     | ARG - Unemployment Rate - Urban - Test  | Argentina   |

    @SANITY
    Scenario Outline: Check indicator private
        And Delete all indicators groups test   
        And create new group of indicator "<access_group>"
        And insert '<indicatorCode>' indicator in created group
        And insert 'view_user' in created group
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "<country>" options in element "Select Country"
        And I write "<indicator>" text in element "Search Indicators Input"
        When I click "<indicator>" name in "Indicator Card"
        And I click the "Export Button"
        And I click the "Export Series Button"
        And I clear download folder 
        And I click the "Export <fileType> format"
        And I check if download size is greather than 1 kb
        And insert "admin" credentials and login via "MFA"
        And I visit "/"	
        Then delete user in created group
        And insert "view" credentials and login via "MFA"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "<country>" options in element "Select Country"
        And I write "<indicator>" text in element "Search Indicators Input"
        And I can't see any of following text "BRA - GDP - IBGE" in element "Indicator Card"
        And insert "admin" credentials and login via "MFA"
        And Delete all indicators groups test
        And I clear download folder

        Examples:
            | fileType | access_group   | indicatorCode | indicator                               | country     |
            | XLXS     | private        | BRGDP0002     | BRA - GDP - IBGE                        | Brazil      |

    # @FS1802
    # Scenario Outline: Check modal of premium groups
    #     And Delete all indicators groups test
    #     Given insert "<user>" credentials and login via "MFA" 
    #     And I visit "/"		
	# 	And I click the "Feature Store Button"
    #     When I write "BRA - Rainfall" text in element "Search Indicators Input"
    #     Then I click the "Premium group modal[m=bra---rainfall]"
    #     And the modal should be visible with following data:
    #         | indicators                                          |
    #         | BRA - Average Air Temperature                       |
    #         | BRA - Maxium Air Temperature                        |
    #         | BRA - Minimum Air Temperature                       |
    #         | BRA - Number of days in month with rainfall         |
    #         | BRA - Relative Humidity                             |
    #         | BRA - Rainfall                                      |

    #     Examples:
    #         | user      |
    #         | view      |

    Scenario Outline: Check if the search result is ordained
        And I visit "/"		
		And I click the "Feature Store Button"
        And I intercept "**/api/v1/indicators**" route as "searchIndicators" with "GET" http verbs
        When I write "<searchText>" text in element "Search Indicators Input"
        And I wait "@searchIndicators" routes
        Then I use "1" as "position" in template
        And I can see text "<textCard>" in element "Nth Indicator Card"

        Examples:
            | searchText        | textCard                                                      |
            | pib               | BRA - GDP - IBGE                                              |
            | pmc               | BRA - Sales - Monthly Survey of Trade - PMC                   |
            | cpi               | BRA - Broad Consumer Price Index - CPI                        |
            | selic             | BRA - Selic Rate - Ex-Post                                    |
            | pim               | BRA - Monthly Survey of Industry - Physical Production - PIM  |

    @SANITY
    Scenario Outline: Check indicator premium and basic with freemium user
        And insert "freemium" credentials and login via "DEV"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I select "<selectCountry>" options in element "Select Country"
        And I write "<Indicator>" text in element "Search Indicators Input"
        When I click "<Indicator>" name in "Indicator Card"
        And I can see text "Upgrade to get access!" in element "Needs payment modal"

        Examples:
            | Indicator                                 | selectCountry |       
            | ARG - Unemployment Rate - Urban - Test    | Argentina     |
            | BRA - GDP - Trade - IBGE                  | Brazil        |

    @SANITY
    Scenario: Check freemium indicator with freemium user
        And insert "freemium" credentials and login via "DEV"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - Broad Consumer Price Index - CPI" text in element "Search Indicators Input"
        When I click "BRA - Broad Consumer Price Index - CPI" name in "Indicator Card"
        And I can see text "Index (1993/dec = 100)" in element "Unit chart"

    @SANITY @FS-2071
    Scenario: Check series code in clipboard
        And insert "freemium" credentials and login via "DEV"
        And I visit "/"		
		And I click the "Feature Store Button"
        And I write "BRA - Broad Consumer Price Index - CPI" text in element "Search Indicators Input"
        When I click "BRA - Broad Consumer Price Index - CPI" name in "Indicator Card"
        Then I check if have "BRPRC0046000OOML" text in "Indicator clipboard button" clipboard button
        And I click the "Export Button"
        And I set "Select One Checkbox[name=frequency]" to checked
        And I check if have "BRPRC0046000OOML,BRPRC0046000OEQL,BRPRC0046000OAQL,BRPRC0046000OEYL,BRPRC0046000OAYL" text in "Multi Series clipboard button" clipboard button