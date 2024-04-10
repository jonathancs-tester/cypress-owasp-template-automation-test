import loginElements from '../elements/login'
const LoginElements = new loginElements
const totp = require("totp-generator");

class login4CastHub {

	auth0Login(userType, loginMode) {
		cy.task('existFile', 'cypress/auth-token/auth-' + Cypress.env('browser') +'-'+ Cypress.env('device') + '/'+userType+'.json').then((exist) => {
			if (exist == true) {
				cy.readFile('cypress/auth-token/auth-' + Cypress.env('browser') +'-'+ Cypress.env('device') + '/'+userType+'.json').then((user) => {
					Object.keys(user).forEach(key => {
						window.localStorage.setItem(key, user[key])
					})
					cy.log('Login from file')
				});
			}
			else if ((window.localStorage.getItem('client_id') == null) || (window.localStorage.getItem('client_id') != Cypress.env('auth_client_id') 
			|| (window.localStorage.getItem('user') != Cypress.env(userType+'_user')))) {
				cy.session([userType], () => {
					if (loginMode == 'MFA')
						cy.clearLocalStorage().loginMFAAuth0(Cypress.env(userType+'_user'),Cypress.env(userType+'_pwd'),Cypress.env(userType+'_otp'))
					else if (loginMode == 'API' || loginMode == 'DEV') 
						cy.clearLocalStorage().loginAuth0(Cypress.env(userType+'_user'),Cypress.env(userType+'_pwd'))
					else if (loginMode =='M2M')
						cy.clearLocalStorage().loginM2MAuth0(Cypress.env(userType+'_client_secret'))
				});
			}
			cy.task('existFile', 'cypress/html-info/html-info-' + Cypress.env('browser') + '/html-info.json').then((exist) => {
				if (!exist) {
					const myVars = {
						OS_VERSION: Cypress.env('os_version'),
						BROWSER_VERSION: Cypress.env('browser_version'),
						BASEURLREPORT: Cypress.config().baseUrl
					};
					const data = JSON.stringify(myVars);
					cy.writeFile('cypress/html-info/html-info-' + Cypress.env('browser') + '/html-info.json', data)
				}
			});
		})
	}

	accessMainPage(){
		cy.visit('/')
	}

	checkProject(user, project) {
		if(user=='admin'){
			if(project=='Models'){
				cy.get(LoginElements.faasAccessButton()).should('have.attr', 'href', '/models/projects')
			}
			else if (project=='Feature Store'){
				cy.get(LoginElements.featureStoreButton()).should('have.attr', 'href', '/feature-store/indicators')
				cy.get(LoginElements.featureStoreAdminButton()).should('have.attr', 'href', '/feature-store/admin')
			}
			else if (project=='Scenarios'){
				cy.get(LoginElements.scenariosButton()).should('have.attr', 'href', '/')
			}
			cy.get(LoginElements.managementAdminButton()).should('have.attr', 'href', '/admin')

		}
		if(user=='view'){
			if(project=='Models'){
				cy.get(LoginElements.faasAccessButton()).should('have.attr', 'href', '/models/projects')
			}
			else if (project=='Feature Store'){
				cy.get(LoginElements.featureStoreButton()).should('have.attr', 'href', '/feature-store/indicators')
				cy.get(LoginElements.projectFeatureStore()).should('not.contain.html', LoginElements.featureStoreAdminButton())
			}
			else if (project=='Scenarios'){
				cy.get(LoginElements.scenariosButton()).should('have.attr', 'href', '/')
			}
			cy.get('body').should('not.contain.html', LoginElements.managementAdminButton())
		}
	}

	checkProjectBlock(user, project){
		if(user=='view'){
			if(project=='Models'){
				cy.get(LoginElements.faasAccessButton()).should('not.have.attr', 'href', '/models/projects')
			}
			else if (project=='Feature Store'){
				cy.get(LoginElements.featureStoreButton()).should('have.attr', 'href', '/feature-store/indicators')
				cy.get(LoginElements.projectFeatureStore()).should('not.contain.html', LoginElements.featureStoreAdminButton())
			}
			else if (project=='Scenarios'){
				cy.get(LoginElements.scenariosButton()).should('have.attr', 'href', '/')
			}
			cy.get('body').should('not.contain.html', LoginElements.managementAdminButton())
		}
	}

	generateOTP(userType){
		var otp_timestamp = Date.now()
		cy.log(`OTP timestamp: `+otp_timestamp)
		if(userType=='admin'){
			var otp = totp(Cypress.env('admin_otp'), { timestamp: otp_timestamp})
			cy.log(`OTP: `+otp)
		}
		if(userType=='manager'){
			var otp = totp(Cypress.env('manager_otp'), { timestamp: otp_timestamp})
			cy.log(`OTP: `+otp)		
		}
		if(userType=='manager_without_project'){
			var otp = totp(Cypress.env('manager_without_project_otp'), { timestamp: otp_timestamp})
			cy.log(`OTP: `+otp)		
		}
		if(userType=='editor'){
			var otp = totp(Cypress.env('editor_otp'), { timestamp: otp_timestamp})
			cy.log(`OTP: `+otp)		
		}
		else if(userType=='view'){
			var otp = totp(Cypress.env('view_otp'), { timestamp: otp_timestamp})
			cy.log(`OTP: `+otp)
		}
		return otp
	}

	initialPage(){
		cy.clearLocalStorage().visit('/')
		cy.get(LoginElements.initialButton()).contains('SIGN IN').click()
	}

	loginUI(userType, usernameField, passwordField, signInButton, mfaButton, otp) {
		const args = { userType, usernameField, passwordField, signInButton, mfaButton, otp }
		cy.origin('4intelligence.us.auth0.com', { args }, ({ userType, usernameField, passwordField, signInButton, mfaButton, otp }) => {
			cy.get(usernameField).type(Cypress.env(userType+'_user'),{log:false})
			cy.get(passwordField).type(Cypress.env(userType+'_pwd'),{log:false})
			cy.get(signInButton).click()
			cy.get(mfaButton).type(otp,{log:false})
			cy.get(signInButton).contains('Continuar').click()
		})
		cy.window().then((win) => {
			win.localStorage.setItem('user', userType);
		})
	}

	accessAppMenu(application){
		if (application == 'Models')
			cy.get(LoginElements.faasAccessMenu()).click()
		else if (application == 'Feature Store')
			cy.get(LoginElements.featureStoreMenu()).click()
	}

	accessApplication(application){
		cy.get(LoginElements.logoutButton()).should('be.visible')
		cy.get('[type=button]').contains('Accept cookies').then($accept => {
			if ($accept.is(':visible')) {
				cy.get('[type=button]').contains('Accept cookies').click()
			}
		});
		if(application == 'Models')
			cy.get(LoginElements.faasAccessButton()).click()
		else if (application == 'Feature Store'){
			cy.intercept('GET', 'api/v1/groups**').as('waitGroups')
			cy.intercept('GET', 'api/v1/indicators**').as('indicatorsTable')
			cy.get(LoginElements.featureStoreButton()).click()
		}
		else if (application == '4CastHub Management')
			cy.get(LoginElements.managementAdminButton()).click()
		else if (application == 'Feature Store Admin'){
			cy.intercept('GET',  'api/v1/indicators**').as('indicatorsTable')
			cy.get(LoginElements.featureStoreAdminButton()).click()
		}
		else if (application == 'Access groups')
			cy.get(LoginElements.accessGroupsButton()).click()
	}

	notExistsAdminButton() {
		cy.get(LoginElements.managementAdminButton()).should('not.exist')
	}

	accessScenariosTab(tab) {
		cy.intercept('GET','**/news/**').as('waitNews')

		if (tab == 'Destaques') {
			cy.visit('/')
		}

		if (tab == 'Politica') {
			cy.visit('/cenario/politica')
		}

		if (tab == 'EUA') {
			cy.visit('/cenario/internacional/eua')
		}

		if (tab == 'UE') {
			cy.visit('/cenario/internacional/ue')
		}

		if (tab == 'China') {
			cy.visit('/cenario/internacional/china')
		}

		if (tab == 'PIB Regional') {
			cy.visit('/cenario/conjuntura/pib-regional')
		}

		if (tab == 'Industria') {
			cy.visit('/cenario/conjuntura/industria')
		}

		if (tab == 'Emprego') {
			cy.visit('/cenario/conjuntura/emprego')
		}

		if (tab == 'Varejo') {
			cy.visit('/cenario/conjuntura/varejo')
		}

		if (tab == 'Credito') {
			cy.visit('/cenario/conjuntura/credito')
		}

		if (tab == 'Inflacao') {
			cy.visit('/cenario/conjuntura/inflacao')
		}

		if (tab == 'Monetaria') {
			cy.visit('/cenario/conjuntura/monetaria')
		}

		if (tab == 'Fiscal') {
			cy.visit('/cenario/conjuntura/fiscal')
		}

		if (tab == 'Externo') {
			cy.visit('/cenario/conjuntura/externo')
		}

		if (tab == 'PIB Regional') {
			cy.visit('/cenario/pib-regional')
		}

		if (tab == 'Projeções') {
			cy.visit('/cenario/projecoes')
		}

		if (tab == 'Calendário') {
			cy.intercept('GET', '**/v4/spreadsheets/**').as('getCalendarValues')
			cy.visit('/cenario/calendario')
		}

		if(tab =! 'Calendário')
			cy.wait('@waitNews', {timeout:180000})
	}

	accessFeatureStoreTab(tab) {
		if (tab == 'Geral') {
			cy.visit('/feature-store/geral')
		}

		if (tab == 'Agropecuário') {
			cy.visit('/feature-store/agropecuario')
		}

		if (tab == 'Consumo') {
			cy.visit('/feature-store/consumo')
		}

		if (tab == 'Crédito') {
			cy.visit('/feature-store/credito')
		}

		if (tab == 'Infraestrutura') {
			cy.visit('/feature-store/infraestrutura')
		}

		if (tab == 'Saúde') {
			cy.visit('/feature-store/saude')
		}

		if (tab == 'Trabalho, Produção de Bens e Serviços') {
			cy.visit('/feature-store/trabalho')
		}

		if (tab == 'Emprego') {
			cy.visit('/cenario/conjuntura/emprego')
		}

		if (tab == 'Transporte') {
			cy.visit('/feature-store/transporte')
		}
	}

	accessIndicadoresTab(tab) {
		if (tab == 'Inflação') {
			cy.visit('/indicadores/inflacao')
		}

		if (tab == 'Câmbio') {
			cy.visit('/indicadores/cambio')
		}

		if (tab == 'Petróleo e Derivados') {
			cy.visit('/indicadores/petroleo')
		}

		if (tab == 'Saúde') {
			cy.visit('/indicadores/saude')
		}

		if (tab == 'Minérios') {
			cy.visit('/indicadores/minerios')
		}

		if (tab == 'Resinas e Pigmentos') {
			cy.visit('/indicadores/resinas-pigmentos')
		}

		if (tab == 'Energia') {
			cy.visit('/indicadores/energia')
		}

		if (tab == 'Celulose, Papel e Tecidos') {
			cy.visit('/indicadores/celulose-papel-tecidos')
		}

		if (tab == 'Carbono e derivados') {
			cy.visit('/indicadores/carbono')
		}

		if (tab.includes('Cestas')) {
			if(tab.includes('GE'))
				cy.visit('/indicadores/cestas/ge')
			if(tab.includes('Dissidios'))
				cy.visit('/indicadores/cestas/dissidios-ge')
			if(tab.includes('Compras Tecnicas'))
				cy.visit('/indicadores/cestas/compras-tecnicas')
			if(tab.includes('Transportes'))
				cy.visit('/indicadores/cestas/transportes')
		}

		if (tab == 'Dissídios - Limpeza e Conservação') {
			cy.visit('/indicadores/dissidios-limpeza-conservacao')
		}

		if (tab == 'Dissídios - Portaria e Vigilância') {
			cy.visit('/indicadores/dissidios-portaria-vigilancia')
		}

		if (tab == 'Dissídios - Restaurante') {
			cy.visit('/indicadores/dissidios-restaurante')
		}

		if (tab == 'Dissídios - Motorista') {
			cy.visit('/indicadores/dissidios-motorista')
		}

		if (tab == 'Diesel') {
			cy.visit('/indicadores/diesel')
		}

		if (tab == 'Outros') {
			cy.visit('/indicadores/outros')
		}
	}

	checkPage(page){
		cy.url().should('contain', page)
	}
}
export default login4CastHub;
