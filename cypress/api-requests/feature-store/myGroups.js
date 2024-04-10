/// <reference types="Cypress" />

import utils from '../../utils/generateInfo'
import utilsAPI from '../utils'

const Utils = new utils
const UtilsAPI = new utilsAPI
class myGroupsAPI {

	createNewGroup(group){
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			`/api/v1/groups?language=en-us`,
			{
				"name": Utils.concatVariable(group),
				"icon_url": "https://icon.com",
				"is_predefined": false,
				"description": "test-description"
			},
			'Bearer '+window.localStorage.getItem('accessToken')
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(201);
		})
	}

	checkGarbageGroups(groupName){
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			`/api/v1/groups?language=en-us`,
			'',
			'Bearer '+window.localStorage.getItem('accessToken'),
		)
		cy.get('@responseBody').then((response) => {
			for (let index = 0; index < response.body.data.length; index++) {
				if (response.body.data[index].name == Utils.concatVariable(groupName)){
					UtilsAPI.legacyDefaultAPIConfig(
						'DELETE',
						`/api/v1/groups/`+response.body.data[index].id+'?language=en-us',
						'',
						'Bearer '+window.localStorage.getItem('accessToken')
					)
					cy.get('@responseBody').then((responseDelete) => {
						expect(responseDelete.status).to.equal(200);
					})
				}
                
			}
		})
	}

	sequenceGroups(groupName){
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			'/api/v1/groups?language=en-us',
			'',
			'Bearer '+window.localStorage.getItem('accessToken')
		)
		cy.get('@responseBody').then((response) => {
			for (let index = 0; index < response.body.data.length; index++) {
				if (response.body.data[index].name == Utils.concatVariable(groupName)){
					var id_group = response.body.data[index].id
					index = response.body.data.length
				}
			}
			UtilsAPI.legacyDefaultAPIConfig(
				'GET',	
				'/api/v1/groups/'+id_group+'/series?language=en-us',
				'',
				'Bearer '+window.localStorage.getItem('accessToken')
			)
			cy.get('@responseBody').then((response_group) => {
				for (let i = 0; i < ((response_group.body.data.length) - 1); i++) {
					assert.ok(new Date(response_group.body.data[i].last_updated).valueOf() >= new Date(response_group.body.data[i+1].last_updated).valueOf())
				}
			})
		})
	}

	saveId(groupName){
		var idList = []
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			`/api/v1/groups?language=en-us`,
			'',
			'Bearer '+window.localStorage.getItem('accessToken')
		)
		cy.get('@responseBody').then((response) => {
			for (let index = 0; index < response.body.data.length; index++) {
				if (response.body.data[index].name == Utils.concatVariable(groupName)){
					idList.push(response.body.data[index].id)
				}
			}
			cy.wrap(idList).as("groupId")
		})
	}

	editGroup(newName, status){

		var url_request = `/api/v1/groups/`
		var status_code = 200
		var body_request = {
			"name": Utils.concatVariable(newName),
			"icon_url": "https://icon.com",
			"is_predefined": false
		}
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/groupss/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		else if(status == "bad request"){
			body_request = {}
			status_code = 400
		}

		cy.get('@groupId').then($groupId => {
			for (let index = 0; index < $groupId.length; index++) {
				UtilsAPI.legacyDefaultAPIConfig(
					'PUT',                              
					url_request+$groupId[index]+'?language=en-us',   
					body_request,
					auth_request
				)
				cy.get('@responseBody').then(response => {
					expect(response.status).to.equal(status_code);
				})
			}
		})     
	}

	insertSerie(serie, status){
		var url_request = `/api/v1/groups/`
		var status_code = 200
		var body_request = {
			"series": [serie],
		}
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/groupss/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		else if(status == "bad request"){
			body_request = {}
			status_code = 400
		}

		cy.get('@groupId').then($groupId => {
			for (let index = 0; index < $groupId.length; index++) {
				UtilsAPI.legacyDefaultAPIConfig(
					'PATCH',                              
					url_request+$groupId[index]+'/series?language=en-us',   
					body_request,
					auth_request
				)
				cy.get('@responseBody').then(response => {
					expect(response.status).to.equal(status_code);
				})
			}
		})
	}

	deleteSerie(serie, status){
		var url_request = `/api/v1/groups/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/groupss/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}

		cy.get('@groupId').then($groupId => {
			for (let index = 0; index < $groupId.length; index++) {
				UtilsAPI.legacyDefaultAPIConfig(
					'DELETE',                              
					url_request+$groupId[index]+'/series/'+serie+'?language=en-us',   
					'',
					auth_request
				)
				cy.get('@responseBody').then(response => {
					expect(response.status).to.equal(status_code);
				})
			}
		})
	}

	searchSeries(serie, status){
		var url_request = `/api/v1/groups/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/groupss/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}

		cy.get('@groupId').then($groupId => {
			for (let index = 0; index < $groupId.length; index++) {
				UtilsAPI.legacyDefaultAPIConfig(
					'GET',                              
					url_request+$groupId[index]+'/series?language=en-us',   
					'',
					auth_request
				)
				cy.get('@responseBody').then(response => {
					expect(response.status).to.equal(status_code);
					if(status == "success")
						expect(response.body.data[0].code).to.equal(serie);
				})
			}
		})
	}

	downloadSeries(status, file){
		var url_request = `/api/v1/groups/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/groupss/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}

		cy.get('@groupId').then($groupId => {
			for (let index = 0; index < $groupId.length; index++) {
				UtilsAPI.legacyDefaultAPIConfig(
					'GET',                              
					url_request+$groupId[index]+'/download/'+file+'?language=en-us',   
					'',
					auth_request
				)
				cy.get('@responseBody').then(response => {
					expect(response.status).to.equal(status_code);
				})
			}
		})
	}
}
export default myGroupsAPI;