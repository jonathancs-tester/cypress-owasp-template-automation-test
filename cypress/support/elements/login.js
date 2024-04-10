class loginElements {

	initialButton = () => { return '[type="button"]' }
	emailTextField = () => { return '[type="email"]' }
	passwordTextField = () => { return '[type="password"]' }
	mfaCode = () => { return '[id="code"]' }
	logoutButton = () => { return '[data-cy=button-logout]' }
	signInButton = () => { return '[type="submit"]' }

	//Elements box mapped throught 4CastHub URL
	projectModels = () => { return '[data-cy="container-faas"]' }
	projectFeatureStore = () => { return '[data-cy="container-feature-store"]' }
	projectScenarios = () => {return '[data-cy="container-scenarios"]'}
	faasAccessButton = () => { return '[data-testid="link-faas"]'}
	featureStoreButton = () => {return '[data-testid="link-feature-store"]'}
	faasAccessMenu = () => { return '[data-testid="header-link-faas"]'}
	featureStoreMenu = () => {return '[data-testid="header-link-feature-store"]'}
	scenariosButton = () => {return '[data-testid="link-scenarios"]'}
	featureStoreAdminButton = () => { return '[data-cy="link-admin-fs"]'}
	managementAdminButton = () => { return '[data-cy="link-admin-4casthub"]'}
	accessGroupsButton = () => { return '[data-cy="link-group-access"]'}
}
export default loginElements;