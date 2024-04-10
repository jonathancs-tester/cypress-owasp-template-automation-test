import utils from '../utils'
const Utils = new utils

class projects{

	getProjectId(project){
		var endpoint = `/api/v1/projects?project_name=${project}&y_series=${project}&skip=0&limit=8`
		var token = `Bearer ${window.localStorage.getItem('accessToken')}`
		var status_code = 200

		Utils.legacyDefaultAPIConfig(
			'GET',
			endpoint,
			'',
			token  
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
			cy.wrap(response.body.records[0].id).as('firstProjectId')	
		})
	}

	putProjectOverviewColumns(requestBody){
		cy.get('@firstProjectId').then((firstProjectId) => {
			var endpont = '/api/v1/projects/'+firstProjectId+'/overview/columns'
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			if(requestBody == ''){
				var body = {
					"columns": []
				}
			} 
			else {
				var body = {
					"columns": [requestBody]
				}
			}

			Utils.legacyDefaultAPIConfig(
				'PUT',
				endpont,
				body,
				auth_request  
			)
		})
	}

	checkProjectResponseBody(status,responseBody){
		var status_code = 200

		if(status == "Not Found"){
			status_code = 404
		}
		else if(status == "Bad Request"){
			status_code = 400
		}	
		else if(status == "Forbidden"){
			status_code = 403
		}

		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
			if(status_code == 200)
				expect(response.body.overview.columns).to.contains(responseBody);
			else 
				expect(response.body.detail[0].msg).to.contains(responseBody);
		})
	}

	downloadProjects(id, status){
		var endpont = '/api/v1/projects/'+id+'/download'
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var status_code = 200

		if(status == "not found"){
			status_code = 404
		}
		else if(status == "bad request"){
			status_code = 400
		}	
		else if(status == "forbidden"){
			auth_request = ""
			status_code = 403
		}
		Utils.legacyDefaultAPIConfig(
			'GET',
			endpont,
			'',
			auth_request  
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
		})
	}

	createDuplicateProjects(projectid, user, status){
		
		cy.get(projectid).then(id => {
			var user_browser
			if(user == 'admin'){
				user_browser = Cypress.env('admin_user')
			}
			else if(user == 'view'){
				user_browser = Cypress.env('view_user')
			}
			else user_browser = user
			var body_request = {
				"to": [ user_browser ]
			}
			var url_request = '/api/v1/projects/'+id+'/duplicate'
			
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			var status_code = 200
			if(status == "not found"){
				url_request = '/api/v1/projects/'+id+'/duplicateee'
				status_code = 404
			}
			else if(status == "bad request"){
				status_code = 400
			}	
			else if(status == "forbidden"){
				auth_request = ""
				status_code = 403
			}
			else if(status == "bad request 2"){
				body_request = {
					"to": [   ],
				}
				status_code = 400
			}
			Utils.legacyDefaultAPIConfig(
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

	searchProjectID(projectName){
		var url_request = `/api/v1/projects?project_name=`+projectName
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var body_request = ''
		var foundProject = false

		Utils.legacyDefaultAPIConfig(
			'GET',
			url_request,
			body_request,
			auth_request
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(200);
			for (let index = 0; index < response.body.records.length; index++) {
				if(response.body.records[index].status == "success" || response.body.records[index].status == "partial_success"){
					cy.wrap(response.body.records[index].id).as('projectID')
					foundProject = true
					break
				}
				else if (foundProject != true)
					cy.wrap(response.body.records[0].id).as('projectID_NotFinished')
			}
		})
	}
}
export default projects;