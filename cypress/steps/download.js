import downloads from '../components/download'

const Downloads = new downloads

And("I check if download size is greather than {int} kb", (downloadSize) => {
	Downloads.checkDownloadSize(downloadSize)
})

And(/I click external download in element "(.+)"/, (id) => {
	Downloads.downloadExternalFile(id)
})

And("I check if data is correctly with following data:", (dataDownload) => {
	Downloads.checkTableData(dataDownload)
})

And(/I check if "(.+)" data is finding in download file/, (list) => {
	const texts = list.split(';')
	for (let text of texts) {
		Downloads.findStringInFile(text)		
	}
})

And("I check if data is correctly with following {string} file on sheet {int}", (dataFile, sheet_file) => {
	Downloads.checkDownloadData(dataFile, sheet_file)
})

And("I clear download folder", () => {
	Downloads.clearDownloadFolder()
})

And("I unzip download file", () => {
	Downloads.unzipDownloadFile()
})