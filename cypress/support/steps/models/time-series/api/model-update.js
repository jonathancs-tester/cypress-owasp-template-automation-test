/* global Given, Then, When */

import modelUpdate from '../../../../api-requests/models/time-series/model_update';

const ModelUpdate = new modelUpdate

When("send to model_update {string} project with this {string} id and status code {int}", (project, project_id, status) => {
	ModelUpdate.sendModelUpdate(project, project_id, status);
}) 

Then("compare response with this {string} object", (jsonFile) => {
	ModelUpdate.compareResponse(jsonFile)
})

And("I search for project {string} model names and ID's", (project) => {
	cy.get(project).then((id) => {
		ModelUpdate.getProjectModels(id)
	})
})
