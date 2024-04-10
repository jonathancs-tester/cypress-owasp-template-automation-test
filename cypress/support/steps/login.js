/* global Given, Then, When */

import login4CastHub from '../pageobjects/login'
import loginElements from '../elements/login'
const Login4CastHub = new login4CastHub
const LoginElements = new loginElements

const {
	Given,
	Then
} = require("cypress10-cucumber-preprocessor/steps");

When("insert {string} credentials and login via {string}", (userType, loginMode) => {
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

Given("access {string} tab", (tab) => {
	Login4CastHub.accessScenariosTab(tab);
})

Given("access main page", () => {
	Login4CastHub.accessMainPage();
})

Given("access {string} app menu", (app) => {
	Login4CastHub.accessAppMenu(app);
})

And("access {string} application", (application) => {
	Login4CastHub.accessApplication(application);
})

When("click {string} in Feature Store menu", (menu) => {
	Login4CastHub.accessFeatureStoreTab(menu)
})

When("click {string} in Indicadores menu", (menu) => {
	Login4CastHub.accessIndicadoresTab(menu)
})

Then("it should be possible to access the {string} with {string} user", (project, user) => {
	Login4CastHub.checkProject(user, project)
})

Then("it should not be possible to access the {string} with {string} user", (project, user) => {
	Login4CastHub.checkProjectBlock(user, project)
})

Then("it should not be possible to acess admin management", () => {
	Login4CastHub.notExistsAdminButton();
})

When("click in {string} Admin menu", (project) => {
	Login4CastHub.accessFSadminMenu(project);
})

Then("the page should be redirect to {string} modeling page", (page) => {
	Login4CastHub.checkPage(page);
})