/// <reference types="Cypress" />

import utilsAPI from '../utils'

const UtilsAPI = new utilsAPI

class dataLoader {
    
	deleteAllSeries(indicator){
		var url_request =  '/api/v1/indicators/'+indicator+'/series'
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var body_ok = ''
		
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request,
			body_ok,
			auth_request,
		)
		cy.get('@responseBody').then(response => {
			if(response.status == 200){ 
				for (let index = 0; index < response.body.data.length; index++) {
					url_request =  '/api/v1/indicators/'+indicator+'/series/'+response.body.data[index].code+'?language=en-us'
					UtilsAPI.legacyDefaultAPIConfig(
						'DELETE',
						url_request,
						body_ok,
						auth_request,
					)
				}
			}
		})		
	}

	createSeriesInIndicator(indicator, dataTable){
		const data = dataTable.raw();
		var url_request =  '/api/v1/indicators/'+indicator+'/series?language=en-us'
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		for (let i = 1; i < data.length; i++) {
			const reg = data[i][0];
			const tp = data[i][1];
			const ag = data[i][2];
			const ts = data[i][3];
			var body = {
				"aggregation": ag,
				"region": reg,
				"primary_transformation": tp,
				"second_transformation": ts,
				"unit": { 
					"en-us": "test-qa",
					"pt-br": "teste-qa"
				}
			}
			UtilsAPI.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body,
				auth_request,
			)
		}
	}

	insertDataInNewFlow(){
		cy.readFile('cypress/fixtures/feature-store/data-loader.json').then((body_request) => {
			var url_request = "/api/v1/tasks/indicators"
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			UtilsAPI.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body_request,
				auth_request,
				'data-loader'      // True if de API is data-loader
			)
		})
	}

	checkSeries(indicator, dataTable){
		const data = dataTable.raw();
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var body = ""
		cy.task('pauseTime')
		for (let i = 1; i < data.length; i++) {
			const serie = data[i][0];
			var url_request =  '/api/v1/indicators/'+indicator+'/series/'+serie+'/observations?limit=0&language=en-us'
			UtilsAPI.legacyDefaultAPIConfig(
				'GET',
				url_request,
				body,
				auth_request,
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(200);
				expect(response.body.data.length).greaterThan(0)
			})
		}	
	}

	activeIndicator(indicator){
		var body = {
			"name": {
				"en-us": "Flow test indicator",
				"pt-br": "Indicador de teste do fluxo"
			},
			"short_name": {
				"en-us": "indicator test",
				"pt-br": "indicador de teste"
			},
			"description": {
				"en-us": "Test indicator to validate the new flow",
				"pt-br": "Indicador de teste para validar o fluxo novo"
			},
			"description_full": {
				"en-us": "Test indicator to validate the new flow",
				"pt-br": "Indicador de teste para validar o fluxo novo"
			},
			"country": "BR",
			"source": {
				"en-us": "test",
				"pt-br": "teste"
			},
			"sector": "CRD",
			"access_group": "default",
			"access_type": "default",
			"is_active": true,
			"projections":"teste",
			"tree": [
				{
					"id": "62e2fc21b9489753bb80b2a8",
					"node": "Brazil",
					"name": {
						"en-us": "Brazil",
						"pt-br": "Brasil"
					}
				},
				{
					"id": "62e2fc21b9489753bb80b2cf",
					"node": "Public finance",
					"name": {
						"en-us": "Public finance",
						"pt-br": "Finanças públicas"
					}
				},
				{
					"id": "62e2fc21b9489753bb80b2d0",
					"node": "Income and expenses",
					"name": {
						"en-us": "Income and expenses",
						"pt-br": "Receitas e despesas"
					}
				}
			]
		}
		var url_request = "/api/v1/indicators/"+indicator+"?language=en-us"
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		UtilsAPI.legacyDefaultAPIConfig(
			'PUT',
			url_request,
			body,
			auth_request,
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(200);
		})
	}
}
export default dataLoader;