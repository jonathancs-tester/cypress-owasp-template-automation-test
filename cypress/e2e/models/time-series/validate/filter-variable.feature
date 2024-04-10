@FILTER
@4INTELLIGENCE @UI @TIMESERIES @REGRESSION
Feature: Filter Variable

	Background: Login
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"		
		And I click the "Models"

	@F4-2054
	Scenario Outline: Categorization of the Y's of a project
		Given I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=1]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I can see text "latest update" in element "Sidebar Container"
		And I can see element "Dependent Variables Chart"
		When I click the "Dependent Variables Config"
		And I click the "Create Filter"
		And I click the "Rename Filter[index=1;position=first]"
		And I write "Regiao" text in element "Name Filter[position=0]"
		And I click the "Create Option Input[index=1]"
		And I write "Nordeste" text in element "Create Option Input[index=1]"
		And I click the "Create Option Button[index=1]"
		And I click the "Search Variable[index=1]"
		And I write "nordeste" text in element "Search Variable[index=1]"
		And I click the "Tooltip Radio Button[filter=nordeste]"
		And I set "Select All Variable Checkbox[index=1]" to checked
		And I click the "Send Variables Filter[index=1]"
		And I click the "Create Option Input[index=1]"
		And I write "Outras Regioes" text in element "Create Option Input[index=1]"
		And I click the "Create Option Button[index=1]"
		And I click the "Search Variable[index=1]"
		And I write "resto_do_brasil" text in element "Search Variable[index=1]"
		And I click the "Tooltip Radio Button[filter=outras-regioes]"
		And I set "Select All Variable Checkbox[index=1]" to checked
		And I click the "Send Variables Filter[index=1]"
		And I click the "Create Option Input[index=1]"
		And I write "Sudeste" text in element "Create Option Input[index=1]"
		And I click the "Create Option Button[index=1]"
		Then I click the "Search Variable[index=1]"
		And I write "biscoito_sudeste" text in element "Search Variable[index=1]"
		And I click the "Tooltip Radio Button[filter=sudeste]"
		And I set "Select All Variable Checkbox[index=1]" to checked
		And I click the "Send Variables Filter[index=1]"
		And I click the "Add New Filter"
		And I click the "Rename Filter[index=2]"
		And I write "Marca" text in element "Name Filter[position=1]"
		And I click the "Create Option Input[index=2]"
		And I write "Adria" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "adria" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=adria]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Create Option Input[index=2]"
		And I write "Fortaleza" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "fortaleza" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=fortaleza]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Create Option Input[index=2]"
		And I write "Isabela" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "isabela" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=isabela]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Create Option Input[index=2]"
		And I write "Outras Marcas" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "outras_marcas" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=outras-marcas]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Create Option Input[index=2]"
		And I write "Piraque" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "piraque" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=piraque]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Create Option Input[index=2]"
		And I write "Richester" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "richester" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=richester]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Create Option Input[index=2]"
		And I write "Vitarella" text in element "Create Option Input[index=2]"
		And I click the "Create Option Button[index=2]"
		And I click the "Search Variable[index=2]"
		And I write "vitarella" text in element "Search Variable[index=2]"
		And I click the "Tooltip Radio Button[filter=vitarella]"
		And I set "Select All Variable Checkbox[index=2]" to checked
		And I click the "Send Variables Filter[index=2]"
		And I click the "Add New Filter"
		And I click the "Rename Filter[index=3]"
		And I write "Tipo do Produto" text in element "Name Filter[position=2]"
		And I click the "Create Option Input[index=3]"
		And I write "Cream Craker" text in element "Create Option Input[index=3]"
		And I click the "Create Option Button[index=3]"
		And I click the "Search Variable[index=3]"
		And I write "cream" text in element "Search Variable[index=3]"
		And I click the "Tooltip Radio Button[filter=cream-craker]"
		And I set "Select All Variable Checkbox[index=3]" to checked
		And I click the "Send Variables Filter[index=3]"
		And I click the "Create Option Input[index=3]"
		And I write "Familias" text in element "Create Option Input[index=3]"
		And I click the "Create Option Button[index=3]"
		And I click the "Search Variable[index=3]"
		And I write "familias" text in element "Search Variable[index=3]"
		And I click the "Tooltip Radio Button[filter=familias]"
		And I set "Select All Variable Checkbox[index=3]" to checked
		And I click the "Send Variables Filter[index=3]"
		And I click the "Create Option Input[index=3]"
		And I write "Maizena" text in element "Create Option Input[index=3]"
		And I click the "Create Option Button[index=3]"
		And I click the "Search Variable[index=3]"
		And I write "maizena" text in element "Search Variable[index=3]"
		And I click the "Tooltip Radio Button[filter=maizena]"
		And I set "Select All Variable Checkbox[index=3]" to checked
		And I click the "Send Variables Filter[index=3]"
		And I click the "Create Option Input[index=3]"
		And I write "Recheados" text in element "Create Option Input[index=3]"
		And I click the "Create Option Button[index=3]"
		And I click the "Search Variable[index=3]"
		And I write "recheados" text in element "Search Variable[index=3]"
		And I click the "Tooltip Radio Button[filter=recheados]"
		And I set "Select All Variable Checkbox[index=3]" to checked
		And I click the "Send Variables Filter[index=3]"
		And I click the "Create Option Input[index=3]"
		And I write "Rosquinha" text in element "Create Option Input[index=3]"
		And I click the "Create Option Button[index=3]"
		And I click the "Search Variable[index=3]"
		And I write "rosquinha" text in element "Search Variable[index=3]"
		And I click the "Tooltip Radio Button[filter=rosquinha]"
		And I set "Select All Variable Checkbox[index=3]" to checked
		And I click the "Send Variables Filter[index=3]"
		And I click the "Save Filter Config"

		Examples:
			| ProjectName             |
			| teste_mdias_dataset_70y |