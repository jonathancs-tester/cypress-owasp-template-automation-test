/* global Given, Then, When */

import login4CastHub from '../components/login'
import loginElements from '../elements/login'
const Login4CastHub = new login4CastHub
const LoginElements = new loginElements

const {
	Given
} = require("cypress10-cucumber-preprocessor/steps");

Given("insert {string} credentials and login via {string}", (userType, loginMode) => {
	if (loginMode == 'UI') {
		if(window.localStorage.getItem('user') != userType){
			var otp = Login4CastHub.generateOTP(userType);
			Login4CastHub.initialPage()
			Login4CastHub.loginUI(userType, LoginElements.emailTextField(), LoginElements.passwordTextField(),
				LoginElements.signInButton(), LoginElements.mfaCode(), otp)
		} 
		else
			cy.visit('/')
	}

	else
		Login4CastHub.auth0Login(userType, loginMode);

	cy.saveLocalStorage(userType);
})