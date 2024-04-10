/// <reference types="Cypress" />

import utils from '../../utils'

const Utils = new utils
class partialError {

	requestPartialError(fileName, status){

		cy.fixture('/time-series/'+fileName, "utf-8").then(file_test => {
             
			var body = {
				"body": file_test,
				"skip_validation": true
			}
			var url_request = `/api/v1/projects`
			var status_code = 200 

			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
        
			if(status == "not found"){
				url_request = `/api/v1/groupss/`
				status_code = 404
			}
			else if(status == "unauthorized"){
				auth_request = ""
				status_code = 403
			}
			else if(status == "bad request"){
				body = {}
				status_code = 400
			}
			Utils.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body,
				auth_request
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})                   
		})
	}       
}
export default partialError;