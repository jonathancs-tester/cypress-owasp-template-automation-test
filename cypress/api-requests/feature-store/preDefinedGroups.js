/// <reference types="Cypress" />

import utils from '../../utils/generateInfo'
import utilsAPI from '../utils'
const Utils = new utils
const UtilsAPI = new utilsAPI

class preDefinedAPI {

	createNewGroup(group){
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			`/api/v1/groups?language=en-us`,
			{
				"name": Utils.concatVariable(group),
				"icon_url": "https://icon.com",
				"is_predefined": true,
				"description": "test-description"
			},
			'Bearer '+window.localStorage.getItem('accessToken')
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(201);
		})
	}

	createNewGroup1(group){
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			`/api/v1/groups?language=en-us`,
			{
				"name": Utils.concatVariable(group),
				"icon_url": "https://icon.com",
				"is_predefined": false,
				"failOnStatusCode": false
			},
			'Bearer '+window.localStorage.getItem('accessToken'),
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(201);
		})
	}

	checkGarbageGroups(groupName){
		var integration = Cypress.env('feature')+'_integration'
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			`/api/v1/groups/predefineds?language=en-us`,
			'',
			'Bearer '+window.localStorage.getItem('accessToken'),
			integration	
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(200);
			for (let index = 0; index < response.body.data.length; index++) {
				if ((response.body.data[index].name).includes(groupName)){
					UtilsAPI.legacyDefaultAPIConfig(
						'DELETE',
						'/api/v1/groups/'+response.body.data[index].id+'?language=en-us',
						'',
						'Bearer '+window.localStorage.getItem('accessToken'),
						integration
					)
					cy.get('@responseBody').then((responseDelete) => {
						expect(responseDelete.status).to.equal(200);
					})
				}
			}
		})
	}
}
export default preDefinedAPI;
