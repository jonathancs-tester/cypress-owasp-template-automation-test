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
					if (loginMode == 'MFA'){
						cy.clearLocalStorage()
						cy.loginMFAAuth0(Cypress.env(userType+'_user'),Cypress.env(userType+'_pwd'),Cypress.env(userType+'_otp'))
					}
					else if (loginMode == 'API' || loginMode == 'DEV') {
						cy.clearLocalStorage()
						cy.loginAuth0(Cypress.env(userType+'_user'),Cypress.env(userType+'_pwd'))

					}
					else if (loginMode =='M2M'){
						cy.clearLocalStorage()
						cy.loginM2MAuth0(Cypress.env(userType+'_client_secret'))
					}
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
		cy.clearLocalStorage()
		cy.visit('/')
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
}
export default login4CastHub;
