/// <reference types="Cypress" />

import utils from '../../utils'
const Utils = new utils

class AISelectionAPI {

	getBusinessVariables(transformation, frequency, projectID, forecast, variable) {
		const endpoint = `${Cypress.env('apiBaseUrl')}/api/v1/projects/${projectID}/${forecast}/models/business/variables/${variable}?frequency=${frequency}&transformation=${transformation}`
		const token = `Bearer ${window.localStorage.getItem('accessToken')}`

		return cy.api({
			method: 'GET',
			url: endpoint,
			headers: {
				'Authorization': token
			},
			failOnStatusCode: false,
			timeout: 300000
		})
	}
}

export default new AISelectionAPI;