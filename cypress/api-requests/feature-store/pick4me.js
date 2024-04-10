/// <reference types="Cypress" />

import utils from '../../utils/generateInfo'
import utilsAPI from '../utils'

const Utils = new utils
const UtilsAPI = new utilsAPI
class pick4meApi {

	//201
	createFeatures(body_type){
		cy.readFile('cypress/fixtures/feature-store/'+body_type).then((body_text)=> {
			UtilsAPI.legacyDefaultAPIConfig(
				'POST',
				`/api/v1/features?skip=0&limit=10&language=en-us`,
				{body:body_text},
				'Bearer '+window.localStorage.getItem('accessToken'),
				'pick4Me',
				'application/x-www-form-urlencoded'
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(200);
			})
		})
	}

	createNewGroup(group){
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			`/api/v1/groups?language=en-us`,
			{
				"name": Utils.concatVariable(group),
				"icon_url": "https://icon.com",
				"is_predefined": false
			},
			'Bearer '+window.localStorage.getItem('accessToken')
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(200);
		})
	}

    

}
export default pick4meApi;

