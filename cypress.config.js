const { defineConfig } = require("cypress");
const cucumber = require('cypress10-cucumber-preprocessor').default

var shell = require('shelljs')
const path = require('path')
const fs = require('fs')
const xlsx = require('node-xlsx').default;
const readXlsx = require('./cypress/plugins/read-xlsx')
const isFirefox = (browser) => browser.family === 'firefox'
const fetch = require('node-fetch')

module.exports = defineConfig({
	viewportWidth: 1920,
	viewportHeight: 1080,
	defaultCommandTimeout: 180000,
	videoCompression: false,
	pageLoadTimeout: 180000,
	video: false,
	responsetimeout: 180000,

	e2e: {
		retries: 1,
		setupNodeEvents(on, config) {
			config.env.download_path = process.env.DOWNLOAD_PATH
			config.env.browser = process.env.BROWSER
			config.env.device = process.env.DEVICE
			config.env.feature = process.env.FEATURE
			config.env.project_time_tolerance_minutes =process.env.PROJECT_TIME_TOLERANCE_MINUTES
			config.env.release = process.env.RELEASE
			config.env.tag = process.env.TAG

			//User Credentials
			config.env.admin_user = process.env.ADMIN_USER
			config.env.admin_pwd = process.env.ADMIN_PWD
			config.env.admin_otp = process.env.ADMIN_OTP
			config.env.admin_client_secret = process.env.ADMIN_CLIENT_SECRET
			config.env.view_user = process.env.VIEW_USER
			config.env.view_pwd = process.env.VIEW_PWD
			config.env.view_otp = process.env.VIEW_OTP
			config.env.view_client_secret = process.env.VIEW_CLIENT_SECRET
			config.env.invalid_user = process.env.INVALID_USER
			config.env.invalid_pwd = process.env.INVALID_PWD
			config.env.invalid_otp = process.env.INVALID_OTP
			config.env.invalid_client_secret = process.env.INVALID_CLIENT_SECRET
			config.env.freemium_user = process.env.FREEMIUM_USER
			config.env.freemium_pwd = process.env.FREEMIUM_USER_PWD
			config.env.freemium_otp = process.env.FREEMIUM_USER_OTP

			//4Casthub access
			config.env.time_series_user = process.env.TIME_SERIES_USER
			config.env.time_series_pwd = process.env.TIME_SERIES_PWD
			config.env.time_series_otp = process.env.TIME_SERIES_OTP
			config.env.classification_user = process.env.CLASSIFICATION_USER
			config.env.classification_pwd = process.env.CLASSIFICATION_PWD
			config.env.classification_otp = process.env.CLASSIFICATION_OTP
			config.env.feature_store_user = process.env.FEATURE_STORE_USER
			config.env.feature_store_pwd = process.env.FEATURE_STORE_PWD
			config.env.feature_store_otp = process.env.FEATURE_STORE_OTP

			//Manager - User Control
			config.env.manager_user = process.env.MANAGER_USER
			config.env.manager_pwd = process.env.MANAGER_PWD
			config.env.manager_otp = process.env.MANAGER_OTP
			config.env.manager_without_project_user = process.env.MANAGER_WITHOUT_PROJECT_USER
			config.env.manager_without_project_pwd = process.env.MANAGER_WITHOUT_PROJECT_PWD
			config.env.manager_without_project_otp = process.env.MANAGER_WITHOUT_PROJECT_OTP

			//Auth0
			config.env.auth_client_id = process.env.AUTH_CLIENT_ID
			config.env.auth_audience = process.env.AUTH_AUDIENCE
			config.env.auth_domain = process.env.AUTH_DOMAIN
			config.env.auth_scope = process.env.AUTH_SCOPE

			config.baseUrl = process.env.FAAS_BASEURL

			if (process.env.BROWSER == 'firefox') {
				config.env.admin_user = process.env.ADMIN_USER_FIREFOX
				config.env.admin_pwd = process.env.ADMIN_PWD_FIREFOX
				config.env.admin_otp = process.env.ADMIN_OTP_FIREFOX
				config.env.view_user = process.env.VIEW_USER_FIREFOX
				config.env.view_pwd = process.env.VIEW_PWD_FIREFOX
				config.env.view_otp = process.env.VIEW_OTP_FIREFOX
				config.env.manager_user = process.env.MANAGER_USER_FIREFOX
				config.env.manager_pwd = process.env.MANAGER_PWD_FIREFOX
				config.env.manager_otp = process.env.MANAGER_OTP_FIREFOX
				config.env.manager_without_project_user = process.env.MANAGER_WITHOUT_PROJECT_USER_FIREFOX
				config.env.manager_without_project_pwd = process.env.MANAGER_WITHOUT_PROJECT_PWD_FIREFOX
				config.env.manager_without_project_otp = process.env.MANAGER_WITHOUT_PROJECT_OTP_FIREFOX
				config.env.freemium_user = process.env.FREEMIUM_USER_FIREFOX
				config.env.freemium_pwd = process.env.FREEMIUM_USER_PWD_FIREFOX
				config.env.freemium_otp = process.env.FREEMIUM_USER_OTP_FIREFOX
			}

			if (process.env.FEATURE.includes('MODELLING') || process.env.FEATURE.includes('TIMESERIES') || process.env.FEATURE.includes('CLASSIFICATION')) {
				config.env.modelingAPIBaseurl = process.env.FAAS_MODELING_API_BASEURL
				config.env.apiBaseUrlFS = process.env.FEATURE_STORE_API_BASEURL
				config.env.apiPick4MeUrl = process.env.PICK_FOR_ME_API_BASEURL
				config.env.apiBaseUrl = process.env.FAAS_API_BASEURL
				config.env.read_project_user = process.env.READ_PROJECT_USER
				config.env.read_project_pwd = process.env.READ_PROJECT_PWD
				config.env.read_project_otp = process.env.READ_PROJECT_OTP
				config.env.admin_client_secret = process.env.READ_CLIENT_SECRET

			} else if (process.env.FEATURE.includes('FEATURE_STORE')) {
				config.env.apiBaseUrl = process.env.FEATURE_STORE_API_BASEURL
				config.env.apiBaseUrlSeries = process.env.FS_API_BASEURL_SERIES
				config.env.apiPick4MeUrl = process.env.PICK_FOR_ME_API_BASEURL

			} else if (process.env.FEATURE.includes('SCENARIOS')) {
				config.env.editor_user = process.env.EDITOR_USER
				config.env.editor_pwd = process.env.EDITOR_PWD
				config.env.editor_otp = process.env.EDITOR_OTP
				config.env.editor_client_secret = process.env.EDITOR_CLIENT_SECRET
				config.env.ocb_user = process.env.OCB_USER
				config.env.ocb_pwd = process.env.OCB_PWD
				config.env.ocb_otp = process.env.OCB_OTP
				config.env.ocb_client_secret = process.env.OCB_CLIENT_SECRET
				config.env.stg_user = process.env.STG_USER
				config.env.stg_pwd = process.env.STG_PWD
				config.env.stg_otp = process.env.STG_OTP
				config.env.stg_client_secret = process.env.STG_CLIENT_SECRET
				config.env.apiBaseUrl = process.env.SCENARIOS_API_BASEURL
				config.env.tokenScenariosApi = process.env.SCENARIOS_TOKEN_API
				config.baseUrl = process.env.SCENARIOS_BASEURL
				config.env.admin_user = process.env.ADMIN_CENARIOS_USER
				config.env.admin_pwd = process.env.ADMIN_CENARIOS_PWD
				config.env.admin_otp = process.env.ADMIN_CENARIOS_OTP
				config.env.view_user = process.env.VIEW_CENARIOS_USER
				config.env.view_pwd = process.env.VIEW_CENARIOS_PWD
				config.env.view_otp = process.env.VIEW_CENARIOS_OTP
			}

			on('task', {
				//TODO: Alterar o clear downloads para usar o file (QA-1915)
				createDownloadFolder(dir) {
					console.log('create folder %s', dir)
					if (!fs.existsSync(dir))
						fs.mkdirSync(dir)

					return null
				},
				findFile(downloadPath) {
					var findFile = true
					var count = 0
					while ((findFile) || (count < 1000)) {
						if (fs.existsSync(downloadPath) && fs.readdirSync(downloadPath).length) {
							var files = fs.readdirSync(downloadPath);
							if (!(files[0].includes("part") || files[0].includes("download"))) {
								var downloadedFilename = path.join(downloadPath, files[0]);
								console.log('filename', downloadedFilename)
								findFile = false
								count += 1000
							}
						}
						count++
					}
					return downloadedFilename
				},
				existFile(path) {
					if (fs.existsSync(path)) {
						return true
					}
					else return false
				},
				clearFile(path) {
					console.log('clearing folder %s', path)
					if (fs.existsSync(path)) {
						fs.rmdirSync(path, { recursive: true });
					} else {
						console.log('Folder does not exist:', path);
					}
					return null;
				},
				printLogs(logresponse){
					console.log("*****************************************")
					console.log(logresponse)
					console.log("*****************************************")
					return null;
				}
			})

			//Used only to login tests via UI
			if (process.env.CHROMEWEBSECURITY == 'false') {
				config.chromeWebSecurity = false
			}



			on('task', {
				inactiveAllIndicators({ url_ok, auth_ok }) {   	// This function inactive all indicators of argument. Used to erase the Feature Store
					var myHeaders = new fetch.Headers();
					myHeaders.append("Content-Type", "application/json");
					myHeaders.append("Authorization", auth_ok)
					var body = {
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
						"is_active": false,
						"sector": "MTG",
						"access_group": "test",
						"access_type": "private",
						"ranking": 1.0,
						"projection": "teste",
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
					var raw = JSON.stringify(body)
					var requestOptions = {
						method: 'PUT',
						headers: myHeaders,
						body: raw,
						redirect: 'follow'
					};
					fetch(process.env.FEATURE_STORE_API_BASEURL + '/' + url_ok, requestOptions)
						.then(response => console.log(response))
						.then(result => console.log(result))
						.catch(error => console.log('error', error));
					return null
				}
			})

			on('task', {
				unzipFile(downloadPath) {
					const filesInDir = fs.readdirSync(downloadPath);
					const zipFile = filesInDir.find(file => path.extname(file) === '.zip');

					const zipFilePath = path.join(downloadPath, zipFile);
					const dir = downloadPath;
					shell.exec(`unzip "${zipFilePath}" -d "${dir}" -x infos.xlsx`);
					fs.unlinkSync(zipFilePath);
					return null
				},
			})

			on('task', {
				checkZeroData(data) {
					var checkZero = true
					for (let index = 0; index < Object.values(data.data.rows).length; index++) {
						if (Object.values(data.data.rows[index])[1] == 0)
							checkZero = false
					}
					return checkZero
				},
			})

			on('task', {
				pauseTime() {
					return new Promise(resolve => {
						setTimeout(() => {
							console.log('Aguardando a inserção de dados')
							resolve(null)
						}, 15000)
					})
				}
			})

			on('task', {
				'readXlsx': readXlsx.read
			})

			on('task', {
				compareDataWithFile({ dataTable, downloadPath, rowsToCheck }) {
					return new Promise((resolve, reject) => {
						try {
							var files;
							try {
								files = fs.readdirSync(downloadPath);

								if (files.length !== 1) {
									throw new Error('O diretório não contém exatamente um arquivo.');
								}
							} catch (error) {
								throw new Error('Erro ao listar arquivos no diretório: ' + error.message);
							}

							const jsonData = xlsx.parse(fs.readFileSync(downloadPath + '/' + files[0]));

							var row_iteration = 1;

							for (let rowToCheck of rowsToCheck) {
								const jsonRow = jsonData[0].data[rowToCheck - 1].slice(1).map(value => value.toString());
								const dataRow = dataTable[row_iteration].slice(2).map(value => value.toString());
								if (JSON.stringify(jsonRow) !== JSON.stringify(dataRow)) {
									resolve(false);
									return;
								}
								row_iteration += 1;
							}
							resolve(true);
						} catch (e) {
							reject(e);
						}
					});
				}
			});

			on('task', {
                findStringInFile({ searchStr, downloadPath }) {
                    return new Promise((resolve, reject) => {
                        try {
                            const files = fs.readdirSync(downloadPath);
                
                            if (files.length !== 1) {
                                throw new Error(`O diretório não contém exatamente um arquivo. Contém ${files.length}`);
                            }                           
                            
                            const jsonData = xlsx.parse(fs.readFileSync(downloadPath + '/' + files[0]));
                
                            // Verifica se jsonData possui dados e se tem pelo menos uma folha de dados
                            if (jsonData && jsonData.length > 0 && jsonData[0].data) {
                                // Loop pelas linhas e colunas do arquivo Excel para encontrar a string
                                for (let row = 0; row < jsonData[0].data.length; row++) {
                                    // Verifica se a linha atual possui dados
                                    if (jsonData[0].data[row]) {
                                        for (let col = 0; col < jsonData[0].data[row].length; col++) {
                                            // Verifica se a célula atual possui dados antes de acessá-la
                                            if (jsonData[0].data[row][col] !== undefined && jsonData[0].data[row][col] !== null) {
                                                const cellValue = jsonData[0].data[row][col].toString();
                                                if (cellValue.includes(searchStr)) {
                                                    resolve(true);
                                                    return;
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                throw new Error("O arquivo Excel não contém dados válidos.");
                            }
                
                            // Se a string não for encontrada, resolve com 'found' como falso
                            resolve(false);
                        } catch (e) {
                            reject(e);
                        }
                    });
                }               
            });

			on('task', {
				compareDownloadWithFile({ dataFile, downloadPath, sheet }) {
					return new Promise((resolve, reject) => {
						try {
							var files;
							try {
								files = fs.readdirSync(downloadPath);

								if (files.length === 1) {
									console.log("Arquivo encontrado");
								} else {
									throw new Error('O diretório não contém exatamente um arquivo.');
								}
							} catch (error) {
								throw new Error('Erro ao listar arquivos no diretório: ' + error.message);
							}

							const jsonData = xlsx.parse(fs.readFileSync(downloadPath + '/' + files[0]));

							const dataFileContents = fs.readFileSync(dataFile);
							const dataFileJson = xlsx.parse(dataFileContents);
							const sheet_file = sheet - 1
							for (let i = 0; i < jsonData[sheet_file].data.length; i++) {
								const jsonRow = jsonData[sheet_file].data[i];
								const dataFileRow = dataFileJson[sheet_file].data[i];

								const jsonRowStrings = jsonRow.map((value) =>
									typeof value === 'number' ? Number(value).toFixed(2).toString() : value
								);

								const dataFileRowStrings = dataFileRow.map((value) =>
									typeof value === 'number' ? Number(value).toFixed(2).toString() : value
								);

								if (JSON.stringify(jsonRowStrings) !== JSON.stringify(dataFileRowStrings)) {
									resolve(false);
									return;
								}
							}
							resolve(true);
						} catch (e) {
							reject(e);
						}
					});
				}
			});


			on('task', {
				parseXlsx({ filePath }) {
					return new Promise((resolve, reject) => {
						try {
							const jsonData = xlsx.parse(fs.readFileSync(filePath));
							resolve(jsonData);
						} catch (e) {
							reject(e);
						}
					});
				}
			});

			on('before:browser:launch', (browser, options) => {
				console.log('browser %o', browser)
				var shelloutput = shell.exec("cat /etc/os-release")
				var [_, OSVersion] = shelloutput.match(/PRETTY_NAME="((?:\\.|[^"\\])*)"/)
				config.env.os_version = OSVersion
				config.env.browser_version = browser.version
				process.env['BASEURLREPORT'] = config.baseUrl
				const myVars = {
					OS_VERSION: OSVersion,
					BROWSER_VERSION: browser.version,
					BASEURLREPORT: config.baseUrl
				};
				let infos = JSON.stringify(myVars)
				shell.exec(`mkdir -p cypress/html-info/html-info-${browser.name}`)
				fs.writeFileSync(`cypress/html-info/html-info-${browser.name}/html-info.json`, infos)
				if (process.env.LOCAL_TEST != 'local') {
					shell.exec("env > .env")
				}

				if (isFirefox(browser)) {
					const downloadDirectory = path.join(__dirname, 'cypress/fixtures/downloads/' + process.env.DEVICE + '/' + browser.name)
					options.preferences['browser.download.dir'] = downloadDirectory
					options.preferences['browser.download.folderList'] = 2
					options.preferences['browser.helperApps.neverAsk.saveToDisk'] = 'text/csv,text/xlsx,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
					return options
				}
			})
			// require('@cypress/code-coverage/task')(on, config) //descomentar quando o time front instrumentar a aplicação
			on('file:preprocessor', cucumber())

			return config
		},
		specPattern: "**/*.feature",
		experimentalWebKitSupport: true,
	},
});