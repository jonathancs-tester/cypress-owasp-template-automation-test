import assertions from '../utils/assertions'

const Assertions = new assertions

class interceptRoute {
	interceptRoute(routes, alias, httpVerbs){
		var routeList = routes.split(',')
		var httpVerbsList = httpVerbs.split(',')
		var aliasList = alias.split(',')
		for (let index = 0; index < routeList.length; index++) {
			cy.intercept(httpVerbsList[index], routeList[index]).as(aliasList[index])
		}
	}

	waitRoute(alias){
		var aliasList = alias.split(',')
		cy.wait(aliasList.map(alias => `${alias}`), {timeout: 600000}).then((response) => {
			cy.wrap(Array.isArray(response) ? response : response.response.body).as('responseBody');
		})
	}

	checkProperty(property, compare, value){
		cy.get('@responseBody').then((body) => {
			for(let item of body.data) 
				Assertions.compareInfo(item[property],compare, value)
		})
	}

	checkStatusResponse(route, status){
		cy.wait(route).then(routeResponse => {
			expect(routeResponse.response.statusCode.toString()).to.equal(status)
		})
	}
}
export default interceptRoute;