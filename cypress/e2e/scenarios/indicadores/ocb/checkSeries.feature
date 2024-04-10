@4INTELLIGENCE @UI @INDICATORS @OCB @REGRESSION
Feature: Check Feature Store page for OCB

Background: Login with OCB user
	Given insert "ocb" credentials and login via "MFA"
	And access main page			

	@SANITY @F4-753
	Scenario: Check more information of the one line in serie
		When click "Geral" in Feature Store menu
		And click more information of the "BRGDP0002000ROQL" serie
		And click graph "BAR" type
		And click graph "AREA" type
		And change filter "20/04/2020" start and "30/09/2023" end
		Then check the "Fonte" info with "IBGE" value
		And check the "Apr 2020" start date in Graph
		And check download in "EXCEL" format and greather than 200 kB
		And check download in "CSV" format and greather than 200 kB

	@SANITY @F4-960
	Scenario: Check more information of the multiple lines in serie
		When click "Saúde" in Feature Store menu
		And click more information of the "BRSTS0032000OOQL,BRSTS0033000OOQL" serie
		And click graph "BAR" type
		And click graph "AREA" type
		And change filter "20/04/2005" start and "30/09/2020" end
		Then check the "Fonte" info with "ANS" value
		And check the "Número de Beneficiários de Planos de Saúde" legend in Graph
		And check the "Número de Beneficiários de Planos Odontológicos" legend in Graph
		And check the "2020" start date in Graph
		And check download in "EXCEL" format and greather than 200 kB
		And check download in "CSV" format and greather than 200 kB

	@SANITY
	Scenario: Check the Geral Series
		When click "Geral" in Feature Store menu
		Then it should be possible check "BRGDP0002000ROQL" serie "PIB Real" value and "IBGE" font
		And it should be possible check "BRPRC0046000OOMM" serie "IPCA" value and "IBGE" font
		And it should be possible check "BRFXR0003000OEML" serie "Taxa de Câmbio Nominal" value and "Banco Central" font
		And it should be possible check "BRINR0012000OOMN" serie "Taxa Selic Efetiva" value and "Banco Central" font
		And it should be possible check "BRIND0001000OOML" serie "Pesquisa Industrial Mensal" value and "IBGE" font
		And it should be possible check "BRRTL0021000OOML" serie "Pesquisa Mensal do Comércio Restrita" value and "IBGE" font
		And it should be possible check "BRRTL0022000OOML" serie "Pesquisa Mensal do Comércio Ampliada" value and "IBGE" font
		And it should be possible check "BRSER0001000OOML" serie "Pesquisa Mensal de Serviços" value and "IBGE" font
		And it should be possible check "BRGDP0001000OOML" serie "Índice de Atividade Econômica" value and "Banco Central" font
		And it should be possible check "BREMP0018000OOML" serie "Taxa de Desocupação" value and "IBGE" font
		And it should be possible check "BRPRC0024000OOMM" serie "IGP-M" value and "FGV" font
		And it should be possible check "BREMP0016000OOML" serie "População Ocupada" value and "IBGE" font
		And it should be possible check "BREMP0006000OOML" serie "Criação de Vagas Formais" value and "Ministério da Economia" font
	
	@SANITY
	Scenario: Check the Agropecuário Series
		When click "Agropecuário" in Feature Store menu
		Then it should be possible check "BRGDP0016000ROQL" serie "PIB - Agropecuária" value and "IBGE" font
		And it should be possible check "BRGDP0088000OOML" serie "Índice de Volume - Agropecuária" value and "4intelligence" font
		And it should be possible check "BRBOP0044000OOML" serie "Exportações - Agropecuária" value and "Funcex" font
		And it should be possible check "BRBOP0013000OOML" serie "Saldo Comercial" value and "BCB" font
		And it should be possible check "BRAGR0040000OOML" serie "Valor Bruto da Produção - Agropecuária" value and "Ministério da Agricultura" font

	@SANITY
	Scenario: Check the Consumo Series
		When click "Consumo" in Feature Store menu
		Then it should be possible check "BRGDP0011000ROQL" serie "PIB - Consumo das Famílias" value and "IBGE" font
		And it should be possible check "BREMP0016000OOML" serie "População Ocupada" value and "IBGE" font
		And it should be possible check "BREMP0006000OOML" serie "Criação de Vagas Formais" value and "Ministério da Economia" font
		And it should be possible check "BREMP0019000ROML" serie "Renda Média Habitual Real" value and "IBGE" font
		And it should be possible check "BREMP0021000ROML" serie "Massa de Rendimentos Habitual Real" value and "IBGE" font
		And it should be possible check "BRCRD0026000OOML" serie "Saldo da Carteira de Crédito - Pessoas Físicas" value and "Banco Central" font
		And it should be possible check "BRLDG0003000OOML" serie "Índice de Confiança do Consumidor" value and "FGV" font
		And it should be possible check "BRSTS0030000OOML" serie "Tráfego Aéreo - Número de voos" value and "INFRAERO" font
		And it should be possible check "BRSTS0031000OOML" serie "Tráfego Aéreo - Número de passageiros" value and "INFRAERO" font

	@SANITY
	Scenario: Check the Crédito Series
		When click "Crédito" in Feature Store menu
		Then it should be possible check "BRCRD0026000OOML" serie "Saldo da Carteira de Crédito - Pessoas Físicas" value and "Banco Central" font
		And it should be possible check "BRCRD0027000OOML" serie "Saldo da Carteira de Crédito - Pessoas Jurídicas" value and "Banco Central" font
		And it should be possible check "BRCRD0054000OOML" serie "Inadimplência da Carteira de Crédito - Pessoas Físicas" value and "Banco Central" font
		And it should be possible check "BRCRD0055000OOML" serie "Inadimplência da Carteira de Crédito - Pessoas Jurídicas" value and "Banco Central" font
		And it should be possible check "BRCRD0048000OOML" serie "Taxa de Juros - Pessoas Físicas" value and "Banco Central" font
		And it should be possible check "BRCRD0047000OOML" serie "Taxa de Juros - Pessoas Jurídicas" value and "Banco Central" font
		And it should be possible check "BRCRD0006000OOML" serie "Concessões de Crédito - Pessoas Físicas" value and "Banco Central" font
		And it should be possible check "BRCRD0005000OOML" serie "Concessões de Crédito - Pessoas Jurídicas" value and "Banco Central" font
	
	@SANITY
	Scenario: Check the Infraestrutura Series
		When click "Infraestrutura" in Feature Store menu
		Then it should be possible check "BRGDP0013000ROQL" serie "PIB - Formação Bruta de Capital Fixo" value and "IBGE" font
		And it should be possible check "BRGDP0021000ROQL" serie "PIB - Construção Civil" value and "IBGE" font
		And it should be possible check "BRPRC0033000OOMM" serie "Índice Nacional da Construção Civil" value and "FGV" font
		And it should be possible check "BRCRD0073000OOML" serie "Saldo de Crédito - Habitacional - Pessoas Físicas" value and "Banco Central" font
		And it should be possible check "BRCRD0072000OOML" serie "Saldo de Crédito - Habitacional - Pessoas Jurídicas" value and "Banco Central" font
		And it should be possible check "BRIND0209000OOML" serie "Consumo total de Energia Elétrica" value and "ONS" font
		And it should be possible check "BRIND0208000OOML" serie "Geração Total de Energia Elétrica" value and "ONS" font
		And it should be possible check "BRGDP0085000OOML" serie "Índice de Volume - Serviços Indústriais de Utilidade Pública" value and "4intelligence" font

	@SANITY
	Scenario: Check the Saúde Series
		When click "Saúde" in Feature Store menu
		Then it should be possible check "BREMP0016000OOML" serie "População Ocupada" value and "IBGE" font
		And it should be possible check "BREMP0006000OOML" serie "Criação de Vagas Formais" value and "Ministério da Economia" font
		And it should be possible check "BREMP0019000ROML" serie "Renda Média Habitual Real" value and "IBGE" font
		And it should be possible check "BREMP0021000ROML" serie "Massa de Rendimentos Habitual Real" value and "IBGE" font
		And it should be possible check "BRSTS0032000OOQL" serie "N° de Beneficários - Médicos" value and "ANS" font
		And it should be possible check "BRSTS0032000OOQF" serie "Saldo do Número de Beneficiários de Plano de Saúde" value and "ANS" font
		And it should be possible check "BRPRC0178000OOMM" serie "INPC - Serviços de Saúde" value and "IBGE" font
		And it should be possible check "BRPRC0179000OOMM" serie "INPC - Planos de Saúde" value and "IBGE" font
		And it should be possible check "BRPRC0262000OOMY" serie "Variação do Custo Médico Hospitalar do IESS" value and "IESS Data" font
		And it should be possible check "BRPRC0263000OOYL" serie "Reajuste PF Plano de Saúde Individuais ou Familiares (%)" value and "ANS" font
		And it should be possible check "BRPRC0265000OOYL" serie "Reajustes Plano de Saúde Coletivos de 30 ou Mais Vidas (%)" value and "ANS" font
		And it should be possible check "BRPRC0264000OOYL" serie "Reajustes Plano de Saúde Coletivos de até 29 Vidas (%)" value and "ANS" font	
	
	@SANITY
	Scenario: Check the Trabalho, Produção de Bens e Serviços Series
		When click "Trabalho, Produção de Bens e Serviços" in Feature Store menu
		Then it should be possible check "BREMP0019000ROML" serie "Renda Média Habitual Real" value and "IBGE" font
		And it should be possible check "BREMP0021000ROML" serie "Massa de Rendimentos Habitual Real" value and "IBGE" font
		And it should be possible check "BRGDP0022000ROQL" serie "PIB - Serviços" value and "IBGE" font
		And it should be possible check "BRIND0003000OOML" serie "Pesquisa Industrial Mensal - Indústria de Transformação" value and "IBGE" font
		And it should be possible check "BRSER0005000OOML" serie "Pesquisa Mensal de Serviços - Serviços Prestados às Famílias" value and "IBGE" font

	@SANITY
	Scenario: Check the Transporte Series
		When click "Transporte" in Feature Store menu
		Then it should be possible check "BRLDG0018000OOML" serie "Índice ABCR - Veículos Leves" value and "ABCR" font
		And it should be possible check "BRLDG0019000OOML" serie "Índice ABCR - Veículos Pesados" value and "ABCR" font
		And it should be possible check "BRSER0006000OOML" serie "Pesquisa Mensal de Serviços - Transportes" value and "IBGE" font
		And it should be possible check "BRPRC0066000OOMM" serie "IPCA - Transportes" value and "IBGE" font
		And it should be possible check "BRPUB0001000OOML" serie "Arrecadação Tributária e Previdênciária" value and "Receita Federal" font