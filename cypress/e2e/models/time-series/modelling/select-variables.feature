@SELECT_VARIABLES
@4INTELLIGENCE @UI @CREATEPROJECT @STEP2 @TIMESERIES @REGRESSION @MODELLING

Feature: Modelling - Select Variables

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"

	Scenario: Download dataset at Visualize Data
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "FS_Anual_Download_1" text in element "Project Name Input"
		And I attach fixture "time-series/dataset_anual_fake.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I click the "Download Dataset Button"
		Then I check if download size is greather than 200 kb
		And I check if data is correctly with following data:
			| row | data_tidy           | pim  | cambio_r         | cambio_r_lag1    | igp     | igp_lag1 | ipca             | ipca_lag1        | pib_fam          | pib_fam_lag1     | pib_fbcf         | pib_fbcf_lag1    | pib_ind          | pib_ind_lag1     | pib_tot          | pib_tot_lag1     | pib_x            | pib_x_lag1       | z_juros          | z_juros_lag1     |
			| 5   | 2005-01-01 00:00:00 | 88.1 | 171.525687757027 | 171.525687757027 | 336.123 | 336.123  | 152.427540314229 | 152.427540314229 | 119.401010913342 | 119.401010913342 | 107.485702596071 | 107.485702596071 | 117.833606181532 | 117.833606181532 | 126.235472967886 | 126.235472967886 | 220.373785529916 | 220.373785529916 | 10.0638904375449 | 10.0638904375449 |
		And I clear download folder

	Scenario: Changing a Dependent Variable and check them at Explanatory Variables box
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Mensal_Change_Variable" text in element "Project Name Input"
		And I attach fixture "time-series/Mensal/dataset_mensal_fake_3.xlsx" in element "Upload File Input"
		And I click the "Select Variables Button"
		When I select "rendar" options in element "Response Variable Select"
		And I select "massa_r" options in element "Response Variable Select"
		Then I can see text "rendar" in element "Explanatory Variable Select"
		And I can't see any of following text "massa_r" in element "Explanatory Variable Select"

	@TS-130 @TS-856
	Scenario Outline: Select Variable errors
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "FailedDatasets" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		And I click the "Final Settings Button"
		Then I can see text "<message>" in element "Error Modal"

		Examples:
			| dataset                                            | message                                                                                                                                                                                                                                                             |
			| time-series/errors/dataset_ipca_fake_reduzido.xlsx | Please add more observations to your dataset. Number of observations should be greater than (according to frequency) 'daily' -> 180, 'weekly' -> 52, 'fortnightly' -> 24, 'monthly' -> 36, 'bimonthly' -> 24, 'quarterly' -> 24, 'half-year' -> 24, 'annual' -> 12. |
			| time-series/errors/dataset_with_d4i_var.xlsx       | Invalid prefix for variable name ('d4i_' or 'do_'):                                                                                                                                                                                                                 |
			| time-series/errors/dataset_with_do_var.xlsx        | Invalid prefix for variable name ('d4i_' or 'do_'):                                                                                                                                                                                                                 |