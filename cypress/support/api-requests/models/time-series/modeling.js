/// <reference types="Cypress" />

import utils from '../../utils'

const Utils = new utils
class modeling {

	uploadDataset(dataset, project_name){

		cy.readFile('cypress/fixtures/time-series/'+dataset, 'binary').then((file1) => Cypress.Blob.binaryStringToBlob(file1))
			.then((blob1) => {
				var formData1 = new FormData()
				formData1.set("file", blob1, dataset);
				formData1.set("project_name", project_name)
				formData1.set("icon_url", "\"https://saoseba.blob.core.windows.net/jureia/cc826f11-eed9-4ac7-ad01-08958faf0aae.png\"")

				var url_request = `/api/v1/upload`
				var status_code = 200 

				var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
        
				Utils.legacyDefaultAPIConfig(
					'POST',
					url_request,
					formData1,
					auth_request,
					'modelingAPI'
				)
				
				cy.get('@responseBody').then(response => {
					var ab2str = require('arraybuffer-to-string')
					const stringsDecoded = ab2str(response.body, 'iso-8859-2')
					expect(response.status).to.equal(status_code)
					cy.wrap(stringsDecoded).as('dataset_upload')					
				})                   
			})
	}

	selectVariables(dateFormat){
		cy.get('@dataset_upload').then(dataset_upload => {
			const dataset_obj = JSON.parse(dataset_upload)
			var x_list = dataset_obj.variables.x_options
			
			x_list.splice(x_list.indexOf(dataset_obj.variables.y_options[0]), 1);
			var body = {
				"var_y": dataset_obj.variables.y_options[0],
				"var_x": x_list,
				"date_var": dataset_obj.variables.date_name[0],
				"date_format": dateFormat
			}
			var url_request = `/api/v2/variables/`+dataset_obj.dataset_id
			var status_code = 200 
    
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
            
			Utils.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body,
				auth_request,
				'modelingAPI'
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})                   
		})
	}

	validateDataset(){
		cy.get('@dataset_upload').then(dataset_upload => {
			const dataset_obj = JSON.parse(dataset_upload)
		
			var url_request = `/api/v1/validate/`+dataset_obj.dataset_id
			var status_code = 200 
    
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
            
			Utils.legacyDefaultAPIConfig(
				'GET',
				url_request,
				'',
				auth_request,
				'modelingAPI'
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);

			})                   
		})
	}

	sendModeling(forestValue, crossValue, log, dummies, iCrit, accuracy, cross, avoid, auto_expl, group1, group2, group3, lasso, random, correlation, goldenVar){
		cy.get('@dataset_upload').then(dataset_upload => {
			const dataset_obj = JSON.parse(dataset_upload)
			let log_ok = (log === 'True')
			let dummies_ok = (dummies === 'True')
			let avoid_ok = (avoid === 'True')
			let auto_expl_ok = (auto_expl === 'True')
			let lasso_ok = (lasso === 'True')
			let random_ok = (random === 'True')
			let correlation_ok = (correlation === 'True')
			var exclusions_list = [[],[],[]]
			var goldenVariables = []
			if(group1 != 'do not set'){
				const variables = group1.split(',')
				for (let index = 0; index < variables.length; index++) {
					exclusions_list[0].push(variables[index])
				}
			}
			if(group2 != 'do not set'){
				const variables = group2.split(',')
				for (let index = 0; index < variables.length; index++) {
					exclusions_list[1].push(variables[index])
				}
			}
			if(group3 != 'do not set'){
				const variables = group3.split(',')
				for (let index = 0; index < variables.length; index++) {
					exclusions_list[2].push(variables[index])
				}
			}
			if(goldenVar != 'do not set'){
				const variables = goldenVar.split(',')
				for (let index = 0; index < variables.length; index++) {
					goldenVariables.push(variables[index])
				}
			}

			var body = {
				"n_steps": parseInt(forestValue),
				"n_windows": parseInt(crossValue),
				"log": log_ok,
				"seas_d": dummies_ok,
				"info_crit": iCrit,
				"accuracy_crit": accuracy,
				"exclusions": exclusions_list,
				"lasso": lasso_ok,
				"rf": random_ok,
				"corr": correlation_ok,
				"avoid_collinear": avoid_ok,
				"golden_variables": goldenVariables,
				"fill_forecast": auto_expl_ok,
				"cv_summary": cross
			}
			var url_request = `/api/v1/modeling/`+dataset_obj.dataset_id
			var status_code = 200 
    
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
            
			Utils.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body,
				auth_request,
				'modelingAPI'
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);

			})                   
		})
	}

	addLags(){
		cy.get('@dataset_upload').then(dataset_upload => {
			const dataset_obj = JSON.parse(dataset_upload)
			var url_request = `/api/v1/variables/`+dataset_obj.dataset_id+`/lags`
			var status_code = 200 
			var x_list = dataset_obj.variables.x_options
			var lags = {}
			
			x_list.splice(x_list.indexOf(dataset_obj.variables.y_options[0]), 1);
			for (let index = 0; index < x_list.length; index++) {
				lags[x_list[index]] = 3
			}
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')

			var body = {
				"lags":lags
			}
			Utils.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body,
				auth_request,
				'modelingAPI'
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})                   
		})
	}

	sendModelingVersions(fileName, version){

		cy.fixture(fileName, "utf-8").then(file_test => {
			var body = {
				"body": file_test,
				"skip_validation": true
			}
			var url_request = ``
			var status_code = 200 

			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
        
			if( version == "v1"){
				url_request = `/api/v1/projects`
			}
			else if(version == "v2"){
				url_request = `/api/v2/projects`
			}
			Utils.legacyDefaultAPIConfig(
				'POST',                              //method
				url_request,   //endpoint
				body,
				auth_request
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})                   
		})
	}

	sendModelUpdateVersions(fileName, version){

		cy.fixture(fileName, "utf-8").then(file_test => {
			var body = {
				"body": file_test,
				"skip_validation": true
			}
			var url_request = ``
			var status_code = 200 

			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
        
			if( version == "v1"){
				url_request = `/api/v1/projects/model-update`
			}
			else if(version == "v2"){
				url_request = `/api/v2/projects/model-update`
			}
			Utils.legacyDefaultAPIConfig(
				'POST',                              //method
				url_request,   //endpoint
				body,
				auth_request
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})                   
		})
	}
}
export default modeling;