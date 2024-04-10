@MODELLING_TIME_SERIES_DURATION
@4INTELLIGENCE @API @REGRESSION
Feature: Time Series -  Modelling Time
	Collect 16/11/2023

	@SANITY
	Scenario Outline: Check modelling time duration - "<ProjectName>"
		Given insert "admin" credentials and login via "MFA"
		Then I want compare time "<ProjectName>" actual project with "<BaseProjectId>" baseline projectid

		Examples:
			| ProjectName                             | BaseProjectId            |
			| anual_semexplicativa_peq                | 65b95bb4c80330598780a663 |
			| anual_acuracia_mediana                  | 65bbfd91b44330d71a5e7fe6 |
			| anual_valoresgrandes_semlog             | 65bbfd94b44330d71a5e7fed |
			| anual_lags                              | 65bbfd93b44330d71a5e7feb |
			| anual_exclusion                         | 65bbfd92b44330d71a5e7fe8 |
			| anual_golden                            | 65bbfd92b44330d71a5e7fe9 |
			| bim_linhas_faltantes                    | 65c29064c70c4667cf92fbd1 |
			| bim_config_padrao                       | 65bbfd94b44330d71a5e7fef |
			| bim_logfalse_mediana                    | 65bbfd97b44330d71a5e7ff6 |
			| bim_pequeno                             | 65bbfd98b44330d71a5e7ff7 |
			| bim_semexplicativa                      | 65bbfd99b44330d71a5e7ffb |
			| bim_semexpli_nstepsewindows1            | 65bbfd99b44330d71a5e7ff9 |
			| bim_linhasfaltantes_lags                | 65bbfd96b44330d71a5e7ff4 |
			| bim_linhasfaltantes_golden              | 65bbfd96b44330d71a5e7ff3 |
			| bim_linhasfaltantes_exclusion           | 65bbfd95b44330d71a5e7ff2 |
			| trim_gapy                               | 65bbfdbeb44330d71a5e8043 |
			| trim_linhasfaltantes_logeseasd_false    | 65bbfdbeb44330d71a5e8044 |
			| trim_linhasfaltantes_nstepsewindows1    | 65bbfdc0b44330d71a5e8046 |
			| trim_muitascolunas_pim                  | 65c6488bc499c2985da03636 |
			| trim_semexplicativa_peq                 | 65bbfdc5b44330d71a5e804f |
			| trim_muitaslinhas_semexplicativa        | 65bbfdc4b44330d71a5e804e |
			| trim_muitascolunas_seasdfalse           | 65bbfdc3b44330d71a5e804c |
			| trim_muitascolunas_lags                 | 65bbfdc3b44330d71a5e804b |
			| trim_muitascolunas_golden               | 65bbfdc2b44330d71a5e804a |
			| trim_muitascolunas_exclusion            | 65bbfdc1b44330d71a5e8048 |
			| quin_muitaslinhas_semexpli              | 65bbfdaeb44330d71a5e8028 |
			| quin_log_e_seasd_false                  | 65bbfdaeb44330d71a5e8026 |
			| quin_pequeno_log_e_seasd_false          | 65c6488ac499c2985da03635 |
			| quin_pequeno_nstepsewindows1            | 65bbfdb0b44330d71a5e802b |
			| quin_lags                               | 65bbfdadb44330d71a5e8025 |
			| quin_golden                             | 65bbfdadb44330d71a5e8023 |
			| semestral_semexplicativa                | 65bbfdbdb44330d71a5e8042 |
			| semestral_logfalse                      | 65bbfdbcb44330d71a5e8040 |
			| semestral_pequeno                       | 65bbfdbcb44330d71a5e8041 |
			| semestral_log_e_seasd_false             | 65b95becc80330598780a699 |
			| semestral_lags                          | 65bbfdb9b44330d71a5e803d |
			| semestral_golden                        | 65bbfdb9b44330d71a5e803c |
			| semestral_exclusion                     | 65bbfdb8b44330d71a5e803a |
			| semanal_grande_muitascolunas_logseasd_f | 65bbfdb2b44330d71a5e802f |
			| semanal_grande_muitascolunas_logseasd_t | 65bbfdb3b44330d71a5e8031 |
			| semanal_pequeno_muitascolunas           | 65bbfdb7b44330d71a5e8039 |
			| semanal_grande_semexplicativas_gap      | 65bbfdb4b44330d71a5e8033 |
			| semanal_linhasfaltantes                 | 65bbfdb6b44330d71a5e8036 |
			| semanal_padrão                          | 65bbfdb6b44330d71a5e8037 |
			| semanal_lags                            | 65bbfdb5b44330d71a5e8034 |
			| semanal_golden                          | 65bbfdb1b44330d71a5e802e |
			| semanal_exclusion                       | 65bbfdb1b44330d71a5e802c |
			| mensal_seas_marcada_ipca                | 65c29066c70c4667cf92fbd3 |
			| mensal_linhasfaltantes_pmc              | 65c29065c70c4667cf92fbd2 |
			| mensal_seas_marcada_log_false           | 65bbfdabb44330d71a5e8020 |
			| mensal_seas_marcada_log_true            | 65bbfdacb44330d71a5e8022 |
			| mensal_log_false                        | 65bbfda8b44330d71a5e8019 |
			| mensal_linhasfaltantes_caged            | 65bbfda8b44330d71a5e8018 |
			| mensal_pequeno_wmape_median             | 65bbfdaab44330d71a5e801d |
			| mensal_pequeno_sazonal                  | 65bbfda9b44330d71a5e801c |
			| mensal_pequeno_pandemia                 | 65bbfda9b44330d71a5e801a |
			| mensal_grande_muitascolunas             | 65bbfda4b44330d71a5e8012 |
			| mensal_lags                             | 65bbfda6b44330d71a5e8015 |
			| mensal_golden                           | 65bbfda3b44330d71a5e8010 |
			| mensal_exclusion                        | 65bbfda3b44330d71a5e800f |
			| diario_y_num_inteiros                   | 65bbfda2b44330d71a5e800d |
			| diario_muitoszeros_e_dummies            | 65bbfda0b44330d71a5e8008 |
			| diario_semexplicativa_numinteiros       | 65bbfda1b44330d71a5e800a |
			| diario_gapy_lagsdataset                 | 65b95bbec80330598780a670 |
			| diario_dummies_sazonais                 | 65bbfd9ab44330d71a5e7ffc |
			| diario_muitos_outliers                  | 65bbfd9fb44330d71a5e8006 |
			| diario_semexplicativa_logseasd_t        | 65c64888c499c2985da03634 |
			| diario_semexplicativa_peq               | 65bbfda1b44330d71a5e800c |
			| diario_muitas_dummies                   | 65bbfd9eb44330d71a5e8005 |
			| diario_lags                             | 65b95bc1c80330598780a672 |
			| diario_golden                           | 65bbf88bb44330d71a5e7f03 |
			| diario_exclusion                        | 65bbf888b44330d71a5e7f01 |
			| ML01-Consumo-Energia-Nstep12-Sanity     | 65947f8ecd9a7d291fb86ef2 |
			| ML02-15Y-Dataset-All-Sanity_with_error  | 65665cec8bac0021fadd49e8 |
			| ML23-All-Dataset-Anual                  | 658b4487e971e6c22d97e027 |
			| ML24-All-Dataset-Bimestral              | 655688d9db8cd57dfc5e9c54 |
			| ML25-All-Dataset-Semanal                | 655688dadb8cd57dfc5e9c55 |
			| ML26-All-Dataset-Semestral              | 655688dadb8cd57dfc5e9c56 |
			| ML27-All-Dataset-Trimestral             | 655688dbdb8cd57dfc5e9c57 |
			| ML28-All-Dataset-Quinzenal              | 655688dbdb8cd57dfc5e9c58 |
			| ML29-All-Dataset-Mensal                 | 655688dddb8cd57dfc5e9c59 |
			| ML06-All-Demo-Dataset-Sanity-Lags       | 655688e0db8cd57dfc5e9c5b |
			| ML16-All-Dataset-Diario                 | 655688e6db8cd57dfc5e9c64 |
			| 63fce7818af6757fa3a97aee                | 655688eddb8cd57dfc5e9c71 |
			| RezendeJob_AllPick4me                   | 65568877db8cd57dfc5e9c04 |
			| teste_mdias_dataset_70y                 | 6595740fe8a33e64110ac3e4 |
			| Mensal_All_With_Pick4Me                 | 6556a8ed6afbffee68978b65 |
			| UI_Diario_Sanity                        | 65a9875cf83c4180e8afcc9c |
			| All_Mensal_partial_success              | 65537de97be4547498a0abaa |
			| diario_sem_sabado_domingo               | 65cfa01cb4ca00d486c1e29b |