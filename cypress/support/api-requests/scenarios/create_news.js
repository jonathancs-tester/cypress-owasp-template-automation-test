/// <reference types="Cypress" />

class createNewsApiRequest {

    createTextNews(title, section, result){
        if(result=="success"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                body:{
                    author: "editorInfo",
                    title: title,
                    layout: "TextOnly",
                    news_text: "BodyInfo",
                    section: section,
                    series_initial_date: "2021-05-25",
                } 
            }).then((response) => {
                expect(response.status).to.equal(201)
                expect(response.duration).lessThan(10000)
                expect(response.body[0].deleted).to.equal(false)
                expect(response.body[0].author).to.equal("editorInfo")
                expect(response.body[0].title).to.equal(title)
                expect(response.body[0].layout).to.equal("TextOnly")
                expect(response.body[0].news_text).to.equal("BodyInfo")
                expect(response.body[0].section).to.equal(section)
                expect(response.body[0].series_initial_date).to.equal("2021-05-25")
            })
        } else if(result=="unauthorized-invalid"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': "invalid"
                },
                body:{
                    author: "editorInfo",
                    title: title,
                    layout: "TextOnly",
                    news_text: "BodyInfo",
                    section: section,
                    series_initial_date: "2021-05-25",
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401)
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="unauthorized-without"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {},
                body:{
                    author: "editorInfo",
                    title: title,
                    layout: "TextOnly",
                    news_text: "BodyInfo",
                    section: section,
                    series_initial_date: "2021-05-25",
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401)
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="forbidden"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': window.localStorage.getItem('accessToken')
                },
                body:{
                    author: "forbidden",
                    title: title,
                    layout: "TextOnly",
                    news_text: "BodyInfo",
                    section: section,
                    series_initial_date: "2021-05-25",
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(403)
                expect(response.duration).lessThan(10000)
            })
        }
    }

    createChartNews(title, section, result){
        if(result=="success"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                body:{
                    author: "editorInfo",
                    chartType: "bar",
                    layout: "TextChart",
                    news_text: "BodyInfo",
                    section: section,
                    series: "BRGDP0013000ROQL",
                    series_elaboration: "elaborationInfo",
                    series_initial_date: "2021-05-25",
                    series_projection: "projectionInfo",
                    series_source: "sourceInfo",
                    title: title,
                } 
            }).then((response) => {
                expect(response.status).to.equal(201);
                expect(response.duration).lessThan(10000)
                expect(response.body[0].deleted).to.equal(false)
                expect(response.body[0].author).to.equal("editorInfo")
                expect(response.body[0].title).to.equal(title)
                expect(response.body[0].layout).to.equal("TextChart")
                expect(response.body[0].news_text).to.equal("BodyInfo")
                expect(response.body[0].section).to.equal(section)
                expect(response.body[0].series_initial_date).to.equal("2021-05-25")
                expect(response.body[0].chartType).to.equal("bar")
                expect(response.body[0].series).to.equal("BRGDP0013000ROQL")
                expect(response.body[0].series_elaboration).to.equal("elaborationInfo")
                expect(response.body[0].series_projection).to.equal("projectionInfo")
                expect(response.body[0].series_source).to.equal("sourceInfo")
            })
        } else if(result=="bad request"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                body:{
                    author: "editorInfo",
                    chartType: "bar",
                    layout: "TextChart",
                    news_text: "BodyInfo",
                    section: section,
                    series: "invalid series",
                    series_elaboration: "elaborationInfo",
                    series_initial_date: "2021-05-25",
                    series_projection: "projectionInfo",
                    series_source: "sourceInfo",
                    title: title,
                }, 
                failOnStatusCode: false,
            }).then((response) => {
                expect(response.status).to.equal(400)
                expect(response.duration).lessThan(10000)
                expect(response.body.detail[0].loc[0]).to.equal("body")
                expect(response.body.detail[0].loc[1]).to.equal("series")
                expect(response.body.detail[0].msg).to.eql("series must be 16 digits.")
                expect(response.body.detail[0].type).to.eql("assertion_error")
            })
        } else if(result=="unauthorized-invalid"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': 'invalid'
                },
                body:{
                    author: "editorInfo",
                    chartType: "bar",
                    layout: "TextChart",
                    news_text: "BodyInfo",
                    section: section,
                    series: "BRGDP0013000ROQL",
                    series_elaboration: "elaborationInfo",
                    series_initial_date: "2021-05-25",
                    series_projection: "projectionInfo",
                    series_source: "sourceInfo",
                    title: title,
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="unauthorized-without"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {},
                body:{
                    author: "editorInfo",
                    chartType: "bar",
                    layout: "TextChart",
                    news_text: "BodyInfo",
                    section: section,
                    series: "BRGDP0013000ROQL",
                    series_elaboration: "elaborationInfo",
                    series_initial_date: "2021-05-25",
                    series_projection: "projectionInfo",
                    series_source: "sourceInfo",
                    title: title,
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        }
    }

    createImageNews(title, section, result){
        if(result=="success"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                body:{
                    author: "editorInfo",
                    title: title,
                    layout: "TextImage",
                    news_text: "BodyInfo",
                    section: section,
                    series_initial_date: "2021-05-25",
                    series_source: "sourceInfo",
                    image_url: "https://saoseba.blob.core.windows.net/jureia/2fc95a01-5f19-46e9-99be-633c89daf61e.png",
                } 
            }).then((response) => {
                expect(response.status).to.equal(201);
                expect(response.duration).lessThan(10000)
                expect(response.body[0].deleted).to.equal(false)
                expect(response.body[0].author).to.equal("editorInfo")
                expect(response.body[0].title).to.equal(title)
                expect(response.body[0].layout).to.equal("TextImage")
                expect(response.body[0].news_text).to.equal("BodyInfo")
                expect(response.body[0].section).to.equal(section)
                expect(response.body[0].series_initial_date).to.equal("2021-05-25")
                expect(response.body[0].series_source).to.equal("sourceInfo")
                expect(response.body[0].image_url).to.equal("https://saoseba.blob.core.windows.net/jureia/2fc95a01-5f19-46e9-99be-633c89daf61e.png")
            })
        } else if(result=="bad request"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                body:{
                    author: "editorInfo",
                    title: title,
                    layout: "TextImage",
                    news_text: "BodyInfo",
                    section: section,
                    series_initial_date: "2021-05-25",
                    series_source: "sourceInfo",
                } 
            }).then((response) => {
                expect(response.status).to.equal(400);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail[0].loc[0]).to.equal("body")
                expect(response.body.detail[0].loc[1]).to.equal("series")
                expect(response.body.detail[0].msg).to.eql("series must be 16 digits.")
                expect(response.body.detail[0].type).to.eql("assertion_error")            })
        } else if(result=="unauthorized-invalid"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {
                    'token': 'invalid'
                },
                body:{
                    author: "editorInfo",
                    title: title,
                    layout: "TextImage",
                    news_text: "BodyInfo",
                    section: section,
                    series_initial_date: "2021-05-25",
                    series_source: "sourceInfo",
                    image_url: "https://saoseba.blob.core.windows.net/jureia/2fc95a01-5f19-46e9-99be-633c89daf61e.png",
                } 
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="unauthorized-without"){
            cy.api({
                method: 'POST',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news`,
                headers: {},
                body:{
                    author: "editorInfo",
                    title: title,
                    layout: "TextImage",
                    news_text: "BodyInfo",
                    section: section,
                    series_initial_date: "2021-05-25",
                    series_source: "sourceInfo",
                    image_url: "https://saoseba.blob.core.windows.net/jureia/2fc95a01-5f19-46e9-99be-633c89daf61e.png",
                } 
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        }
    }

    uploadImage(fileName, result){
        if(result=="success"){
            cy.fixture(fileName, 'binary')
                .then((file) => Cypress.Blob.binaryStringToBlob(file, 'image/png'))
                .then((blob) => {
                var formData = new FormData();
                formData.append('file', blob);
                cy.api({
                    method: 'POST',
                    url: `${Cypress.env('apiBaseUrl')}/api/v1/upload`,
                    headers: {
                        'token': `${Cypress.env('tokenScenariosApi')}`,
                    },
                    body: formData
                }).then((response) => {
                    expect(response.status).to.equal(200)
                    expect(response.duration).lessThan(10000)
                })
            })
        } else if(result=="payload too large"){
            cy.fixture(fileName, 'binary')
                .then((file) => Cypress.Blob.binaryStringToBlob(file, 'image/jpg'))
                .then((blob) => {
                var formData = new FormData();
                formData.append('file', blob);
                cy.api({
                    method: 'POST',
                    url: `${Cypress.env('apiBaseUrl')}/api/v1/upload`,
                    headers: {
                        'token': `${Cypress.env('tokenScenariosApi')}`,
                    },
                    body: formData,
                    failOnStatusCode: false
                }).then((response) => {
                    expect(response.status).to.equal(413)
                    expect(response.duration).lessThan(10000)
                })
            })
        } else if(result=="unauthorized-invalid"){
            cy.fixture(fileName, 'binary')
                .then((file) => Cypress.Blob.binaryStringToBlob(file, 'image/png'))
                .then((blob) => {
                var formData = new FormData();
                formData.append('file', blob);
                cy.api({
                    method: 'POST',
                    url: `${Cypress.env('apiBaseUrl')}/api/v1/upload`,
                    headers: {
                        'token': 'invalid'
                    },
                    body: formData,
                    failOnStatusCode: false
                }).then((response) => {
                    expect(response.status).to.equal(401)
                    expect(response.duration).lessThan(10000)
                })
            })
        } else if(result=="unauthorized-without"){
            cy.fixture(fileName, 'binary')
                .then((file) => Cypress.Blob.binaryStringToBlob(file, 'image/png'))
                .then((blob) => {
                var formData = new FormData();
                formData.append('file', blob);
                cy.api({
                    method: 'POST',
                    url: `${Cypress.env('apiBaseUrl')}/api/v1/upload`,
                    headers: {},
                    body: formData,
                    failOnStatusCode: false
                }).then((response) => {
                    expect(response.status).to.equal(401)
                    expect(response.duration).lessThan(10000)
                })
            })
        }
    }
    
    getNews(title, section, result){
        if(result=="success"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
            }).then((response) => {
                var expectTitle = "Título não encontrado"
                for (let index = 0; index < response.body.length; index++) {
                    const titleNews = response.body[index].title
                    if(titleNews.toString()==title){
                        expectTitle="Título encontrado"
                    }
                }
                expect(response.status).to.equal(200);
                expect(expectTitle).to.equal("Título encontrado")
                expect(response.duration).lessThan(10000)
            })
        } else if(result=="not found"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
            }).then((response) => {
                var expectTitle = "Título não encontrado"
                for (let index = 0; index < response.body.length; index++) {
                    const titleNews = response.body[index].title
                    if(titleNews.toString()==title){
                        expectTitle="Título encontrado"
                    }
                }
                expect(response.status).to.equal(200);
                expect(expectTitle).to.equal("Título não encontrado")
                expect(response.duration).lessThan(10000)
            })
        } else if(result=="unauthorized-invalid"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
                headers: {
                    'token': 'invalid'
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="unauthorized-without"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
                headers: {},
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        }
    }

    getAllNewsinSection(section, result){
        if(result=="success"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
            }).then((response) => {
                expect(response.status).to.equal(200)
                expect(response.duration).lessThan(10000)
                expect(response.body).exist
            })
        } else if(result=="not found"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
            }).then((response) => {
                expect(response.status).to.equal(200)
                expect(response.duration).lessThan(10000)
                expect(response.body).to.be.empty
            })
        } else if(result=="unauthorized-invalid"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
                headers: {
                    'token': 'invalid'
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="unauthorized-without"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
                headers: {},
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        }
    }

    saveUuidNewsinSection(title, section){
        cy.api({
            method: 'GET',
            url: `${Cypress.env('apiBaseUrl')}/api/v1/news?section=`+section,
            headers: {
                'token': `${Cypress.env('tokenScenariosApi')}`
            },
        }).then((response) => {
            var uuid = "Título não encontrado"
            for (let index = 0; index < response.body.length; index++) {
                const titleNews = response.body[index].title
                if(titleNews.toString()==title){
                    uuid=response.body[index].uuid
                    window.sessionStorage.setItem('uuid', uuid)
                }
            }
        })
    }

    getNewsByUuid(title, section, result){
        var uuid = window.sessionStorage.getItem('uuid')
        if(result=="success"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
            }).then((response) => {
                expect(response.status).to.equal(200)
                expect(response.duration).lessThan(10000)
                expect(response.body[0].uuid).to.equal(uuid)    
                expect(response.body[0].title).to.equal(title)    
                expect(response.body[0].section).to.equal(section)    
            })
        } else if(result=="not found"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/invaliduuid`,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(404)
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal("The server can not find the requested resource.")
            })
        } else if(result=="unauthorized-invalid"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {
                    'token': 'invalid'
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="unauthorized-without"){
            cy.api({
                method: 'GET',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {},
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        }
    }

	deleteNews(title, section, result){
        var uuid = window.sessionStorage.getItem('uuid')
        if(result=="success"){
            cy.api({
                method: 'DELETE',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
            }).then((response) => {
                expect(response.status).to.equal(200);
                expect(response.duration).lessThan(10000)
                expect(response.body[0].deleted).to.equal(true)
                expect(response.body[0].title).to.equal(title)
                expect(response.body[0].section).to.equal(section)
            })
        } else if(result=="not found"){
            cy.api({
                method: 'DELETE',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/invaliduuid`,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(404);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal("The server can not find the requested resource.")
            })
        } else if(result=="unauthorized-invalid"){
            cy.api({
                method: 'DELETE',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {
                    'token': 'invalid'
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="unauthorized-without"){
            cy.api({
                method: 'DELETE',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {},
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        }
	}

    updateNews(oldTitle, newTitle, oldSection, newSection, result){
        var uuid = window.sessionStorage.getItem('uuid')
        if(result=="success"){
            cy.api({
                method: 'PUT',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                body: {
                    author: "editor updated",
                    chartType: "line",
                    layout: "TextChart",
                    news_text: "body updated",
                    section: newSection,
                    series: "BRGDP0013000ROQL",
                    series_elaboration: "elaboration updated",
                    series_initial_date: "2021-05-26",
                    series_projection: "projection updated",
                    series_source: "source updated",
                    title: newTitle,
                }
            }).then((response) => {
                expect(response.status).to.equal(200);
                expect(response.duration).lessThan(10000)
                expect(response.body[0].deleted).to.equal(false)
                expect(response.body[0].author).to.equal("editor updated")
                expect(response.body[0].title).to.equal(newTitle)
                expect(response.body[0].layout).to.equal("TextChart")
                expect(response.body[0].news_text).to.equal("body updated")
                expect(response.body[0].section).to.equal(newSection)
                expect(response.body[0].series_initial_date).to.equal("2021-05-26")
                expect(response.body[0].chartType).to.equal("line")
                expect(response.body[0].series).to.equal("BRGDP0013000ROQL")
                expect(response.body[0].series_elaboration).to.equal("elaboration updated")
                expect(response.body[0].series_projection).to.equal("projection updated")
                expect(response.body[0].series_source).to.equal("source updated")
            })
        } else if(result=="bad request"){
            cy.api({
                method: 'PUT',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                body: {
                    author: "editor updated",
                    chartType: "line",
                    layout: "TextChart",
                    news_text: "body updated",
                    section: newSection,
                    series: "invalid series",
                    series_elaboration: "elaboration updated",
                    series_initial_date: "2021-05-26",
                    series_projection: "projection updated",
                    series_source: "source updated",
                    title: newTitle,
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(400);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail[0].loc[0]).to.equal("body")
                expect(response.body.detail[0].loc[1]).to.equal("series")
                expect(response.body.detail[0].msg).to.eql("series must be 16 digits.")
                expect(response.body.detail[0].type).to.eql("assertion_error")                })
        } else if(result=="not found"){
            cy.api({
                method: 'PUT',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/invaliduuid`,
                headers: {
                    'token': `${Cypress.env('tokenScenariosApi')}`
                },
                body: {
                    author: "editor updated",
                    chartType: "line",
                    layout: "TextChart",
                    news_text: "body updated",
                    section: newSection,
                    series: "BRGDP0013000ROQL",
                    series_elaboration: "elaboration updated",
                    series_initial_date: "2021-05-26",
                    series_projection: "projection updated",
                    series_source: "source updated",
                    title: newTitle,
                }, 
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(404)
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal("The server can not find the requested resource.")
            })
        } else if(result=="unauthorized-invalid"){
            cy.api({
                method: 'PUT',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {
                    'token': 'invalid'
                },
                body: {
                    author: "editor updated",
                    chartType: "line",
                    layout: "TextChart",
                    news_text: "body updated",
                    section: newSection,
                    series: "BRGDP0013000ROQL",
                    series_elaboration: "elaboration updated",
                    series_initial_date: "2021-05-26",
                    series_projection: "projection updated",
                    series_source: "source updated",
                    title: newTitle,
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        } else if(result=="unauthorized-without"){
            cy.api({
                method: 'PUT',
                url: `${Cypress.env('apiBaseUrl')}/api/v1/news/`+uuid,
                headers: {},
                body: {
                    author: "editor updated",
                    chartType: "line",
                    layout: "TextChart",
                    news_text: "body updated",
                    section: newSection,
                    series: "BRGDP0013000ROQL",
                    series_elaboration: "elaboration updated",
                    series_initial_date: "2021-05-26",
                    series_projection: "projection updated",
                    series_source: "source updated",
                    title: newTitle,
                },
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(401);
                expect(response.duration).lessThan(10000)
                expect(response.body.detail).to.equal('The client must authenticate itself to get the requested response.')
            })
        }
    }

}
export default createNewsApiRequest;

