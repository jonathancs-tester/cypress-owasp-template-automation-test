/* global Given, Then, When */

import modelingClaas from '../../../../api-requests/models/classification/modeling'

const ModelingClaas = new modelingClaas

When("upload classification dataset {string} with {string} project name and {string} status", (dataset, project_name, status) => {
	ModelingClaas.uploadDataset(dataset, project_name, status);
})

Then("select variables with {string} status with {string} dependent variable", (status, dependentVariable) => {
	ModelingClaas.selectVariables(status, dependentVariable);
})

Then("validate dataset in classification", () => {
	ModelingClaas.validateDataset();
})

Then("send to classification modeling with {string}", (status) => {
	ModelingClaas.sendModeling(status);
})

Then("check {string} message with {string} warning for {string} in validate dataset", (message, type, variables) => {
	ModelingClaas.checkValidateWarningMessage(message,type,variables);
})