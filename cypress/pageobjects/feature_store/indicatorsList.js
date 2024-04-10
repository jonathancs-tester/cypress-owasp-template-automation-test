import indicatorsListElements from '../../elements/feature_store/indcatorsList'

const IndicatorsListElements = new indicatorsListElements
class indicatorsList {

	enterIndicatorsTab(){
		cy.get(IndicatorsListElements.indicatorsSelectMenu('search')).click()
	}

	enterIndicatorsTabError(){
		cy.get(IndicatorsListElements.indicatorsSelectMenu('favorites')).click()
		cy.get(IndicatorsListElements.indicatorsSelectMenu('search')).click()
		cy.intercept('GET',
			'**/api/v1/indicators?**',
			{ forceNetworkError: true }
		).as('brokeRequest')
	}

	checkElementsCards(){
		cy.get(IndicatorsListElements.titleCard()).contains('View Series').should("be.visible")
		cy.get(IndicatorsListElements.titleCard()).contains('See the chart of this time series, browse the available openings, and find more information about this indicator.').should("be.visible")
		cy.get(IndicatorsListElements.descriptionCard()).should("be.visible")
	}

	checkWarningsList(){
		cy.get(IndicatorsListElements.checkboxFilter('frequency')).siblings('span').click()
		cy.get(IndicatorsListElements.checkboxFilter('secondary-transformation')).siblings('span').click()
		cy.get(IndicatorsListElements.regionColumn()).find(IndicatorsListElements.checkbox()).then($region => {
			var regionQuantity = ($region.length - 1) // pois somente uma region é selecionado no region
			cy.get(IndicatorsListElements.frequencyColumn()).find(IndicatorsListElements.checkbox()).then($frequecy => {
				var frequencyQuantity = $frequecy.length - 1
				cy.get(IndicatorsListElements.primaryTransformationColumn()).find(IndicatorsListElements.checkbox()).then($primaryTransformation => {
					var primaryTRQuantity = $primaryTransformation.length - 1
					cy.get(IndicatorsListElements.secondaryTransformationColumn()).find(IndicatorsListElements.checkbox()).then($secondaryTransformation => {
						var secondaryTRQuantity = $secondaryTransformation.length - 1
						cy.get('body').then(($body) => {
							if ($body.find(IndicatorsListElements.warningsList()).length > 0) {
								cy.get(IndicatorsListElements.warningsList()).find('li').then($warnings => {
									var warningsQuantity = $warnings.length
									cy.get('p').find('b').then($type => {
										var seriesNumber = $type[0].textContent
										var seriesNumber_int = parseInt(seriesNumber)
										var total = regionQuantity * frequencyQuantity * primaryTRQuantity * secondaryTRQuantity
										var seriesNumber_Ok = total - warningsQuantity
										assert.equal(seriesNumber_int, seriesNumber_Ok)
									})
								})
							}
							else {
								cy.get('p').find('b').then($type => {
									var seriesNumber = $type[0].textContent
									var seriesNumber_int = parseInt(seriesNumber)
									var total = regionQuantity * frequencyQuantity * primaryTRQuantity * secondaryTRQuantity
									assert.equal(seriesNumber_int, total)
								})
							}
						})
					})
				})
			})
		})
	}

	checkIndicatorsNumberQuickSearch(type, indicator){
		indicator = indicator.replace(/ /g, "-")
		cy.get(IndicatorsListElements.subCategory(type)).invoke('text').then(response => {
			var new_response = parseInt(response.match(/\d/g).join(''), 10)
			var generalPagination
			cy.get(IndicatorsListElements.pagination()).find('span').invoke('text').then(pagination => {
				generalPagination = pagination.split(/[\s,]+/)
			})
			cy.intercept("GET", "**/api/v1/indicators?category_id=**").as("waitCategory")
			cy.get(IndicatorsListElements.subCategory(type)).should('be.visible').click()
			cy.wait('@waitCategory')
			cy.get(IndicatorsListElements.indicatorCard(indicator)).find('span', indicator).should('be.visible')
			cy.get(IndicatorsListElements.pagination()).find('span').invoke('text').then(responsePagination => {
				var responsePaginationValue = responsePagination.split(/[\s,]+/)
				if(responsePaginationValue[5] != generalPagination[5])
					assert.equal(new_response, responsePaginationValue[5])

				else{
					// cy.get(IndicatorsListElements.breadCumbFilter(type)).contains(type).should('be.visible')
					cy.get(IndicatorsListElements.pagination()).find('span').invoke('text').then(responsePaginationOk => {
						var responsePaginationOk_value = responsePaginationOk.split(/[\s,]+/)
						assert.equal(new_response, responsePaginationOk_value[5])
					})
				}
			})
		})
	}

	checkZeroData(downloadButton, frequency, sheet) {
		const downloadsFolder = Cypress.env('download_path')+'/'+Cypress.env('device')+'/'+Cypress.browser.name				
		cy.task('clearFile', downloadsFolder)
		cy.task('createDownloadFolder', Cypress.env('download_path'))

		//import path from .env and click to export button
		if (Cypress.browser.name !== 'firefox') {
			cy.wrap(
				Cypress.automation('remote:debugger:protocol',
					{
						command: 'Page.setDownloadBehavior',
						params: { behavior: 'allow', downloadPath: downloadsFolder },
					}),
				{ log: false }
			)
		}
		cy.intercept("POST", '**/download/**').as("downloadSerie")
		cy.get(downloadButton).click()
		cy.wait("@downloadSerie")
		cy.log(downloadsFolder, "checkInfo")
		cy.task('findFile', downloadsFolder, { timeout: 15000 }).then((downloadedFilename) => {

			cy.task('unzipFile', downloadedFilename)
			var containFolder = downloadedFilename.replace('.zip','') + "/" + frequency +'.xlsx'
			cy.task('readXlsx', { file: containFolder, sheet: sheet }).then((rows) => {
				cy.writeFile(downloadsFolder+"/xlsxData.json", {rows})
			})
					
			cy.readFile(downloadsFolder+"/xlsxData.json").then((data) => {
				cy.task('checkZeroData',  {'data':data}).then(result => { 
					assert.ok(result, true)
				})
			});
		});
		// cy.task('clearFile', downloadsFolder)
	}

	getNumberOfIndicators(){
		var subCategoryName, subCategoryNumberOK
		cy.get(IndicatorsListElements.subCategoryNumber()).then($subCategory => {
			for (let index = 0; index < $subCategory.length; index++) {
				cy.get($subCategory[index]).invoke('text').then(subCategoryInformations => {
					var subCategoryInformationsList = subCategoryInformations.split(' (')
					subCategoryNumberOK = subCategoryInformationsList[1].replace(/([)])/g, '')
					subCategoryName = subCategoryInformationsList[0]
					cy.wrap(subCategoryName).as(subCategoryName)
					cy.wrap(subCategoryNumberOK).as(subCategoryName+' number')
				})				
			}
		})
		cy.task('pauseTime')
	}

	checkNumberOfIndicators(type){
		var subCategoryName, subCategoryNumberOK
		cy.get(IndicatorsListElements.subCategoryNumber()).then($subCategory => {
			for (let index = 0; index < $subCategory.length; index++) {
				cy.get($subCategory[index]).invoke('text').then(subCategoryInformations => {
					var subCategoryInformationsList = subCategoryInformations.split(' (')
					subCategoryNumberOK = subCategoryInformationsList[1].replace(/([)])/g, '')
					subCategoryName = subCategoryInformationsList[0]
					cy.get('@'+subCategoryName+' number').then(subcategoryBeforeValue => {
						if(type == "created"){
							if(subcategoryBeforeValue != subCategoryNumberOK)
								expect(parseInt(subcategoryBeforeValue)+1).eq(parseInt(subCategoryNumberOK))
							
							else expect(subcategoryBeforeValue).eq(subCategoryNumberOK)
						}
						else if(type == "edited"){
							if(subCategoryName == "Prices"){
								expect(parseInt(subcategoryBeforeValue)+1).eq(parseInt(subCategoryNumberOK))
							}
							else if(subCategoryName == "Labor market"){
								expect(parseInt(subcategoryBeforeValue)-1).eq(parseInt(subCategoryNumberOK))
							}
							console.log(subCategoryName, 'nome da categoria')	
						}					
					})
					cy.wrap(subCategoryName).as(subCategoryName)
					cy.wrap(subCategoryNumberOK).as(subCategoryName+' number')
				})				
			}
		})
	}

	checkModalOfPremiumGroup(dataTable){
		const data = dataTable.raw();
		for (let i = 1; i < data.length; i++) {
			const indicator = data[i][0];
			cy.get(IndicatorsListElements.checkIndicators(indicator)).should("be.visible")
		}
	}
	
}
export default indicatorsList;