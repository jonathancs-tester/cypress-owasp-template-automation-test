import utilsAPI from '../utils'

const UtilsAPI = new utilsAPI

class indicatorsAPI {
    
	createNewIndicator(isActive, status, template){
		// Define as variáveis necessárias para a requisição
		var is_active = false
		if(isActive == 'active'){
			is_active = true
		}
		var body_request = {
			"name": {
				"en-us": "test indicator name",
				"pt-br": "nome do indicador de teste"
			},
			"short_name": {
				"en-us": "short indicator name ",
				"pt-br": "nome curto do indicador"
			},
			"description": {
				"en-us": "Description of indicator",
				"pt-br": "Descrição do indicador"
			},
			"description_full": {
				"en-us": "Full description of indicator",
				"pt-br": "DEscrição completa do indicador"
			},
			"country": "EC",
			"source": {
				"en-us": "4i",
				"pt-br": "4i"
			},
			"sector": "MTG",
			"access_group": "test",
			"access_type": "default",
			"is_active": is_active,
			"ranking":1.0,
			"projection": "teste",
			"tree": [
				{
					"id": "62e2fc21b9489753bb80b2f5",
					"node": "Ecuador",
					"name": {
						"en-us": "Ecuador",
						"pt-br": "Equador"
					}
				},
				{
					"id": "62e2fc21b9489753bb80b2f6",
					"node": "Economic activity",
					"name": {
						"en-us": "Economic activity",
						"pt-br": "Atividade econômica"
					}
				},
				{
					"id": "6491b800bffda945234e95cb",
					"node": "Labor market",
					"name": {
						"en-us": "Labor market",
						"pt-br": "Mercado de trabalho"
					}
				}
			]
		}
			
		var url_request = `/api/v1/indicators`
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var status_code = 200

		if(status == "not found"){
			url_request = `/api/v1/indicatorss`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		else if(status == "bad request"){
			body_request = {}
			status_code = 400
		}
		else if(status == "already created"){
			cy.get('@indicatorCodeCreated').then(indicatorCode => {
				body_request['indicator_code'] =  indicatorCode
			})
			status_code = 400
		}
		else if(status == "non sequential id"){
			cy.get('@indicatorCodeCreated').then(indicatorCode => {
				body_request['indicator_code'] = indicatorCode.substring(0,6)+(parseInt(indicatorCode.slice(indicatorCode.length - 3))+4)
			})
			status_code = 200
		}
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			url_request,
			body_request,
			auth_request
		)
		cy.get('@responseBody').then((response) => {
			if(response.status == 200){
				var message = response.body.message
				var message_indicator_code = message.split(' ')
				cy.wrap(message_indicator_code[1]).as('indicatorCodeCreated')
				template['indicator'] = message_indicator_code[1]
			}
			expect(response.status).to.equal(status_code);
		})
	}

	createNewIndicatorGroup(status){
		
		var body_request = {
			"name": {
				"en-us": "indicators groups test",
				"pt-br": "teste grupo de indicadores"
			},
			"description": {
				"en-us": "description test",
				"pt-br": "teste descrição"
			}
		}
		var url_request = `/api/v1/access-groups`
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var status_code = 201
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			url_request,
			body_request,
			auth_request
		)
		cy.get('@responseBody').then((response) => {
			expect(response.status).to.equal(status_code);
		})
	}

	checkIndicator(name){
		var testIndicator = 0;
		cy.get('@indicatorCodeCreated').then(indicatorCode => {
			UtilsAPI.legacyDefaultAPIConfig(
				'GET',
				`/api/v1/indicators?limit=0&skip=0&language=en-us`,
				'',
				'Bearer '+window.localStorage.getItem('accessToken'),
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(200);
				if(response.status == 200){
					for (let index = 0; index < response.body.data.length; index++) {
						if(response.body.data[index].indicator_code == indicatorCode)
							testIndicator++;
					}
					if(testIndicator == 0)
						assert.fail('Nenhum indicador encontrado')
					else assert.ok
				}
			})	
		})
	}

	downloadAllSeries(indicator, file, status){
		var url_request = `/api/v1/indicators/`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var body_request = {
			"series": [
				"BRIND0076000OOML",
				"BRIND0076000OOMY",
				"BRIND0076000OOMA",
				"BRIND0076000OOMC",
				"BRIND0076000OAQL",
				"BRIND0076000OAQY",
				"BRIND0076000OAQA",
				"BRIND0076000OSQL",
				"BRIND0076000OSQY",
				"BRIND0076000OSQA",
				"BRIND0076000OSQC",
				"BRIND0076000OAYL",
				"BRIND0076000OAYY",
				"BRIND0076000OSYL",
				"BRIND0076000OSYY"
			]
		}
		if(status == "not found"){
			url_request = `/api/v1/indicatorss/`
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			url_request+indicator+'/download/'+file+'?language=en-us',
			body_request,
			auth_request
		)
		cy.get('@responseBody').then(response => {
			if(status_code == 200)
				expect(response.status).to.equal(status_code);
		})
	}

	downloadSomeSeries(series, indicator, file, status){
		var url_request = `/api/v1/indicators/`
		var status_code = 200
		var body_request = {"series": [series]}
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
    
		if(status == "not found"){
			status_code = 404
		}
		else if(status == "unauthorized"){
			auth_request = ""
			status_code = 401
		}
		else if(status == "bad request"){
			body_request = {}
			status_code = 400
		}
		UtilsAPI.legacyDefaultAPIConfig(
			'POST',
			url_request+indicator+'/download/'+file+'?language=en-us',
			body_request,
			auth_request
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
		})
	}

	checkUpdateSerie(sid, ind_code, date1, date2, date3, value1, value2, value3, endpoint, status){

		var url_request = '/api/v1/indicators/'+ind_code+'/series/'+sid+'/'+endpoint+'?limit=1000'
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var status_code = 200

		if(status == "not found"){
			url_request = '/api/v1/indicators/'+ind_code+'/seriesss/'+sid+'/'+endpoint+'?limit=1000&language=en-us'
			status_code = 404
		}
		else if(status == "forbidden"){
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
			expect(response.status).to.equal(status_code)
			if (status_code == 200){
				var new_date
				var new_value
				var pass1 = false
				var pass2 = false
				var pass3 = false
				for (let i = 0; i < response.body.data.length; i++){
					new_date = response.body.data[i].date.split('T',1)
					new_value = response.body.data[i].value
					new_date = JSON.stringify(new_date).replace('[','').replace(']','')

					if ((JSON.stringify(new_date) == JSON.stringify([ date1 ])) && (new_value == value1)){
						pass1 = true
					}
					else if ((JSON.stringify(new_date) == JSON.stringify([ date2 ])) && (new_value == value2)){
						pass2 = true
					}
					else if ((JSON.stringify(new_date) == JSON.stringify([ date3 ])) && (new_value == value3)){
						pass3 = true
					}
					else if ((pass1 == true) && (pass2 == true) && (pass3 == true)){
						i = response.body.data.length
					}			
				}
				assert.ok(pass1)
				assert.ok(pass2)
				assert.ok(pass3)
			}
		})
	}

	checkMonthsShowed(sid, ind_code, status, frequency){

		var url_request = '/api/v1/indicators/'+ind_code+'/series/'+sid+'/observations?limit=1000&language=en-us'
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var status_code = 200
		var new_date
		var new_date2
		var min
		var max

		if(status == "not found"){
			url_request = '/api/v1/indicators/'+ind_code+'/seriesss/'+sid
			status_code = 404
		}
		else if(status == "forbidden"){
			auth_request = ""
			status_code = 401
		}

		if(frequency == "monthly"){
			min = 28
			max = 31
		}
		else if(frequency == "bimonthly"){
			min = 59
			max = 62
		}

		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request,
			'',
			auth_request
		)
		cy.get('@responseBody').then(response1 => {
			expect(response1.status).to.equal(status_code);
			if (status_code == 200){
				var total			
				for (let i = 1; i < response1.body.data.length; i++) {
					new_date2 = response1.body.data[i].date.split('T',1)
					new_date = response1.body.data[i-1].date.split('T',1)
					total = (((Math.abs((new Date(new_date2[0])) - new Date((new_date[0]))))/(1000*3600*24)))
					assert.ok(total >= min && total <= max)
					if((response1.body.data.length-1) == i){
						url_request = '/api/v1/indicators/'+ind_code+'/series/'+sid+'/projections?limit=1000&language=en-us'
						UtilsAPI.legacyDefaultAPIConfig(
							'GET',
							url_request,
							'',
							auth_request
						)
						cy.get('@responseBody').then(response2 => {
							new_date = response2.body.data[0].date.split('T',1)
							total = (((Math.abs((new Date(new_date[0])) - new Date((new_date2[0]))))/(1000*3600*24)))
							assert.ok(total >= 28 && total <= 31)
							for (let i = 1; i < response2.body.data.length; i++) {
								new_date2 = response2.body.data[i].date.split('T',1)
								new_date = response2.body.data[i-1].date.split('T',1)
								total = (((Math.abs((new Date(new_date2[0])) - new Date((new_date[0]))))/(1000*3600*24)))
								assert.ok(total >= min && total <= max)
							}
						})
					}
				}
			}
		})
	}

	checkInactiveIndicator(indicator){
		var url_request
		if(indicator == 'created'){
			cy.get('@indicatorCodeCreated').then(indicatorCode => {
				url_request = '/api/v1/indicators/'+indicatorCode+'?language=en-us'
				cy.wrap(url_request).as('url_request_ok')
			})
		}
		else{ 
			url_request = `/api/v1/indicators/`+indicator
			cy.wrap(url_request).as('url_request_ok')
		}
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		var cont = 0           
		function req(){
			cy.get('@url_request_ok').then(url_request_ok => {
				UtilsAPI.legacyDefaultAPIConfig(
					'GET',
					url_request_ok,
					'',
					auth_request
				)
				cy.get('@responseBody').then(response => {
					cont++
					expect(response.status).to.equal(status_code);
					if(!response.body.is_active)
						return

					else if(cont <= 200){
						req()
					}

					else assert.fail()
				})
			})
		}
		cy.then(req)
	}

	inactiveIndicator(indicator){
		var url_request
		if(indicator == 'created'){
			cy.get('@indicatorCodeCreated').then(indicatorCode => {
				url_request = '/api/v1/indicators/'+indicatorCode+'?language=en-us'
				cy.wrap(url_request).as('url_request_ok')
			})
		}
		else{ 
			url_request = `/api/v1/indicators/`+indicator
			cy.wrap(url_request).as('url_request_ok')
		}
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		cy.get('@url_request_ok').then(url_request_ok => {
			UtilsAPI.legacyDefaultAPIConfig(
				'GET',
				url_request_ok,
				'',
				auth_request
			)
			cy.get('@responseBody').then(response => {
				expect(response.status).to.equal(status_code);
				var body_ok =  {
					"name": {
						"en-us": "test indicator name inative",
						"pt-br": "nome do indicador de teste inative"
					},
					"short_name": {
						"en-us": "short indicator name ",
						"pt-br": "nome curto do indicador"
					},
					"description": {
						"en-us": "Description of indicator",
						"pt-br": "Descrição do indicador"
					},
					"description_full": {
						"en-us": "Full description of indicator",
						"pt-br": "DEscrição completa do indicador"
					},
					"country": "EC",
					"source": {
						"en-us": "4i",
						"pt-br": "4i"
					},
					"sector": "MTG",
					"access_group": "test",
					"access_type":"default",
					"is_active": false,
					"projections":"teste",
					"ranking": 1.0,
					"tree": [
						{
							"id": "62e2fc21b9489753bb80b2f5",
							"node": "Ecuador",
							"name": {
								"en-us": "Ecuador",
								"pt-br": "Equador"
							}
						}
					]
				}
				UtilsAPI.legacyDefaultAPIConfig(
					'PUT',
					url_request_ok,
					body_ok,
					auth_request
				)
				cy.get('@responseBody').then(response2 => {
					expect(response2.status).to.equal(status_code);
				})
			})
		})
	}

	inactiveAllIndicators(indicator){
		var url_request = `/api/v1/indicators?limit=0&language=en-us`
		var status_code = 200
		var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
		UtilsAPI.legacyDefaultAPIConfig(
			'GET',
			url_request,
			'',
			auth_request
		)
		cy.get('@responseBody').then(response => {
			expect(response.status).to.equal(status_code);
			var indicators_list = []
			for (let index = 0; index < response.body.data.length; index++) {
				if(response.body.data[index].name['en-us'].toLowerCase().indexOf(indicator) != -1)
					indicators_list.push(response.body.data[index].indicator_code)
			}
			var url_request_ok
			for (let index = 0; index < indicators_list.length; index++) {
				url_request_ok = '/api/v1/indicators/'+indicators_list[index]
				cy.task('inactiveAllIndicators', {url_ok:url_request_ok, auth_ok: auth_request})
			}
		})

	}

	editIndicatorByAPI(){
		var body_request = {
			"name": {
				"en-us": "test indicator name",
				"pt-br": "nome do indicador de teste"
			},
			"short_name": {
				"en-us": "short indicator name ",
				"pt-br": "nome curto do indicador"
			},
			"description": {
				"en-us": "Description of indicator",
				"pt-br": "Descrição do indicador"
			},
			"description_full": {
				"en-us": "Full description of indicator",
				"pt-br": "DEscrição completa do indicador"
			},
			"country": "EC",
			"source": {
				"en-us": "4i",
				"pt-br": "4i"
			},
			"sector": "MTG",
			"access_group": "test",
			"access_type": "default",
			"is_active": true,
			"projections":"teste",
			"ranking": 1.0,
			"tree": [
				{
					"id": "62e2fc21b9489753bb80b2f5",
					"node": "Ecuador",
					"name": {
						"en-us": "Ecuador",
						"pt-br": "Equador"
					}
				},
				{
					"id": "62e2fc21b9489753bb80b2f6",
					"node": "Economic activity",
					"name": {
						"en-us": "Economic activity",
						"pt-br": "Atividade econômica"
					}
				},
				{
					"id": "62e2fc21b9489753bb80b2fc",
					"node": "Prices",
					"name": {
						"en-us": "Prices",
						"pt-br": "Preços"
					}
				}
			]
		}
		cy.get('@indicatorCodeCreated').then(indicatorCode => {
			var url_request = `/api/v1/indicators/`+indicatorCode
			var auth_request = 'Bearer '+window.localStorage.getItem('accessToken')
			var status_code = 200

			UtilsAPI.legacyDefaultAPIConfig(
				'PUT',
				url_request,
				body_request,
				auth_request
			)
			cy.get('@responseBody').then((response) => {
				expect(response.status).to.equal(status_code);
			})
		})
	}
}
export default indicatorsAPI;