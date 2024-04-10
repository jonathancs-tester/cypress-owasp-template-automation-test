/// <reference types="Cypress" />

import utils from '../../utils'

const Utils = new utils
class dataView {

	checkDataView(dateFormat){
		cy.get('@dataset_upload').then(dataset_upload => {
			const dataset_obj = JSON.parse(dataset_upload)
			var url_request = `/api/v1/projects/`+dataset_obj.dataset_id+`/dataview`
			var status_code = 200 
			var x_list = dataset_obj.variables.x_options
			
			x_list.splice(x_list.indexOf(dataset_obj.variables.y_options[0]), 1);
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')

			var body = {
				"var_y": dataset_obj.variables.y_options[0],
				"var_x": x_list,
				"date_var": dataset_obj.variables.date_options[0],
				"date_format": dateFormat
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
}
export default dataView;