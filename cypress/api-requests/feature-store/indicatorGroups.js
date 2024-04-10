import utilsAPI from '../utils'

const UtilsAPI = new utilsAPI

class indicatorsGroups {
	createNewGroup(groupAccess){
		var body_request = {
			"name": {
				"pt-br": "teste grupo de indicadores 1",
				"en-us": "indicators groups test 1"
			},
			"description": {
				"pt-br": "teste descrição",
				"en-us": "description test delete"
			},
			"access_type": groupAccess,
			"icon_url": "teste"
		}
		var url_request = `/api/v1/access-groups?language=en-us`
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var status_code = 201
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			url_request,
			body_request,
			auth_request
		)
		cy.get('@responseBody').then((response) => {
			if(response.status == 201){
				cy.wrap(response.body.id).as('groupID')
			}
			expect(response.status).to.equal(status_code);
		})
	}

	editNewGroup(groupAccess){
		cy.get("@groupID").then(groupID => {
			var body_request = {
				"name": {
					"pt-br": "teste grupo de indicadores 1",
					"en-us": "indicators groups test 1"
				},
				"description": {
					"pt-br": "teste descrição",
					"en-us": "description test delete"
				},
				"access_type": groupAccess,
				"icon_url": "teste"
			}
			var url_request = `/api/v1/access-groups/${groupID}?language=en-us`
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			var status_code = 200
			UtilsAPI.legacyDefaultAPIConfig(
				'PUT',
				url_request,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(status_code);
			})
		})
	}

	insertIndicator(indicator){
		var body_request = {
			"indicator_code": indicator
		}
		cy.get("@groupID").then(groupID => {
			var url_request = `/api/v1/access-groups/${groupID}/indicators`
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			var status_code = 200
			UtilsAPI.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(status_code);
			})
		})
	}

	checkGroup(indicator){
		var body_request = ''
		cy.get("@groupID").then(groupID => {
			var url_request = `/api/v1/access-groups/${groupID}/indicators`
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			var status_code = 200
			UtilsAPI.legacyDefaultAPIConfig(
				'GET',
				url_request,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(status_code);
				expect(response.body.data[0].indicator_code).to.eq(indicator)
			})
		})
	}

	deleteIndicator(indicator){
		var body_request = ''
		cy.get("@groupID").then(groupID => {
			var url_request = `/api/v1/access-groups/${groupID}/indicators/${indicator}`
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			var status_code = 202
			UtilsAPI.legacyDefaultAPIConfig(
				'DELETE',
				url_request,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(status_code);
			})
		})
	}

	insertUser(user){
		var body_request = {
			"email": Cypress.env(user)
		}
		cy.get("@groupID").then(groupID => {
			var url_request = `/api/v1/access-groups/${groupID}/users`
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			var status_code = 201
			UtilsAPI.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(status_code);
				cy.wrap(response.body.id).as('userID')
			})
		})
	}

	deleteUser(){
		var body_request = ''
		cy.get("@groupID").then(groupID => {
			cy.get("@userID").then(userID => {
				var url_request = `/api/v1/access-groups/${groupID}/users/${userID}`
				var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
				var status_code = 202
				UtilsAPI.legacyDefaultAPIConfig(
					'DELETE',
					url_request,
					body_request,
					auth_request
				)
				cy.get('@responseBody').then((response) => {
					expect(response.status).to.equal(status_code);
				})
			})
		})
	}

	checkUserInGroup(user){
		var body_request = ''
		cy.get("@groupID").then(groupID => {
			var url_request = `/api/v1/access-groups/${groupID}/users`
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			var status_code = 200
			UtilsAPI.legacyDefaultAPIConfig(
				'GET',
				url_request,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(status_code);
				expect(response.body.data[0].user).to.eq(Cypress.env(user))
			})
		})
	}

	deleteGarbage(){
		var body_request = ''
		var url_request = `/api/v1/access-groups?limit=0&language=en-us`
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var status_code = 200
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request,
			body_request,
			auth_request
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(status_code);
			for (let index = 0; index < response.body.data.length; index++) {
				if(response.body.data[index].description['en-us'] == "description test delete"){
					UtilsAPI.legacyDefaultAPIConfig(
						'DELETE',
						`/api/v1/access-groups/${response.body.data[index].id}?language=en-us`,
						'',
						auth_request
					)
					cy.get('@responseBody').then(responseDelete => {
						expect(responseDelete.status).to.equal(202);
					})
				}
			}
		})
	}
}
export default indicatorsGroups;