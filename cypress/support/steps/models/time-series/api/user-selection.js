/* global Given, Then, When */

import userSelectionAPI from '../../../../api-requests/models/time-series/user-selection'

const UserSelectionAPI = new userSelectionAPI

When("simulate fixed variables project using {string}, {string}, {string}, {string} info with {string}", (forecast, year, variables, values, response) => {
	UserSelectionAPI.applySimulation(forecast, year, variables, values, response)
})
