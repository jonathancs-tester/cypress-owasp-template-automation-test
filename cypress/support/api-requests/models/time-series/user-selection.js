/// <reference types="Cypress" />

import utils from '../../utils'
const Utils = new utils

class productionAPI {

	applySimulation(forecast, year, variables, values, status) {
		cy.get('@firstProjectId').then((firstProjectId) => {
			var endpont = '/api/v1/projects/' + firstProjectId + '/' + forecast + '/model-in-production/apply_simulation'
			var auth_request = 'Bearer ' + window.localStorage.getItem('accessToken')
			var status_code = 200
			var var_final = []
			var values_final = []
			const variable = variables.split(',')
			for (let index = 0; index < variable.length; index++) {
				var_final.push('"' + variable[index] + '"')
			}
			const value = values.split(',')
			for (let index = 0; index < value.length; index++) {
				values_final.push(parseInt(value[index]))
			}
			var body = {
				"year": year,
				"variables": var_final,
				"values": values_final
			}

			if (status == "not found") {
				status_code = 404
			}
			else if (status == "bad request") {
				status_code = 400
			}
			else if (status == "forbidden") {
				auth_request = ""
				status_code = 403
			}
			Utils.legacyDefaultAPIConfig(
				'POST',
				endpont,
				body,
				auth_request
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})
		})
	}

	getBusinessVariables(projectID, forecast) {
		const endpoint = `${Cypress.env('apiBaseUrl')}/api/v1/projects/${projectID}/${forecast}/model-in-production/monthly_series`
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

export default productionAPI;