// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })
import 'cypress-file-upload';
import jwt_decode from "jwt-decode";
const totp = require("totp-generator");

Cypress.Commands.add("parseXlsx", (inputFile) => {
	return cy.task('parseXlsx', { filePath: inputFile })
});

Cypress.Commands.add("saveLocalStorage", (user) => {
	const data = JSON.stringify(window.localStorage);
	cy.writeFile('cypress/auth-token/auth-' + Cypress.env('browser') +'-'+ Cypress.env('device') + '/'+user+'.json', data)
});

Cypress.Commands.overwrite('clearLocalStorage', (overrides = {}) => {
	window.localStorage.clear();
});

Cypress.Commands.add(
	'loginAuth0', (username, password) => {
		cy.log(`Logging in as ${username}`)
		const client_id = Cypress.env('auth_client_id')
		const audience = Cypress.env('auth_audience')
		const scope = Cypress.env('auth_scope')

		cy.request({
			method: 'POST',
			url: `https://${Cypress.env('auth_domain')}/oauth/token`,
			body: {
				grant_type: 'password',
				username,
				password,
				audience,
				scope,
				client_id,
			},
		}).then(({ body }) => {
			const itemName = `@@auth0spajs@@::${client_id}::${audience}::${scope}`;

			const claims = jwt_decode(body.id_token);
			const {
				nickname,
				name,
				picture,
				updated_at,
				email,
				email_verified,
				sub,
				exp
			} = claims;

			const item = {
				body: {
					...body,
					decodedToken: {
						claims,
						user: {
							nickname,
							name,
							picture,
							updated_at,
							email,
							email_verified,
							sub
						},
						audience,
						client_id
					}
				},
				expiresAt: exp
			};
			window.localStorage.setItem('client_id', client_id);
			window.localStorage.setItem('user', username);
			window.localStorage.setItem(itemName, JSON.stringify(item));
			window.localStorage.setItem('accessToken', item.body.access_token);
			window.localStorage.setItem('i18nextLng', 'en-us');
		});
	});

Cypress.Commands.add(
	'loginM2MAuth0', (client_secret) => {
		cy.log(`Logging in as M2M`)
		const client_id = Cypress.env('auth_client_id')
		const audience = Cypress.env('auth_audience')
		const scope = Cypress.env('auth_scope')

		cy.request({
			method: 'POST',
			url: `https://${Cypress.env('auth_domain')}/oauth/token`,
			body: {
				grant_type: 'client_credentials',
				client_secret,
				audience,
				client_id,
			},
		}).then(({ body }) => {
			const itemName = `@@auth0spajs@@::${client_id}::${audience}::${scope}`;

			const claims = jwt_decode(body.access_token);
			const {
				nickname,
				name,
				picture,
				updated_at,
				email,
				email_verified,
				sub,
				exp
			} = claims;

			const item = {
				body: {
					...body,
					decodedToken: {
						claims,
						user: {
							nickname,
							name,
							picture,
							updated_at,
							email,
							email_verified,
							sub
						},
						audience,
						client_id
					}
				},
				expiresAt: exp
			};
			window.localStorage.setItem('accessToken', body.access_token);
			window.localStorage.setItem(itemName, JSON.stringify(item));
		});
	});

Cypress.Commands.add(
	'loginMFAAuth0', (username, password, otp_token) => {
		cy.log(`Logging in as ${username}`)
		const client_id = Cypress.env('auth_client_id')
		const audience = Cypress.env('auth_audience')
		const scope = Cypress.env('auth_scope')

		cy.request({
			method: 'POST',
			url: `https://${Cypress.env('auth_domain')}/oauth/token`,
			failOnStatusCode: false,
			body: {
				grant_type: 'password',
				username,
				password,
				audience,
				scope,
				client_id,
			},
		}).then((response_mfa_token) => {
			const mfa_token = response_mfa_token.body.mfa_token

			cy.request({
				method: 'POST',
				url: `https://${Cypress.env('auth_domain')}/mfa/associate`,
				failOnStatusCode: false,
				headers: {
					'Content-Type': 'application/json',
					"Authorization": 'Bearer ' + mfa_token,
				},
				body: {
					authenticator_types: ["otp"]
				},
			}).then((response_otp_token) => {
				if ((response_otp_token.body.error_description) == "User is already enrolled.")
					var secret = otp_token
				else
					var secret = response_otp_token.body.secret
				
				var otp_timestamp = Date.now()
				cy.log(`OTP timestamp: `+otp_timestamp)
				const otp = totp(secret, { timestamp: otp_timestamp})
				cy.log(`OTP: `+otp)

				cy.request({
					method: 'POST',
					url: `https://${Cypress.env('auth_domain')}/oauth/token`,
					body: {
						grant_type: 'http://auth0.com/oauth/grant-type/mfa-otp',
						client_id,
						otp,
						mfa_token,
					},
				}).then(({ body }) => {
					const itemName = `@@auth0spajs@@::${client_id}::${audience}::${scope}`;

					const claims = jwt_decode(body.id_token);
					const {
						nickname,
						name,
						picture,
						updated_at,
						email,
						email_verified,
						sub,
						exp
					} = claims;

					const item = {
						body: {
							...body,
							decodedToken: {
								claims,
								user: {
									nickname,
									name,
									picture,
									updated_at,
									email,
									email_verified,
									sub
								},
								audience,
								client_id
							}
						},
						expiresAt: exp
					};
					window.localStorage.setItem('client_id', client_id);
					window.localStorage.setItem('user', username);
					window.localStorage.setItem(itemName, JSON.stringify(item));
					window.localStorage.setItem('accessToken', item.body.access_token);
					window.localStorage.setItem('i18nextLng', 'en-us');
				});
			});
		});
	});