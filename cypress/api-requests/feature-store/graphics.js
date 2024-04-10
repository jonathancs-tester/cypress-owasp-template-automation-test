import utilsAPI from '../utils'

const UtilsAPI = new utilsAPI
class graphicsAPI {

	checkObservations(indicator, serie, status){

		var url_request = `/api/v1/indicators/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/indicatorss/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}

		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request+indicator+'/series/'+serie+'/observations?limit=0&language=en-us',
			'',
			auth_request
		)
		cy.get('@responseBody').then(response => {
			cy.wrap(response).as('observationResponse')
			expect(response.status).to.equal(status_code);
		})   
	}

	checkProjections(indicator, serie, status){

		var url_request = `/api/v1/indicators/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}

		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request+indicator+'/series/'+serie+'/projections?limit=0',
			'',
			auth_request
		)
		cy.get('@responseBody').then(response => {
			cy.wrap(response).as('projectedResponse')
			expect(response.status).to.equal(status_code);
		})   
	}
}
export default graphicsAPI;