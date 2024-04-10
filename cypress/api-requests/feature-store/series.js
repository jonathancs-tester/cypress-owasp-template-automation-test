/// <reference types="Cypress" />

import utilsAPI from '../utils'

const UtilsAPI = new utilsAPI

class seriesAPI {
    
	getIndicatorSeries(indicator, status){
		var url_request = `/api/v1/indicators/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/indicatorss/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request+indicator+'/series?language=en-us',
			'',
			auth_request
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
			if(status == "success")
				expect(response.body.data.length).not.eq(0)
		})
	}

	getAllSeries(status){
		var url_request = `/api/v1/series/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/seriess/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request,
			'',
			auth_request
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
			if(status == "success"){
				expect(response.body.data.length).to.equal(10)
			}
		})
	}

	getSeriesByID(serie, status){
		var url_request = `/api/v1/series/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/seriess/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request+serie+'?language=en-us',
			'',
			auth_request
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
			if(status == "success"){
				expect(response.body.data.code).to.equal(serie)
			}
		})
	}

	createSerie(indicator, status){
		var url_request
		if(indicator == 'created'){
			cy.get('@indicatorCodeCreated').then(indicatorCode => {
				url_request = '/api/v1/indicators/'+indicatorCode+'/series?language=en-us'
				cy.wrap(url_request).as('url_request_ok')
			})
		}
		else{ 
			url_request = `/api/v1/indicators/`+indicator+`/series?language=en-us`
			cy.wrap(url_request).as('url_request_ok')
		}
		var status_code = 200
		var body_request = {
			"aggregation": "OM",
			"region": "000",
			"primary_transformation": "O",
			"second_transformation": "M",
			"unit": { 
				"en-us": "meters", 
				"pt-br": "metros"
			}
		}
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/seriess/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		cy.get('@url_request_ok').then(url_request_ok => {
			UtilsAPI.legacyDefaultAPIConfig(
				'POST',
				url_request_ok,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
				if(status == "success"){
					var response_message = response.body.message.split(': ').slice(-1)
					cy.wrap(response_message[0].replaceAll('"','')).as("seriesCode")
				}
			})
		})		
	}

	deleteSerie(serie, indicator, status){
		var url_request
		if(indicator == 'created' && serie == 'created'){
			cy.get('@indicatorCodeCreated').then(indicatorCode => {
				cy.get('@seriesCode').then(serieCode => {
					url_request = '/api/v1/indicators/'+indicatorCode+'/series/'+serieCode+'?language=en-us'
					cy.wrap(url_request).as('url_request_ok')
				})
			})
		}
		else{ 
			url_request = `/api/v1/indicators/`+indicator+`/series/`+serie+'?language=en-us'
			cy.wrap(url_request).as('url_request_ok')
		}
		var status_code = 200
		var body_request = {
			"aggregation": "OM",
			"region": "000",
			"primary_transformation": "O",
			"second_transformation": "M",
			"unit": { 
				"en-us": "meters", 
				"pt-br": "metros"
			}
		}
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			url_request = `/api/v1/seriess/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		cy.get('@url_request_ok').then(url_request_ok => {
			UtilsAPI.legacyDefaultAPIConfig(
				'DELETE',
				url_request_ok,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})
		})
	}

	editSerie(serie, accessType, indicator, status){
		var url_request
		if(indicator == 'created' && serie == 'created'){
			cy.get('@indicatorCodeCreated').then(indicatorCode => {
				cy.get('@seriesCode').then(serieCode => {
					url_request = '/api/v1/indicators/'+indicatorCode+'/series/'+serieCode+'?language=en-us'
					cy.wrap(url_request).as('url_request_ok')
				})
			})
		}
		else{ 
			url_request = `/api/v1/indicators/`+indicator+`/series/`+serie+'?language=en-us'
			cy.wrap(url_request).as('url_request_ok')
		}
		var status_code = 200
		var body_request = {
			"unit": {
				"en-us": "$",
				"pt-br": "$"
			},
			"status": "maintenance",
			"access_type": accessType
		}
		if(status == "bad request"){
			status_code = 400
		}
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		cy.get('@url_request_ok').then(url_request_ok => {
			UtilsAPI.legacyDefaultAPIConfig(
				'PATCH',
				url_request_ok,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
			})
		})
	}
}
export default seriesAPI;