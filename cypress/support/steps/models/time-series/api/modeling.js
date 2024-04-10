/* global Given, Then, When */

import modeling from '../../../../api-requests/models/time-series/modeling'

const Modeling = new modeling

When("upload dataset {string} with {string} project name", (dataset, project_name) => {
	Modeling.uploadDataset(dataset, project_name);
})

And("select variables with {string} date format", (dateFormat) => {
	Modeling.selectVariables(dateFormat);
})

And("validate dataset", () => {
	Modeling.validateDataset();
})

And("send modeling with configs {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}", (forestValue, crossValue, log, dummies, iCrit, accuracy, cross, avoid, auto_expl, group1, group2, group3, lasso, random, correlation, goldenVar) => {
	Modeling.sendModeling(forestValue, crossValue, log, dummies, iCrit, accuracy, cross, avoid, auto_expl, group1, group2, group3, lasso, random, correlation, goldenVar);
})

And("add variables lags", () => {
	Modeling.addLags();
}) 

And("send a modeling {string} in {string} API", (file,versions) => {
	Modeling.sendModelingVersions(file,versions);
}) 