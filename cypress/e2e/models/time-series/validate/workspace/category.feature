@CATEGORY_WORKSPACE
@4INTELLIGENCE @WORKSPACE @TIMESERIES @REGRESSION
Feature: Workspace - Category Ys

    Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@SANITY @TS-698
	Scenario: Categorization of the Y's of a workspace
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "ml02-15y-dataset-all-sanity_with_error" text in element "Search Project"
		And I click the "My Project Card Template[name=ml02-15y-dataset-all-sanity_with_error;position=first]"
		And I click the "Confirm Workspace Button"
		When I click the "Create Categorization Button"
		And I click the "Create Filter"
		And I click the "Rename Filter[index=1;position=first]"
		And I write "Regiao" text in element "Name Filter[position=0]"
		And I click the "Create Option Input[index=1]"
		And I write "Norte" text in element "Create Option Input[index=1]"
		And I click the "Create Option Button[index=1]"
		And I click the "Search Variable[index=1]"
		And I write "_n" text in element "Search Variable[index=1]"
		And I click the "Tooltip Radio Button[filter=norte]"
		And I set "Select All Variable Checkbox[index=1]" to checked
		And I click the "Send Variables Filter[index=1]"
		And I click the "Create Option Input[index=1]"
		And I write "Outras Regioes" text in element "Create Option Input[index=1]"
		And I click the "Create Option Button[index=1]"
		And I click the "Search Variable[index=1]"
		And I write "_mw" text in element "Search Variable[index=1]"
		And I click the "Tooltip Radio Button[filter=outras-regioes]"
		And I set "Select All Variable Checkbox[index=1]" to checked
		And I click the "Send Variables Filter[index=1]"
		And I click the "Create Option Input[index=1]"
		And I write "Sudeste" text in element "Create Option Input[index=1]"
		And I click the "Create Option Button[index=1]"
		And I click the "Search Variable[index=1]"
		And I write "_se" text in element "Search Variable[index=1]"
		And I click the "Tooltip Radio Button[filter=sudeste]"
		And I set "Select All Variable Checkbox[index=1]" to checked
		And I click the "Send Variables Filter[index=1]"
		And I click the "Create Option Input[index=1]"
		And I write "Sul" text in element "Create Option Input[index=1]"
		And I click the "Create Option Button[index=1]"
		And I click the "Search Variable[index=1]"
		And I write "_s" text in element "Search Variable[index=1]"
		And I click the "Tooltip Radio Button[filter=sul]"
		And I set "Select All Variable Checkbox[index=1]" to checked
		And I click the "Send Variables Filter[index=1]"
		And I click the "Add New Filter"
		And I click the "Rename Filter[index=2]"
		And I write "Tipo" text in element "Name Filter[position=1]"
		And I click the "Create Option Input[index=2]"
		And I write "Comercial" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "com_" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=comercial]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Create Option Input[index=2]"
		And I write "Residencial" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "res_" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=residencial]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Create Option Input[index=2]"
		And I write "Industria" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "ind_" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=industria]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		Then I click the "Save Changes Button"
		And I set "Select One Checkbox[name=aggregate-results-by-category?]" to checked
		And I set "Select One Checkbox[name=inflate-series?]" to checked
		And I write "Consumo_Energia" text in element "Workspace Name Input"
		And I write "Consumo_Energia" text in element "Workspace Description Input"
		And I click the "Save Workspace Button"
		And I click the "Publish Button"
		And I can see only one of following text "We are creating a preview of your workspace. This process may take a few minutes, please come back later." in element "Publish/Preview Description Modal"

	@TS-698
	Scenario: Add only 3 filters
		And I click the "Workspace Button"
		And I click the "Create Workspace Button"
		And I click the "Select Project Workspace Button"
		And I click the "Search Project"
		And I write "ml02-15y-dataset-all-sanity_with_error" text in element "Search Project"
		And I click the "My Project Card Template[name=ml02-15y-dataset-all-sanity_with_error;position=first]"
		And I click the "Confirm Workspace Button"
		When I click the "Create Categorization Button"
		And I click the "Create Filter"
		And I click the "Add New Filter"
		And I click the "Add New Filter"
		Then I can't see element "Add New Filter"
		And I click the "Save Changes Button"


