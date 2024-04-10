import utils from '../utils'
import assertion from '../../utils/assertions'
const Utils = new utils
const Assertion = new assertion

class projects {

	getProjectId(project) {
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

	createDuplicateProjects(projectid, user, status) {

		cy.get(projectid).then(id => {
			var user_browser
			if (user == 'admin') {
				user_browser = Cypress.env('admin_user')
			}
			else if (user == 'view') {
				user_browser = Cypress.env('view_user')
			}
			else user_browser = user
			var body_request = {
				"to": [user_browser],
				"force": true
			}
			var url_request = '/api/v1/projects/' + id + '/duplicate'

			var auth_request = 'Bearer ' + window.localStorage.getItem('accessToken')
			var status_code = 200
			if (status == "not found") {
				url_request = '/api/v1/projects/' + id + '/duplicateee'
				status_code = 404
			}
			else if (status == "bad request") {
				status_code = 400
			}
			else if (status == "forbidden") {
				auth_request = ""
				status_code = 403
			}
			else if (status == "bad request 2") {
				body_request = {
					"to": [],
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

	searchProjectID(projectName) {
		var url_request = `/api/v1/projects?project_name=` + projectName
		var auth_request = 'Bearer ' + window.localStorage.getItem('accessToken')
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
				if (response.body.records[index].status == "success" || response.body.records[index].status == "partial_success") {
					cy.wrap(response.body.records[index].id).as('projectID')
					foundProject = true
					break
				}
				else if (foundProject != true)
					cy.wrap(response.body.records[0].id).as('projectID_NotFinished')
			}
		})
	}

	compareProjectTime(projectName, projectId) {
		var url_request = `/api/v1/projects?project_name=` + projectName+'&limit=0'
		var auth_request = 'Bearer ' + window.localStorage.getItem('accessToken')
		var body_request = ''

		Utils.legacyDefaultAPIConfig(
			'GET',
			url_request,
			body_request,
			auth_request
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(200);
			
	        // Verifica se o arquivo JSON já existe
	        cy.readFile(`cypress/project-time/project_times_${Cypress.env('tag')}.json`).then((existingData) => {
				let projectData = existingData;
				const retry = Cypress.currentRetry
				const actualTime = new Date().toJSON().slice(0, 19);
				const release = Cypress.env('release');
				for (let index = 0; index < response.body.records.length; index++) {
					if (response.body.records[index].id == projectId) {
						if (response.body.records[0].status == "success" || response.body.records[0].status == "partial_success") {
							const actualTimeProject = new Date(response.body.records[0].last_updated).getTime() - new Date(response.body.records[0].created).getTime();
							const baselineTimeProject = new Date(response.body.records[index].last_updated).getTime() - new Date(response.body.records[index].created).getTime();
							let result = 'Actual Project(min): ' + (actualTimeProject / (1000 * 60)) + ' is less than ' + 'Baseline Project: ' + (baselineTimeProject / (1000 * 60)) + '(min)' + ' + Tolerance (min): ' + parseInt(Cypress.env('project_time_tolerance_minutes')) + ' = ' + ((baselineTimeProject / (1000 * 60)) + parseInt(Cypress.env('project_time_tolerance_minutes')));
							cy.task('printLogs', result);
							// Checando se á existe o projeto no arquivo
							if (!projectData[projectName]) {
								projectData[projectName] = {};
							}

							if (!projectData[projectName][release]) {
								projectData[projectName][release] = [];
							}
							projectData[projectName][release].push({
								date: actualTime,
                            	status: response.body.records[0].status,
                            	id: response.body.records[0].id,
                            	time: actualTimeProject / (1000 * 60)
							});
			
							// Convertendo o objeto JavaScript de volta para uma string JSON
							const jsonData = JSON.stringify(projectData, null, 2);
							if(retry == 0){
								cy.writeFile(`cypress/project-time//project_times_${Cypress.env('tag')}.json`, jsonData).then(() => {
									Assertion.compareInfo((actualTimeProject / (1000 * 60)), 'less than', ((baselineTimeProject / (1000 * 60)) + parseInt(Cypress.env('project_time_tolerance_minutes'))));
								});
							}
							else Assertion.compareInfo((actualTimeProject / (1000 * 60)), 'less than', ((baselineTimeProject / (1000 * 60)) + parseInt(Cypress.env('project_time_tolerance_minutes'))));
						} else {
							// Checando se á existe o projeto no arquivo
							if (!projectData[projectName]) {
								projectData[projectName] = {};
							}
							if (!projectData[projectName][release]) {
								projectData[projectName][release] = [];
							}
							projectData[projectName][release].push({
								date: actualTime,
                            	status: "Not finished",
                            	id: response.body.records[0].id,
                            	time: null
							});
			
							// Convertendo o objeto JavaScript de volta para uma string JSON
							const jsonData = JSON.stringify(projectData, null, 2);
							if(retry == 1){
								cy.writeFile(`cypress/project-time//project_times_${Cypress.env('tag')}.json`, jsonData).then(() => {
									throw Error('Modelling not finished!');
								});
							}
							else throw Error('Modelling not finished!');
						}
					}
				}
			});
		})
	}
}
export default projects;