@VALIDATE_MODELLING
@4INTELLIGENCE @CREATEPROJECT @TIMESERIES @REGRESSION @MODELLING

Feature: Modeling - Validate

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"
		
	@TS-182 @TS-130 @SANITY
	Scenario Outline: Validate messages in modelling
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Validate_modelling" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		When I click the "Final Settings Button"
		And I can see element "Custom Period Toggle"
		And I close the "Feature Selection Modal" if exists
		Then I can see text "<message>" in element "Models Modal"
		And I can see text "<variables>" in element "Models Modal"
		And I close the "Data Processing Modal" if exists

		Examples:
			| dataset                          			   		| variables 																				| message | 
			| time-series/Mensal/dataset_fs_mensal_fake_1.xlsx	| dem_domestica, quantidade_2.																| Some Explanatory Variables contain missing values in the forecast period. Review the dataset or set the fine tunning option 'Explanatory Variables Auto - Forecast' to 'ON' to use them for forecasting.| 
			| time-series/teste_sem_sazon.xlsx 					| y_sintetico. 																				| Dataset does not contain a forecast period. In order to obtain forecasts, the Dependent Variable should contain empty (NA) values for the forecast period.|
			| time-series/Mensal/vazao_sf.xlsx  				| aet, f1_ppt, f2_aet, f3_pet, pet, ppt, sd_aet, sd_pet, sd_ppt, vazao_med, vazao_min.		| Removing variables due to a high percentage of missing observations: |
			| time-series/dataset_energia_com_co-step2.xlsx		| fs_outstanding_loanstotalindividuals_br_39, l1_fs_outstanding_loanstotalindividuals_br_39.| Removing redundant variables. We can safely drop them since their information is already fully contained in other features:|
