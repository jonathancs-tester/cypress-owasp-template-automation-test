@MODELOVERVIEW 
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @MODELEXPLORER @TS-134
Feature: Model Explorer - Model Overview

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page			
		And access "Models" application

	@SANITY @TS-144
	Scenario Outline: Check all graphics for Model Overview
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "overview" menu in Model Explorer "time series" model
		Then it should be possible to find "<ModelType>" in Model Summary
		And it should be possible to check "<ElementaryNumber>" models of the "Elementary" in Model Summary
		And it should be possible to find "<AcurracyInitial>" in Selected Criterion Chart
		And change "<Accuracy>" in Accuracy Criteria
		And it should be possible to find "<Accuracy>" in Selected Criterion Chart
		And change "<BestModel>" in N Best Models
		And it should not be possible to find "Model 10" in Aggregate Projections Chart
	
		Examples:
			| ProjectName     		| ModelType 			|AcurracyInitial	| Accuracy   	| BestModel   | ElementaryNumber |
			| UI_Diario_Sanity		| ARIMA   				|MAPE (%)			| RMSE	   		| 9           | 5				 |
			| Semanal_Sanity  		| Forecast Combination  |MAPE (%)			| MPE (%)		| 8           | 4				 | 
			| Quinzenal_Sanity		| Regularized Regression|MAPE (%)			| WMAPE (%)		| 7           | 4				 | 
			| Trimestral_Sanity 	| Regularized Regression|MAPE (%)			| MPE (%)		| 0           | 4				 | 
			| Semestral_Sanity  	| Random Forest  		|MAPE (%)			| RMSE 			| 4           | 4				 | 
			| Anual_Sanity			| Regularized Regression|MAPE (%)			| WMAPE (%)		| 3           | 2				 | 
			| FS_Bimestral_Sanity_1 | ARIMA       			|MAPE (%)			| RMSE  		| 5           | 5				 |
			| NoExploratory_Sanity  | Elementary			|MAPE (%)			| WMAPE (%)		| 4			  | 5				 |

	@SANITY
	Scenario: Check change Y variable for specifics models
		When find "ML16-All-Dataset-Diario" project
		And click to "ML16-All-Dataset-Diario" Model Explorer
		And access to "overview" menu in Model Explorer "time series" model
		And select "fluxo_dia" dependent variable
		Then Model Overview should be visible

	@MOD1827
	Scenario Outline: Check if contain allowdrift parameter 
		When find "<ProjectName>" project
		Then it should be possible to check the allowdrift is equal "<allowdrift>"
	
		Examples:
			| ProjectName     	| allowdrift 	|
			| mod1827_v1 		| true  		|
			| mod1827_v2 		| false 		|
			| mod1828 		    | true  		|

	@MOD1683 @MOD1777 @MOD1896 @TS-498
	Scenario Outline: Check if contain model in Model Summary
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "overview" menu in Model Explorer "time series" model
		Then it should be possible to check "<models>" models of the "<ModelType>" in Model Summary
	
		Examples:
			| ProjectName     | ModelType 				|	models	|
			| mod1683  		  | Elementary   			|	4		|
			| mod1777 		  | Forecast Combination  	|	13		|
			| mod1896  		  | Elementary   			|	5		|
			| mod1683  		  | ARIMA   				|	77		|
			| mod1683  		  | Regularized Regression  |	3		|						

	Scenario Outline: Check option input of Accuracy Criteria in Models' sorting by the selection criterion
		When find "FS_Mensal_Sanity_1" project
		And click to "FS_Mensal_Sanity_1" Model Explorer
		And access to "overview" menu in Model Explorer "time series" model
		Then "<Accuracy>" in Accuracy Criteria should be visible

		Examples:
			| Accuracy |
			| MASE	   |
			| MASEs	   |

	@TS-454 @TS-422
	Scenario Outline: Close model when back the project
	   Given find "<ProjectName>" project
	   And click to "<ProjectName>" Model Explorer
	   When I can see only one of following text "Project Overview" in element "Project Overview Title"
	   And I refresh and wait for element "Project Name Container" and return to previous page
	   Then I can see only one of following text "My Projects" in element "My Projects Modal"

       Examples:
			| ProjectName						| 
			| Dataset-Diario_170_mixed_obser	| 

	@SANITY
    Scenario: Check STL Decomposition in Overview
		Given start a new project creation
		And select "time-series" projects
		And insert "With_YoY_Acum12m_Diff" at "ProjectName" field
		And upload a valid "time-series/weekly_cooking.xlsx" dataset and go to step 2
		And select "yyy-MM-dd" as DateTime format
		When I click the "Visualize Data Button"
        Then it should be possible to check "trend" chart in STL Decomposition
		And it should be possible to check "seasonal" chart in STL Decomposition
		And it should be possible to check "remainder" chart in STL Decomposition