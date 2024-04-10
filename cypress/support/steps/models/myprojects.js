/* global Given, Then, When */

import projectsApi from '../../api-requests/models/projects'
import partialError from '../../api-requests/models/time-series/partialError'

const ProjectsAPI = new projectsApi
const PartialError = new partialError

And("send a modeling without validate errors {string} with {string}", (fileName, statusCode) => {
	PartialError.requestPartialError(fileName,statusCode)
})

When("create duplicate project with {string}, {string} user and {string} response", (projectid, user, response) => {
	ProjectsAPI.createDuplicateProjects(projectid, user, response);
})

When("search {string} id in response API", (projectName) => {
	ProjectsAPI.searchProjectID(projectName);
})

And("get first {string} id", (projectName) => {
	ProjectsAPI.getProjectId(projectName)
})

And("I want compare time {string} actual project with {string} baseline projectid", (projectName,projectid) => {
	ProjectsAPI.compareProjectTime(projectName,projectid)
})
