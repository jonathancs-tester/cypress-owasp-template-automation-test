@4INTELLIGENCE @UI @INDICATORS @STG @REGRESSION
Feature: Check Indicadores page for STG

Background: Login with STG user
	Given insert "stg" credentials and login via "MFA"
	And access main page			

	@SANITY
	Scenario: Check the Câmbio Series
		When click "Câmbio" in Indicadores menu
		Then it should be possible check "BRFXR0003000OAML" serie "Dólar (R$/US$)" value and "Banco Central" font
		And it should be possible check "BRFXR0015000OAML" serie "Euro (R$/Euro)" value and "Banco Central" font
	
	@SANITY
	Scenario: Check the Carbono e derivados Series
		When click "Carbono e derivados" in Indicadores menu
		Then it should be possible check "WDPRC0289000OOML" serie "Carbeto de Silício (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0289000OOMM" serie "Carbeto de Silício (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0288000OOML" serie "Carbono (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0288000OOMM" serie "Carbono (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0290000OOML" serie "Diamantes (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0290000OOMM" serie "Diamantes (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0292000OOML" serie "Eletrodo de Grafite (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0292000OOMM" serie "Eletrodo de Grafite (Variação %)" value and "Receita Federal" font

	@SANITY
	Scenario: Check the Celulose, Papel e Tecidos Series
		When click "Celulose, Papel e Tecidos" in Indicadores menu
		Then it should be possible check "WDPRC0282000OOML" serie "Celulose Fibra Curta (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0282000OOMM" serie "Celulose Fibra Curta (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0285000OOML" serie "Papel Kraft (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0285000OOMM" serie "Papel Kraft (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0283000OOML" serie "Papel Látex (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0283000OOMM" serie "Papel Látex (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0287000OOML" serie "Tecido não Tecido (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0287000OOMM" serie "Tecido não Tecido (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0286000OOML" serie "Tecidos de Algodão (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0286000OOMM" serie "Tecidos de Algodão (Variação %)" value and "Receita Federal" font

	@SANITY
	Scenario Outline: Check the Cestas Series
		#TODO: https://4intelligenceds.atlassian.net/browse/QA-1909
		When click "<menu>" in Indicadores menu
		Then it should be possible check all charts, elaborations and fonts in "<cestas>" Cestas

		Examples:
			|  	menu	 				| cestas 			|
			| 	Cestas-GE 				| GE				|
			| 	Cestas-Dissidios 		| Dissidios			|
			| 	Cestas-Compras Tecnicas | Compras Tecnicas	|
			| 	Cestas-Transportes	    | Transportes		|
		
	@SANITY
	Scenario: Check the Dissídios - Limpeza e Conservação Series
		When click "Dissídios - Limpeza e Conservação" in Indicadores menu
		Then it should be possible check "BREMP0174SP2OOMM" serie "SEAC- SP (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0176RS2OOMM" serie "SEEAC-RS (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0175RJ2OOMM" serie "SINDICATO DAS EMP ASSEIO E CONS EST DO RIO DE JANEIRO (Variação %)" value and "MTE" font

	@SANITY
	Scenario: Check the Dissídios - Motorista Series
		When click "Dissídios - Motorista" in Indicadores menu
		Then it should be possible check "BREMP0187SP2OOMM" serie "Sindicargas - SP (Variação %)" value and "MTE" font

	@SANITY	
	Scenario: Check the Dissídios - Portaria e Vigilância Series
		When click "Dissídios - Portaria e Vigilância" in Indicadores menu
		Then it should be possible check "BREMP0182SP2OOMM" serie "SEEVISSP - SP (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0178SP2OOMM" serie "SESVESP - SP (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0177RJ2OOMM" serie "SIEMACO - RJ (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0179SP2OOMM" serie "SINDEPRESTEM - SP (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0180RS2OOMM" serie "SINDICATO DAS EMPRESAS DE SEGURANCA E VIGILÂNCIA DO ESTADO DO RIO GRANDE DO SUL - RS (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0181RS2OOMM" serie "SINDICATO PROFISSIONAL DOS EMPREGADOS DE EMPRESAS DE SEGURANÇA E VIGILÂNCIA DE PORTO ALEGRE E REGIÃO METROPOLITANA DO RGS - RS (Variação %)" value and "MTE" font

	@SANITY
	Scenario: Check the Dissídios - Restaurante Series
		When click "Dissídios - Restaurante" in Indicadores menu
		Then it should be possible check "BREMP0186SP2OOMM" serie "SINDERC - SP (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0184SP2OOMM" serie "Sindicato de Refeições Coletivas de Osasco e Região - SP (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0183RJ2OOMM" serie "SINDIREFEIÇÕES - RJ (Variação %)" value and "MTE" font
		And it should be possible check "BREMP0185SP2OOMM" serie "SINTERCAMP - SP (Variação %)" value and "MTE" font	

	@SANITY
	Scenario: Check the Energia Series
		When click "Energia" in Indicadores menu
		Then it should be possible check "WDPRC0284000OOML" serie "Carvão Vegetal Eucalipto (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0284000OOMM" serie "Carvão Vegetal Eucalipto (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0267000OOML" serie "Extrato de Mamona - Óleo de Rícino (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0267000OOMM" serie "Extrato de Mamona - Óleo de Rícino (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0266000OOML" serie "Óleo de Coco (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0266000OOMM" serie "Óleo de Coco (Variação %)" value and "Receita Federal" font

	@SANITY
	Scenario: Check the Inflação Series
		When click "Inflação" in Indicadores menu
		Then it should be possible check "BRPRC0045000OOMM" serie "INPC (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0005000OOMM" serie "INCC-DI (Variação %)" value and "FGV" font
		And it should be possible check "BRPRC0024000OOMM" serie "IGP-M (Variação %)" value and "FGV" font
		And it should be possible check "BRPRC0033000OOMM" serie "INCC-M (Variação %)" value and "FGV" font
		And it should be possible check "BRPRC0025000OOMM" serie "IPA-M (Variação %)" value and "FGV" font	
		And it should be possible check "BRPRC0036000OOMM" serie "IPC-M (Variação %)" value and "FGV" font
		And it should be possible check "BRPRC0046000OOMM" serie "IPCA - Geral (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0062000OOMM" serie "IPCA - Alimentação (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0064000OOMM" serie "IPCA - Artigos de Residência (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0070000OOMM" serie "IPCA - Comunicação (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0068000OOMM" serie "IPCA - Despesas Pessoais (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0069000OOMM" serie "IPCA - Educação (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0063000OOMM" serie "IPCA - Habitação (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0067000OOMM" serie "IPCA - Saúde (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0066000OOMM" serie "IPCA - Transportes (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0065000OOMM" serie "IPCA - Vestuário (Variação %)" value and "IBGE" font
		And it should be possible check "BRAGR0042000OOML" serie "IC-BR Brasil (Índice)" value and "Banco Central" font
		And it should be possible check "BRAGR0049000OOML" serie "IC-BR Metal (Índice)" value and "Banco Central" font
		And it should be possible check "BRAGR0050000OOML" serie "IC-BR Energia (Índice)" value and "Banco Central" font
		And it should be possible check "BRPRC0133000OOML" serie "IPP - Indústria Geral (Índice)" value and "IBGE" font
		And it should be possible check "BRPRC0133000OOMM" serie "IPP - Indústria Geral (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0145000OOML" serie "IPP - Derivados Petróleo (Índice)" value and "IBGE" font
		And it should be possible check "BRPRC0149000OOML" serie "IPP - Borracha (Índice)" value and "IBGE" font
		And it should be possible check "BRPRC0154000OOML" serie "IPP - Elétricos (Índice)" value and "IBGE" font
		And it should be possible check "BRPRC0145000OOMM" serie "IPP - Derivados Petróleo (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0149000OOMM" serie "IPP - Borracha (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0154000OOMM" serie "IPP - Elétricos (Variação %)" value and "IBGE" font
		And it should be possible check "BRPRC0007000OOMM" serie "INCC-DI - Mão de Obra (Variação %)" value and "FGV" font
		And it should be possible check "BRPRC0006000OOMM" serie "INCC-DI - Materiais de Construção (Variação %)" value and "FGV" font
		
	@SANITY
	Scenario: Check the Minérios Series
		When click "Minérios" in Indicadores menu
		Then it should be possible check "WDPRC0235000OOML" serie "Alumínio (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0235000OOMM" serie "Alumínio (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0268000OOML" serie "Bauxita (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0268000OOMM" serie "Bauxita (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0291000OOML" serie "Pasta de Prata – LBMA (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0291000OOMM" serie "Pasta de Prata – LBMA (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0294000OOML" serie "Aço (US$/Kg tonelada)" value and "LME" font
		And it should be possible check "WDPRC0294000OOMM" serie "Aço (Variação %)" value and "LME" font
		And it should be possible check "WDPRC0226000OOML" serie "Cobre (US$/tonelada)" value and "LME" font
		And it should be possible check "WDPRC0226000OOMM" serie "Cobre (Variação %)" value and "LME" font
		And it should be possible check "WDPRC0269000OOML" serie "Óxido de Alumínio (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0269000OOMM" serie "Óxido de Alumínio (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0271000OOML" serie "Agalmolito -Silicato de Alumínio (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0271000OOMM" serie "Agalmolito -Silicato de Alumínio (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0270000OOML" serie "Criolita (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0270000OOMM" serie "Criolita (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0246000OOML" serie "Minério de Ferro (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0246000OOMM" serie "Minério de Ferro (Variação %)" value and "Receita Federal" font
		
	@SANITY
	Scenario: Check the Outros Series
		When click "Outros" in Indicadores menu
		Then it should be possible check "WDPRC0273000OOML" serie "Dextrina (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0273000OOMM" serie "Dextrina (Variação %)" value and "Receita Federal" font
		And it should be possible check "BRPRC0293000OOML" serie "ICTI (Índice)" value and "IPEA" font
		And it should be possible check "BRPRC0293000OOMM" serie "ICTI (Variação %)" value and "IPEA" font

	@SANITY
	Scenario: Check the Petróleo e Derivados Series
		When click "Petróleo e Derivados" in Indicadores menu
		Then it should be possible check "WDPRC0233000OOML" serie "Petróleo WTI (US$/barril)" value and "FMI" font
		And it should be possible check "WDPRC0234000OOML" serie "Petróleo BRENT (US$/Barril)" value and "FMI" font
		And it should be possible check "WDPRC0277000OOML" serie "PVC Suspenso (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0277000OOMM" serie "PVC Suspenso (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0274000OOML" serie "Polietileno (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0274000OOMM" serie "Polietileno (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0275000OOML" serie "Polipropileno (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0275000OOMM" serie "Polipropileno (Variação %)" value and "Receita Federal" font	
		And it should be possible check "WDPRC0276000OOML" serie "Polímeros (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0276000OOMM" serie "Polímeros (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0278000OOML" serie "Politetrafluoretileno - PTFE (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0278000OOMM" serie "Politetrafluoretileno - PTFE (Variação %)" value and "Receita Federal" font
		And it should be possible check "BRPRC0112000OAML" serie "Diesel S500 - Brasil (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112CO1OAML" serie "Diesel S500 - Centro Oeste (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112NE1OAML" serie "Diesel S500 - Nordeste (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112NO1OAML" serie "Diesel S500 - Norte (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112SE1OAML" serie "Diesel S500 - Sudeste (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112SU1OAML" serie "Diesel S500 - Sul (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112AC2OAML" serie "Diesel S500 - AC (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112AL2OAML" serie "Diesel S500 - AL (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112AM2OAML" serie "Diesel S500 - AM (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112BA2OAML" serie "Diesel S500 - BA (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112CE2OAML" serie "Diesel S500 - CE (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112DF2OAML" serie "Diesel S500 - DF (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112ES2OAML" serie "Diesel S500 - ES (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112GO2OAML" serie "Diesel S500 - GO (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112MA2OAML" serie "Diesel S500 - MA (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112MG2OAML" serie "Diesel S500 - MG (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112MS2OAML" serie "Diesel S500 - MS (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112MT2OAML" serie "Diesel S500 - MT (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112PA2OAML" serie "Diesel S500 - PA (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112PB2OAML" serie "Diesel S500 - PB (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112PE2OAML" serie "Diesel S500 - PE (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112PI2OAML" serie "Diesel S500 - PI (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112PR2OAML" serie "Diesel S500 - PR (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112RJ2OAML" serie "Diesel S500 - RJ (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112RN2OAML" serie "Diesel S500 - RN (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112RO2OAML" serie "Diesel S500 - RO (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112RR2OAML" serie "Diesel S500 - RR (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112RS2OAML" serie "Diesel S500 - RS (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112SC2OAML" serie "Diesel S500 - SC (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112SE2OAML" serie "Diesel S500 - SE (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112SP2OAML" serie "Diesel S500 - SP (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0112TO2OAML" serie "Diesel S500 - TO (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165000OAML" serie "Diesel S10 Nacional (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165AC2OAML" serie "Diesel S10 AC (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165AL2OAML" serie "Diesel S10 AL (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165AM2OAML" serie "Diesel S10 AM (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165AP2OAML" serie "Diesel S10 AP (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165BA2OAML" serie "Diesel S10 BA (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165CE2OAML" serie "Diesel S10 CE (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165CO1OAML" serie "Diesel S10 Região Centro-oeste (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165DF2OAML" serie "Diesel S10 DF (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165ES2OAML" serie "Diesel S10 ES (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165GO2OAML" serie "Diesel S10 GO (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165MA2OAML" serie "Diesel S10 MA (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165MG2OAML" serie "Diesel S10 MG (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165MS2OAML" serie "Diesel S10 MS (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165MT2OAML" serie "Diesel S10 MT (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165NE1OAML" serie "Diesel S10 Região Nordeste (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165NO1OAML" serie "Diesel S10 Região Norte (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165PA2OAML" serie "Diesel S10 PA (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165PB2OAML" serie "Diesel S10 PB (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165PE2OAML" serie "Diesel S10 PE (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165PI2OAML" serie "Diesel S10 PI (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165PR2OAML" serie "Diesel S10 PR (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165RJ2OAML" serie "Diesel S10 RJ (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165RN2OAML" serie "Diesel S10 RN (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165RO2OAML" serie "Diesel S10 RO (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165RR2OAML" serie "Diesel S10 RR (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165RS2OAML" serie "Diesel S10 RS (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165SC2OAML" serie "Diesel S10 SC (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165SE1OAML" serie "Diesel S10 Região Sudeste (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165SE2OAML" serie "Diesel S10 SE (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165SP2OAML" serie "Diesel S10 SP (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165SU1OAML" serie "Diesel S10 Região Sul (R$/L)" value and "ANP" font
		And it should be possible check "BRPRC0165TO2OAML" serie "Diesel S10 TO (R$/L)" value and "ANP" font
		
	@SANITY	
	Scenario: Check the Resinas e Pigmentos Series
		When click "Resinas e Pigmentos" in Indicadores menu
		Then it should be possible check "WDPRC0272000OOML" serie "Pigmentos (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0272000OOMM" serie "Pigmentos (Variação %)" value and "Receita Federal" font
		And it should be possible check "WDPRC0281000OOML" serie "Resinas Fenólicas e Ureicas (US$/Kg líquido)" value and "Receita Federal" font
		And it should be possible check "WDPRC0281000OOMM" serie "Resinas Fenólicas e Ureicas (Variação %)" value and "Receita Federal" font

	@SANITY
	Scenario: Check the Saúde Series
		When click "Saúde" in Indicadores menu
		Then it should be possible check "BRPRC0263000OOYL" serie "Reajuste Planos de Saúde (Var. Anual %)" value and "ANS" font
		And it should be possible check "BRPRC0262000OOMY" serie "VCMH (Var. Interanual %)" value and "IESS" font
		And it should be possible check "BRPRC0353000OOMM" serie "VCO (Var. Mensal %)" value and "IBGE" font
		And it should be possible check "BRPRC0242000OOMM" serie "IPC-Fipe Saúde (Variação %)" value and "Fipe" font