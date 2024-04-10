@BEGIN_YOUR_PROJECT
@4INTELLIGENCE @UI @CREATEPROJECT @STEP1 @TIMESERIES @REGRESSION @MODELLING

Feature: Modelling - Begin your Project

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	Scenario: Check See Requirements and download template
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		And I write "Massa_Com_Exclusao" text in element "Project Name Input"
		When I click the "See Requirements Button"
		And I click external download in element "Download Example Button"
		Then I check if download size is greather than 200 kb
		And I clear download folder

	@F4-466 @F4-504 @TS-130
	Scenario Outline: Uploading invalid datasets
		And I click the "Create Project Button"
		And I click the "Time Series Menu"
		And I click the "Begin Your Project Button"
		When I write "InvalidDatasets" text in element "Project Name Input"
		And I attach fixture "<dataset>" in element "Upload File Input"
		And I click the "Select Variables Button"
		Then I can see text "<message>" in element "Error Modal"

		Examples:
			| dataset                               			 					| message 														|       
			| time-series/errors/NoData.xlsx          	  		    				| The file could not be opened.			 						| 	
			| time-series/errors/empty_dataset.xlsx                 				| Dataset must have more than 1 column, one for date and one y 	|
			| time-series/errors/dataset_only_date_value.xlsx       				| Dataset must have more than 1 column, one for date and one y 	|
			| time-series/errors/dataset_pib_fake_sem_data_tidy.xlsx				| Dataset must have at least 1 possible date variable       	|
