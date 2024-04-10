/// <reference types="Cypress" />

import utils from '../../pageobjects/utils'
import utilsAPI from '../utils'

const Utils = new utils
const UtilsAPI = new utilsAPI
class domainsAPI {

	getDomains(status){

		var url_request = `/api/v1/domains?language=en-us`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/domainsS`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}

		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request,
			'',
			auth_request
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
		})   
	}
}
export default domainsAPI;