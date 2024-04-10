@MODELLING_CLASSIFICATION_DURATION
@4INTELLIGENCE @API @REGRESSION
Feature: Classification - Modelling Time
	Collect 16/11/2023

	@SANITY
	Scenario Outline: Check modelling time duration - "<ProjectName>"
		Given insert "admin" credentials and login via "MFA"
		Then I want compare time "<ProjectName>" actual project with "<BaseProjectId>" baseline projectid

		Examples:
			| ProjectName            | BaseProjectId            |
			| mushroom_sanity        | 65bc03dde3bbe8222bebe866 |
			| cancer_sanity          | 65bc020ae3bbe8222bebe845 |
			| small_dresses_sanity   | 65bc020de3bbe8222bebe847 |
			| diabetes_sanity        | 65bc020ee3bbe8222bebe849 |
			| titanic_sanity         | 65bc0211e3bbe8222bebe84b |
			| fetal_health_sanity    | 65bc0214e3bbe8222bebe84d |
			| spotify_sanity         | 65bc022fe3bbe8222bebe84f |
			| msme_credit_data       | 65bc0236e3bbe8222bebe851 |
			| mushroom_num_reg       | 65bc023de3bbe8222bebe853 |
			| severe_decelerations   | 65bc0240e3bbe8222bebe854 |
			| target_nan_C64         | 65bc0247e3bbe8222bebe857 |
			| binario_numerico_CS_69 | 65bc024be3bbe8222bebe858 |
			| binario_objeto_CS_69   | 65bc024ee3bbe8222bebe859 |
			| classe_unica_CS_69     | 65bc0251e3bbe8222bebe85b |
			| hotel                  | 65bc02aee3bbe8222bebe85f |
			| sanity_pistache        | 65bc02b3e3bbe8222bebe860 |
			| australia_rainfall     | 65b10c64eda10907d30eb6ea |
			| cs284-over30mob4       | 65a16c90eb526f9283f9d010 |
			| salesprice_num1        | 65286631462826491c4a7733 |
			| salesprice_num2        | 6528663d462826491c4a773a |
			| salesprice_str1        | 65286646462826491c4a773e |
			| salesprice_str2        | 65286654462826491c4a7740 |
			| salesprice_sanity      | 65286661462826491c4a7743 |
			| vinhos_sanity          | 65286670462826491c4a774f |
			| winequality            | 6525c3440a3bf662e513c1c2 |
			| tramandai_rnd          | 65286679462826491c4a7752 |
			| drug_200               | 6528667f462826491c4a7756 |
			| glass                  | 65286685462826491c4a7759 |