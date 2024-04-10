@USERSELECTION_EXPORT
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION @USERSELECTION
Feature: User Selection - Export Dataset

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And access main page
		And access "Models" application

	@SANITY @TS-244 @USERSELECTION
	Scenario Outline: Check export dataset with historical series and forecasts - User Selection
		When find "<ProjectName>" project
		And click to "<ProjectName>" Model Explorer
		And access to "<menu>" menu in Model Explorer "time series" model
		And access to "<submenu>" submenu in "<menu>" Model Explorer
		And I select "<ModelList>" options in element "Model List Variable Select"
		And I click the "Send to User Selection Button"
		And I click the "See More Information Button"
		And I can see element "Selected Model"
		And I can't see element "Loading"
		And I click the "Download User Selection"
		Then I check if download size is greather than 200 kb

		Examples:
			| ProjectName           | menu                  | submenu         | ModelList |
			| UI_Diario_Sanity      | arima                 | modelspecifics  | 4         |
			| Semanal_Sanity        | arima                 | crossvalidation | 9         |
			| Quinzenal_Sanity      | forecastcombination   | modelspecifics  | 2         |
			| Sanity_Mensal         | regularizedregression | crossvalidation | 3         |
			| Trimestral_Sanity     | forecastcombination   | modelspecifics  | 6         |
			| Semestral_Sanity      | forecastcombination   | crossvalidation | 12        |
			| Anual_Sanity          | randomforest          | modelspecifics  | 1         |
			| FS_Bimestral_Sanity_1 | randomforest          | crossvalidation | 1         |
			| FS_pim_mar2002        | arima                 | modelspecifics  | 2         |