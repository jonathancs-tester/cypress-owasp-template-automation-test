@DATAVIEW_OVERVIEW
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @DATAVIEW
Feature: Data View - Overview

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY
	Scenario Outline: Check Historical Data in Overview
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "<data>" options in element "Format Date Select"
		And I can see element "Visualize Data Button"
		When I click the "Visualize Data Button"
		And I set "Select One Checkbox[name=yoy]" to <yoy>
		And I set "Select One Checkbox[name=qoq]" to <qoq>
		And I set "Select One Checkbox[name=mom]" to <mom>
		And I set "Select One Checkbox[name=acum12m]" to <acum12m>
		And I set "Select One Checkbox[name=diff]" to <diff>
		And I set "Select One Checkbox[name=sa]" to <sa>
		Then I can see text list "<with>" in element "Historical Data Graph Chart"
		And I can't see any of following text "<without>" in element "All Checkbox"
		And I can see element "Type Historical Data Graph Bar Button"
		And I click the "Type Historical Data Graph Bar Button"
		And I can see element "Type Historical Data Graph Line Button"
		And I click the "Type Historical Data Graph Line Button"

		Examples:
			| ProjectName           | dataset                                          | data       | yoy     | qoq     | mom     | acum12m | diff    | sa      | with                         | without            |
			| Without_Dessaz        | time-series/teste_sem_sazon.xlsx                 | do not set | checked | not set | checked | checked | checked | not set | orig;mom;yoy;acum12m;diff    | sa                 |
			| With_YoY_Acum12m_Diff | time-series/weekly_cooking.xlsx                  | do not set | checked | not set | not set | checked | checked | not set | orig;yoy;acum12m;diff        | sa,mom             |
			| Without_YoY_Acum12m   | time-series/weekly_cooking_reduzido.xlsx         | do not set | not set | not set | not set | not set | checked | not set | orig;diff                    | sa,mom,yoy,acum12m |
			| Without_Acum12m       | time-series/dataset_semanal_fake_1_reduzido.xlsx | do not set | checked | not set | not set | not set | checked | not set | orig;yoy;diff                | sa,mom,acum12m     |
			| Sanity_Mensal         | time-series/Mensal/dataset_mensal_fake_3.xlsx    | do not set | checked | not set | checked | checked | checked | checked | orig;sa;mom;yoy;acum12m;diff | qoq                |
			| Trimestral_Sanity     | time-series/dataset_trimestral_fake_1.xlsx       | yyyy-MM-dd | checked | checked | not set | checked | checked | checked | orig;sa;qoq;yoy;acum12m;diff | mom                |

	@SANITY
	Scenario Outline: Check Potencial Outliers in Overview
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "do not set" options in element "Format Date Select"
		And I can see element "Visualize Data Button"
		When I click the "Visualize Data Button"
		Then I can see text "<Arima>" in element "Potencial Outliers Arima"
		And I can see text "<Sarima>" in element "Potencial Outliers Sarima"
		And I can see text "<Cooksd>" in element "Potencial Outliers Cooksd"

		Examples:
			| ProjectName    | dataset                             | Arima          | Sarima     | Cooksd         |
			| Without_Cooksd | time-series/trucs_fs_out.xlsx       | 2013-12-01     | 2019-12-01 | Not Identified |
			| Without_Arima  | time-series/dataset_anual_fake.xlsx | Not Identified | 2010-01-01 | Not Identified |

	@SANITY
	Scenario: Check Correlation in Overview
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Diario_Regression_4" text in element "Project Name Input"
		And I attach fixture "time-series/dataset_diario_fake_4.xlsx" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "do not set" options in element "Format Date Select"
		And I can see element "Visualize Data Button"
		When I click the "Visualize Data Button"
		Then I can see element "Correlation HighChart Bar Layer"
		And I can't see any of following text "d_dia_util" in element "Correlation Chart"

	Scenario Outline: Check errors messages of the Correlation in Overview
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "do not set" options in element "Format Date Select"
		And I can see element "Visualize Data Button"
		When I click the "Visualize Data Button"
		Then I can see text "<errors>" in element "Correlation Error Card"

		Examples:
			| ProjectName          | dataset                                                  | errors                                         |
			| NoExploratory_Sanity | time-series/no_explanatory_variables.xlsx                | No explanatory variables selected              |
			| Only_Dummies         | time-series/dataset_semestral_fake_1_so_dummy-step2.xlsx | All selected explanatory variables are dummies |

	Scenario Outline: Check error messages of the STL Decomposition in Overview
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "<ProjectName>" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I can see element "Select Variables Button"
		And I click the "Select Variables Button"
		And I wait for element "Final Settings Button" be enabled
		And I select "do not set" options in element "Format Date Select"
		And I can see element "Visualize Data Button"
		And I click the "Visualize Data Button"
		Then I can see text "<errors>" in element "STL Decomposition Error Card"

		Examples:
			| ProjectName         | dataset                                   | errors                                                                         |
			| Without_Dessaz      | time-series/teste_sem_sazon.xlsx          | Series without seasonality                                                     |
			| Without_Dessaz      | time-series/teste_sem_sazon.xlsx          | Series without residues                                                        |
			| Without_YoY_Acum12m | time-series/weekly_cooking_reduzido.xlsx  | Series has less than two periods                                               |
			| Anual_Sanity        | time-series/dataset_anual_fake.xlsx       | STL decomposition is not available for this frequency.                         |
			| Quinzenal_Sanity    | time-series/dataset_quinzenal_fake_1.xlsx | STL decomposition is not available for this frequency.                         |
			| Diario_Sanity       | time-series/dataset_diario_fake_4.xlsx    | STL decomposition is not available for this frequency.                         |
			| missingData_Sanity  | time-series/test_fs_wd-missing_data.xlsx  | It's not possible to calculate the decomposition for series with missing data. |
