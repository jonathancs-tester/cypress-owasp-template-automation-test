import Elements from "../elements/common"

const downloadsFolder = Cypress.env('download_path')+'/'+Cypress.env('device')+'/'+Cypress.browser.name		

class download {
	checkDownloadSize(downloadSize){
		cy.log(downloadsFolder, "CheckDownload")
		cy.task('findFile', downloadsFolder, { timeout: 90000 }).then((downloadedFilename) => {
			cy.readFile(downloadedFilename, 'binary', { timeout: 90000 }).should((buffer) => {
				expect(buffer.length).to.be.gt(downloadSize)
			})
			cy.log('**the file exists and is valid**')
		});
	}

	clearDownloadFolder(){
		cy.task('clearFile', downloadsFolder)
	}

	checkTableData(dataTable){
		const data = dataTable.raw();
		const rowsToCheck = data.slice(1).map(row => parseInt(row[0]));
		cy.task("compareDataWithFile", {dataTable: data, downloadPath: downloadsFolder, rowsToCheck: rowsToCheck}).then(compareResults => {
			expect(compareResults).to.be.eq(true)
		})
	}

	findStringInFile(text){
		cy.task("findStringInFile", {searchStr: text, downloadPath: downloadsFolder}).then(compareResults => {
			expect(compareResults).to.be.eq(true)
		})
	}

	checkDownloadData(dataFile, sheet_file){
		cy.task("compareDownloadWithFile", {dataFile: dataFile, downloadPath: downloadsFolder, sheet: sheet_file}).then(compareResults => {
			expect(compareResults).to.be.eq(true)
		})
	}

	unzipDownloadFile(){
		cy.task("unzipFile", downloadsFolder)
	}

	downloadExternalFile(id){
		this.setConfiguration()
		cy.window().document().then(function (doc) {
			doc.addEventListener('click', () => {
			  setTimeout(function () { doc.location.reload() }, 5000)
			})
			cy.task("createDownloadFolder", Cypress.env('download_path'))
			cy.get(Elements.map(id)).click()
	    })
	}

	setConfiguration(){
		cy.task("createDownloadFolder", Cypress.env('download_path'))
		if (Cypress.browser.name === 'chrome') {
			cy.wrap(
				Cypress.automation('remote:debugger:protocol',
					{
						command: 'Page.setDownloadBehavior',
						params: { behavior: 'allow', downloadPath: downloadsFolder },
					}),
				{ log: false }
			)
		}
	}
}
export default download;
