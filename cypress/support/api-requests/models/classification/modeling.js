import utils from '../../utils'

const Utils = new utils
class modelingClaas {

	uploadDataset(dataset, project_name, status){

		cy.readFile('cypress/fixtures/classification/'+dataset, 'binary').then((file1) => Cypress.Blob.binaryStringToBlob(file1))
			.then((blob1) => {
				var formData1 = new FormData()
				formData1.set("file", blob1, dataset);
				formData1.set("project_name", project_name)
				formData1.set("icon_url", "https://saoseba.blob.core.windows.net/jureia/cc826f11-eed9-4ac7-ad01-08958faf0aae.png")

				var url_request = `/api/v1/classification/upload`
				var status_code = 200 

				var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')

				if(status == 'Not found'){
					url_request = '/api/v1/classificatiion/upload'
					status_code = 404
				}
				else if(status == 'Unauthorized'){
					auth_request = ""
					status_code = 403
				}
				else if(status == 'Bad request'){
					formData1.set("project_name", '')
					status_code = 400
				}
        
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

	selectVariables(status, dependentVariable){
		cy.get('@dataset_upload').then(dataset_upload => {
			const dataset_obj = JSON.parse(dataset_upload)
			var x_list = dataset_obj.variables.x_options
			var body = {}
			if(dependentVariable == "default"){
				x_list.splice(x_list.indexOf(dataset_obj.variables.y_options[0]), 1)
				body = {
					"var_y": dataset_obj.variables.y_options[0],
					"var_x": x_list,
				}
			}
			else{
				x_list.splice(x_list.indexOf(dependentVariable), 1)
				body = {
					"var_y": dependentVariable,
					"var_x": x_list,
				}
			}
			var url_request = `/api/v1/classification/variables/`+dataset_obj.dataset_id
			var status_code = 200 
    
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			if(status == 'Not found'){
				url_request = '/api/v1/classificatiion/variabless'
				status_code = 404
			}
			else if(status == 'Unauthorized'){
				auth_request = ""
				status_code = 403
			}
			else if(status == 'Bad request'){
				body = {}
				status_code = 400
			}
			else if(status == 'Removing'){
				body.var_x.pop();
			}

            console.log(body, 'body aqui')
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
		
			var url_request = `/api/v1/classification/validate/`+dataset_obj.dataset_id
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
				cy.wrap(response).as('validate_response')
			})                   
		})
	}

	checkValidateWarningMessage(message,type,variables){
		cy.get('@validate_response').then(validate_response => {
			expect(validate_response.body.status_title).to.equal('Warning');
			if(variables != 'not have'){
				if(type=='missing'){
					expect(validate_response.body.info.warning_list.removed_cols_missing.text).to.equal(message);
					var all_variables = variables.split(',')
					for (let i = 0; i < all_variables.length; i++) {
						expect(validate_response.body.info.warning_list.removed_cols_missing.variables).to.contains(all_variables[i]);
					}
				}
				else if(type=='rows'){
					expect(validate_response.body.info.warning_list.removed_rows.text).to.equal(variables+' '+message);
					expect(validate_response.body.info.warning_list.removed_rows.rows).to.equal(parseInt(variables));
				}
				else{
					expect(validate_response.body.info.warning_list.removed_cols_type.text).to.equal(message);
					var all_variables = variables.split(',')
					for (let i = 0; i < all_variables.length; i++) {
						expect(validate_response.body.info.warning_list.removed_cols_type.variables).to.contains(all_variables[i]);
					}
				}
			}
		})
	}

	sendModeling(status){
		cy.get('@dataset_upload').then(dataset_upload => {
			const dataset_obj = JSON.parse(dataset_upload)
			
			var body = {}
			var url_request = `/api/v1/classification/modeling/`+dataset_obj.dataset_id
			var status_code = 200 
    
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		
			if(status == 'Not found'){
				url_request = `/api/v1/classificationn/modeling/`+dataset_obj.dataset_id
				status_code = 404
			}
			else if(status == 'Unauthorized'){
				auth_request = ""
				status_code = 403
			}
			
			Utils.legacyDefaultAPIConfig(
				'POST',
				url_request,
				body,
				auth_request,
				'modelingAPI',
				null,
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})                   
		})
	}

	checkWarningUnbalanced(message){
		cy.get("p").contains(message)
	}

	checkMessageWarning(message){
		cy.get("strong").contains(message).should('be.visible')
	}
}
export default modelingClaas;