import utils from '../../utils';

const Utils = new utils
class modelUpdate {

	sendModelUpdate(project, project_id, status){
		cy.get(project_id).then(id => {
			cy.fixture(project, "utf-8").then(file_test => {
				var body = file_test;
				var url_request = `/api/v1/projects/${id}/updates`
				var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
        
				const options = {
					method: 'POST',
					endpoint: url_request,
					body_request: body,
					auth: auth_request,
					isRequested: true, 
				};

				Utils.defaultAPIConfig(options);
				cy.get('@responseBody').then(response => {
					expect(response.status).to.equal(status);
				}) 
			})
		})
	}

	compareResponse(jsonFile){
		cy.fixture("time-series/validate_MU_scenarios/"+jsonFile).then(fileContent => {
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(400);
				let responseBodyMessage
				let jsonFileMessage
				if(jsonFile == "validate_1.json"){
					responseBodyMessage = response.body.detail[0].msg;
					jsonFileMessage = fileContent.detail[0].msg;
				}
				else if(jsonFile == "validate_3.json"){
					responseBodyMessage = response.body.detail.detail.message;
					jsonFileMessage = fileContent.message;
				}
				else{
					responseBodyMessage = response.body.detail.detail[0].message;
					jsonFileMessage = fileContent.detail.detail[0].message;
				}
				expect(responseBodyMessage).to.equal(jsonFileMessage);
			});
		});
	}

	getProjectModels(project){
		var endpoint = `/api/v1/projects/${project}/models`
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
		})
	}
}
export default modelUpdate;