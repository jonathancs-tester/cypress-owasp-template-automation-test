@UPDATE_HISTORY
@4INTELLIGENCE @UI @CREATEPROJECT @REGRESSION @TIMESERIES
Feature: Update History

	Background: Login
		Given insert "admin" credentials and login via "MFA"

	@SANITY @CS-336
	Scenario: Check Update History
		And I visit "/"
		And I click the "Models"
		And I click the "Search Project"
		And I write "ui_diario_sanity" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=ui_diario_sanity;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I can see text "latest update" in element "Sidebar Container"
		And I wait for element "Project Menu Button" be enabled
		When I click the "Project Menu Button"
		And I wait for element "Update History Button" be enabled
		And I click the "Update History Button"
		Then I can see only one of following text "Update 1" in element "Update List"
		And I get after info in "Update Data Info[position=first]"
		And I get before info in "Update Data Info[position=last]"
		And I compare after info is not equal before info
		And I click the "Original Button"
		And I can see text "Original" in element "Sidebar Container"
		And I click the "Menu Model Explorer[index=overview]"
		And I can see text "MAPE (%)" in element "Models's Sorting Chart"

	@CS-399
	Scenario Outline: Check modeling number in update
		And I visit "/"
		And I click the "Models"
		And I click the "Search Project"
		And I write "upt_stl_arim_univ" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=upt_stl_arim_univ;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I can see text "latest update" in element "Sidebar Container"
		And I intercept "**/models/business/variables/**" route as "businessVariables" with "GET" http verbs
		And I wait "@businessVariables" routes
		When I click the "Menu Model Explorer[index=overview]"
		And I use "arima" as "name" in template
		Then I can see text "<arima>" in element "Models's Summary Quantity Table"
		And I use "forecast-combination" as "name" in template
		And I can see text "<forecast_combination>" in element "Models's Summary Quantity Table"
		And I use "elementary" as "name" in template
		And I can see text "<elementary>" in element "Models's Summary Quantity Table"
		And I use "regularized-regression" as "name" in template
		And I can see text "<regularized_regression>" in element "Models's Summary Quantity Table"
		And I use "random-forest" as "name" in template
		And I can see text "<random_forest>" in element "Models's Summary Quantity Table"

		Examples:
			| arima | forecast_combination | elementary | regularized_regression | random_forest |
			| 14    | 11                   | 3          | 2                      | 1             |

	# REFATORAR O CENÁRIO ENQUANTO ISSO REALIZAR A MÃO
	# @SANITY
	# Scenario: Check Share Update History
	# 	And search "all_mensal_modelling" id in response API
	# 	And create duplicate project with "@projectID", "read-project@4casthub.com" user and "success" response
	# 	And I visit "/"
	# 	And I click the "Models"
	# 	And I click the "Search Project"
	# 	And I write "all_mensal_modelling" text in element "Search Project"
	# 	And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
	# 	And I wait "@waitProjects" routes
	# 	And I click the "My Project Card Template[name=all_mensal_modelling;position=first]"
	# 	And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
	#     And I wait "@modelUpdate" routes
	# 	And I can see text "latest update" in element "Sidebar Container"
	#     And I wait for element "Project Menu Button" be enabled
	# 	When I click the "Project Menu Button"
	#     And I wait for element "Update History Button" be enabled
	#     And I click the "Update History Button"
	# 	And I get after info in "Update Data Info[position=first]"
	# 	And I click the "Share Update Button[position=first]"
	# 	And I click the "Send Share Update Button"
	# 	And insert "read_project" credentials and login via "MFA"
	# 	And I visit "/"
	# 	And I click the "Models"
	# 	And I click the "Search Project"
	# 	And I write "all_mensal_modelling" text in element "Search Project"
	# 	And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
	# 	And I wait "@waitProjects" routes
	# 	And I click the "My Project Card Template[name=all_mensal_modelling;position=first]"
	# 	And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
	#     And I wait "@modelUpdate" routes
	# 	And I can see text "latest update" in element "Sidebar Container"
	#     And I wait for element "Project Menu Button" be enabled
	# 	When I click the "Project Menu Button"
	#     And I wait for element "Update History Button" be enabled
	#     And I click the "Update History Button"
	# 	And I get before info in "Update Data Info[position=first]"
	#     Then I compare after info is equal to before info

	@SANITY
	Scenario: Check documentation of the Update Models
		And I visit "/"
		And I click the "Models"
		And I click the "Search Project"
		And I write "all_mensal_modelling" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=all_mensal_modelling;position=first]"
		And I intercept "**/updates" route as "modelUpdate" with "GET" http verbs
		And I wait "@modelUpdate" routes
		And I wait for element "Project Menu Button" be enabled
		When I click the "Project Menu Button"
		And I wait for element "Update Docs Button" be enabled
		And I click the "Update Docs Button"
		Then I wait for element "See Documentation Button" be enabled

	@SANITY @CS-314
	Scenario Outline: Check download Update History
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Search Project"
		And I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=<ProjectName>;position=1]"
		And I click the "Menu Model Explorer[index=aiselection]"
		And I intercept "**/model-in-production/**" route as "waitModels" with "GET" http verbs
		And I wait "@waitModels" routes
		And I click the "Project Menu Button"
		And I wait for element "Update History Button" be enabled
		And I click the "Update History Button"
		And I click the "Download Update Enabled Button[position=first]"
		Then I can see text "Download completed." in element "Layout Container"

		Examples:
			| ProjectName                |
			| all_mensal_partial_success |

	@CS-497
	Scenario Outline: Check Update with multiple ys
		And I visit "/"
		And I click the "Models"
		And I click the "Search Project"
		And I write "cs_497_upt_mult_y_nomes_parecidos" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I intercept "**/model-in-production/**" route as "waitModels" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I click the "My Project Card Template[name=cs_497_upt_mult_y_nomes_parecidos;position=first]"
		And I wait "@waitModels" routes
		And I can see text "latest update" in element "Sidebar Container"
		And I wait for element "Project Menu Button" be enabled
		When I click the "Project Menu Button"
		And I wait for element "Update History Button" be enabled
		And I click the "Update History Button"
		Then I can see only one of following text "Update 1" in element "Update List"
		And I click the "Close History Button"
		And I select "<y-var>" options exactly in element "Dependent Variable Select"
		And I click the "Menu Model Explorer[index=overview]"
		And I use "<ModelType>" as "name" in template
		Then I can see element "Models's Summary Model Type Table"
		
		
		Examples:
			| y-var     | ModelType         | 
			|hdv        | arima             | 
			|hdv_dlh    | arima             | 
			|hdv_elh    | arima             |
			|hdv_hcm    | arima             |
			|hdv_lc     | arima             | 
			|mhdv       | arima             | 
			|mhdv_d     | arima             | 
			|mhdv_dr    | arima             |
			|mhdv_lc    | arima             | 
			|mhdv_r     | arima             |
			|total      | arima             | 
			
