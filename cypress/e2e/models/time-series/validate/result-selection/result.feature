@RESULTS
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @AISELECTION
Feature: Results Chart

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page
		And access "Models" application

	@TS-478 @TS-504 @AISELECTION
	Scenario Outline: Verify diary dataset frequency is visible Ai Selection
		Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "aiselection" menu in Model Explorer "time series" model
		And I select frequency "<Frequency>" in "Card Results"
		Then I can see element "Result Container Chart"

		Examples:
			| ProjectName                     | Frequency |
			| diario_without_values_variables | original  |
			| diario_without_values_variables | monthly   |
			| diario_without_values_variables | quarterly |
			| mod1828                         | annual    |

	@TS-477 @USERSELECTION
	Scenario Outline: Verify diary dataset frequency is visible User Selection
		Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "userselection" menu in Model Explorer "time series" model
		And I select frequency "<Frequency>" in "Card Results"
		Then I can see element "Result Container Chart"

		Examples:
			| ProjectName                     | Frequency |
			| diario_without_values_variables | original  |
			| diario_without_values_variables | monthly   |
			| diario_without_values_variables | quarterly |
			| mod1828                         | annual    |

	Scenario Outline: Check Latest data on results chart
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "aiselection" menu in Model Explorer "time series" model
		Then I can see text list "<date>" in element "Result Container Chart"

		Examples:
			| ProjectName           | Frequency | Dependent_variable | date                                                  |
			| Anual_Sanity          | original  | do not set         | 2017;2018;2019;2020;2021;2022                         |
			| UI_FS_Mensal_Sanity_1 | original  | do not set         | Jan 2018;Jul 2018;Jan 2019;Jul 2019;Jan 2020;Jul 2020 |
			| Semestral_Sanity      | original  | do not set         | 2015;2016;2017;2018;2019;2020                         |
			| Quinzenal_Sanity      | original  | do not set         | Jul 2019;Sep 2019;Nov 2019;Jan 2020;Mar 2020          |
			| Semanal_Sanity        | original  | do not set         | Mar 2020;May 2020;Jul 2020;Sep 2020;Nov 2020          |
			| dataset_with_no_date  | original  | do not set         | Mar 2018;May 2018;Jul 2018;Sep 2018;Nov 2018          |

	@TS-338
	Scenario Outline: Verify dataset Ai Selection
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "aiselection" menu in Model Explorer "time series" model
		And I select "<Dependent_variable>" options in element "Dependent Variable Select"
		And I select frequency "<Frequency>" in "Card Results"
		And I can see element "Result Container Chart"
		Then I can see text list "<date>" in element "Result Container Chart"

		Examples:
			| ProjectName             | Frequency | Dependent_variable | date                                                                                                        |
			| ML16-All-Dataset-Diario | monthly   | temp_media         | Jul 2019;Jan 2020;Jul 2020;Jan 2021;Jul 2021;Jan 2022                                                       |
			| Trimestral_Sanity       | original  | pibd               | Apr 2017;Jul 2017;Oct 2017;Jan 2018;Apr 2018;Jul 2018;Oct 2018;Jan 2019;Apr 2019;Jul 2019;Oct 2019;Jan 2020 |


	@AISELECTION
	Scenario Outline: Verify diary dataset frequency is not visible Ai Selection
		Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "aiselection" menu in Model Explorer "time series" model
		And I select frequency "<Frequency>" in "Card Results"
		Then I can't see element "Result Container Chart"

		Examples:
			| ProjectName                     | Frequency |
			| diario_without_values_variables | annual    |

	@TS-477 @USERSELECTION
	Scenario Outline: Verify diary dataset frequency is not visible User Selection
		Given find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		When access to "userselection" menu in Model Explorer "time series" model
		And I select frequency "<Frequency>" in "Card Results"
		Then I can't see element "Result Container Chart"

		Examples:
			| ProjectName                     | Frequency |
			| diario_without_values_variables | annual    |
