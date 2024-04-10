import interceptRoute from '../components/intercept'

const InterceptRoute = new interceptRoute

And("I intercept {string} route as {string} with {string} http verbs", (routes, alias, httpVerbs) => {
	InterceptRoute.interceptRoute(routes, alias, httpVerbs);
})

And(/I wait "(.+)" routes/, (alias) => {
	InterceptRoute.waitRoute(alias);
})

And(/I check "(.+)" is (equal to|greater than|less than) [-+]?\d+(\.\d+)? in response/, (propertyName, compare, value) => {
	InterceptRoute.checkProperty(propertyName, compare, parseFloat(value));
})

And(/I check if response of "(.+)" route is equal "(.+)"/, (route, status) => {
	InterceptRoute.checkStatusResponse(route, status);
})