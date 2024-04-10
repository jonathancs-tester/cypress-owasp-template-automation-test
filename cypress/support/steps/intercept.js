import interceptRoute from '../components/intercept'

const InterceptRoute = new interceptRoute

And(/I intercept "(.+)" route as "(.+)" with "(.+)" http verbs/, (routes, alias, httpVerbs) => {
	InterceptRoute.interceptRoute(routes, alias, httpVerbs);
})

And(/I wait "(.+)" routes/, (alias) => {
	InterceptRoute.waitRoute(alias);
})

And(/I check "(.+)" is (equal to|greater than|less than) [-+]?\d+(\.\d+)? in response/, (propertyName, compare, value) => {
	InterceptRoute.checkProperty(propertyName, compare, parseFloat(value));
})