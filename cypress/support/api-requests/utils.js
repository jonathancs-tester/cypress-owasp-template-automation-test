class utils {
    legacyDefaultAPIConfig(method, endpoint, body_request, auth, baseUrl, contentType, isRequested = false) {
        const options = {
            method: method,
            endpoint: endpoint,
            body_request: body_request,
            auth: auth,
            baseUrl: baseUrl,
            contentType: contentType,
            isRequested: isRequested,
        };
        this.defaultAPIConfig(options);
    }
	
	defaultAPIConfig(options){
		const {
            method,
            endpoint,
            body_request,
            auth,
            baseUrl,
            contentType,
            isRequested = false,
            isFSIntegration = false,
        } = options;

		var url = `${Cypress.env('apiBaseUrl')}`+endpoint
		var headers_request = {
			'Authorization': auth
		}
		if(baseUrl == 'data-loader')
			url = `${Cypress.env('apiBaseUrlSeries')}`+endpoint
		else if(baseUrl == 'modelingAPI')
			url = `${Cypress.env('modelingAPIBaseurl')}`+endpoint
		else if(baseUrl == 'pick4Me')
			url = `${Cypress.env('apiPick4MeUrl')}`+endpoint
		else if(typeof(baseUrl) !== "undefined" && baseUrl.includes('TIMESERIES')){
			url = `${Cypress.env('apiBaseUrlFS')}`+endpoint
			isFSIntegration = true
		}
		
		if(contentType != null){
			headers_request =  {
				'Authorization': auth,
				'Content-Type' : contentType
			}
		}
		const requestFunction = isRequested ? cy.request : cy.api;

        requestFunction({
            method,
            url,
            headers: headers_request,
            body: body_request,
            failOnStatusCode: false,
            timeout: 600000,
        }).then((response) => {
			if(baseUrl != 'data-loader'){
				if(Cypress.env('feature').includes('FEATURE_STORE') || isFSIntegration){
					expect(response.headers).to.have.property('content-security-policy',"default-src 'self'; base-uri 'self'; block-all-mixed-content; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; img-src 'self' data: validator.swagger.io; script-src 'self' 'unsafe-inline'; form-action 'self'; frame-ancestors 'self'; font-src 'self' https://fonts.gstatic.com")
					expect(response.headers).to.have.property('x-xss-protection', '1; mode=block')
				}
				else{
					expect(response.headers).to.have.property('content-security-policy', "default-src 'self'; base-uri 'self'; block-all-mixed-content; style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net/npm/swagger-ui-dist@3/swagger-ui.css; img-src https://fastapi.tiangolo.com/img/favicon.png data:; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net/npm/swagger-ui-dist@3/swagger-ui-bundle.js 'sha256-R2r7jpC1j6BEeer9P/YDRn6ufsaSnnARhKTdfrSKStk='; form-action 'self'; frame-ancestors 'self'")
					expect(response.headers).to.have.property('referrer-policy', 'strict-origin-when-cross-origin')
				}
				expect(response.headers).to.have.property('cache-control', 's-maxage=600, public')
				expect(response.headers).to.have.property('x-content-type-options', 'nosniff')
				expect(response.headers).to.have.property('x-frame-options', 'DENY')
			}
			cy.wrap(response).as('responseBody')
		})
	}
}
export default utils;