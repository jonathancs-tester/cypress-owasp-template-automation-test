@USUAL_TEST_DOWNLOAD_FORECAST
@4INTELLIGENCE @UI @REGRESSION
Feature: Download Forecast for Validate Algoritm

	@SANITY
	Scenario Outline: Download forecast for usual tests
		Given insert "admin" credentials and login via "MFA"
		And I visit "/"
		And I click the "Models"
		And I click the "Search Project"
		When I write "<ProjectName>" text in element "Search Project"
		And I intercept "**/projects?project_name=**" route as "waitProjects" with "GET" http verbs
		And I wait "@waitProjects" routes
		And I intercept "**/download" route as "waitDownload" with "GET" http verbs
		And I click the "Options Project Button[project=<ProjectName>;position=first]"
		And I click the "Menu Download Project Button[project=<ProjectName>;position=first]"
		And I wait "@waitDownload" routes
		Then I check if download size is greather than 200 kb

		Examples:
			| ProjectName                             |
			| anual_semexplicativa_peq                |
			| anual_acuracia_mediana                  |
			| anual_valoresgrandes_semlog             |
			| anual_lags                              |
			| anual_exclusion                         |
			| anual_golden                            |
			| bim_linhas_faltantes                    |
			| bim_config_padrao                       |
			| bim_logfalse_mediana                    |
			| bim_pequeno                             |
			| bim_semexplicativa                      |
			| bim_semexpli_nstepsewindows1            |
			| bim_linhasfaltantes_lags                |
			| bim_linhasfaltantes_golden              |
			| bim_linhasfaltantes_exclusion           |
			| trim_gapy                               |
			| trim_linhasfaltantes_logeseasd_false    |
			| trim_linhasfaltantes_nstepsewindows1    |
			| trim_muitascolunas_pim                      |
			| trim_semexplicativa_peq                 |
			| trim_muitaslinhas_semexplicativa        |
			| trim_muitascolunas_seasdfalse           |
			| trim_muitascolunas_lags                 |
			| trim_muitascolunas_golden               |
			| trim_muitascolunas_exclusion            |
			| quin_muitaslinhas_semexpli              |
			| quin_log_e_seasd_false                  |
			| quin_pequeno_log_e_seasd_false          |
			| quin_pequeno_nstepsewindows1            |
			| quin_lags                               |
			| quin_golden                             |
			| semestral_semexplicativa                |
			| semestral_logfalse                      |
			| semestral_pequeno                       |
			| semestral_log_e_seasd_false             |
			| semestral_lags                          |
			| semestral_golden                        |
			| semestral_exclusion                     |
			| semanal_grande_muitascolunas_logseasd_f |
			| semanal_grande_muitascolunas_logseasd_t |
			| semanal_pequeno_muitascolunas           |
			| semanal_grande_semexplicativas_gap      |
			| semanal_linhasfaltantes                 |
			| semanal_padrão                          |
			| semanal_lags                            |
			| semanal_golden                          |
			| semanal_exclusion                       |
			| mensal_seas_marcada_ipca                |
			| mensal_linhasfaltantes_pmc              |
			| mensal_seas_marcada_log_false           |
			| mensal_seas_marcada_log_true            |
			| mensal_log_false                        |
			| mensal_linhasfaltantes_caged            |
			| mensal_pequeno_wmape_median             |
			| mensal_pequeno_sazonal                  |
			| mensal_pequeno_pandemia                 |
			| mensal_grande_muitascolunas             |
			| mensal_lags                             |
			| mensal_golden                           |
			| mensal_exclusion                        |
			| diario_y_num_inteiros                   |
			| diario_muitoszeros_e_dummies            |
			| diario_semexplicativa_numinteiros       |
			| diario_gapy_lagsdataset                 |
			| diario_dummies_sazonais                 |
			| diario_muitos_outliers                  |
			| diario_semexplicativa_logseasd_t                   |
			| diario_semexplicativa_peq               |
			| diario_muitas_dummies                   |
			| diario_lags                             |
			| diario_golden                           |
			| diario_exclusion                        |
