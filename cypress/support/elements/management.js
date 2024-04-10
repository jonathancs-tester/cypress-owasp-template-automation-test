class managementElements {

	usersTable = () =>  {return '[data-testid="table-myprojects"]'}
	usersInfoTable = (info) =>  {return '[data-testid="'+info+'"]'}
	nextButton = () => { return '[data-testid="page-button-next"]'}
	accessControlUsersButton = () => { return '[data-cy="link-admin"]'}
	createCustomerButton = () => { return '[data-testid="button-register-customer"]'}
	nameCustomerField = () => { return '[data-cy="Name"]'}
	licensesCustomerField = () => { return '[data-cy="Number-of-licenses"]'}
	emailManagerCustomerField = () => { return '[data-cy="Manager-user-email"]'}
	accessProductToggle = () => { return '[data-cy="toggle-switch-manager-access"]'}
	registerUserButton = () => { return '[data-testid="button-register"]'}
	okUserButton = () => { return '[data-cy="button-ok"]'}
	cancelUserButton = () => { return '[data-testid="button-cancel"]'}
	remainingLicensetext = () => { return '[data-testid="text-remaining-licenses"]'}
	infoUserTable = () => { return '[data-testid^="user-"]'}
	blockedUserButton = (status) => { return '[data-testid="status-option-'+status+'"]'}
	createUsersButton = () => { return '[data-cy="button-invite-new-user"]'}
	emailUsersInput = () => { return '[data-cy="E-mail"]'}
	userCreated = () => { return '[data-testid^=user-"]'}
	editCustomerLicense = () => {return '[data-cy^="button-edit-"]'}
	confirmButton = () => {return '[data-cy="button-confirm"]'}
	editManagerUser = () => {return '[data-cy^="button-manager-"]'}
	addManagerButton = () => {return '[data-testid="buttonAddManager"]'}
	deleteManager = () => {return '[data-testid^="delete-manager-"]'}
	confirmDeleteManager = () => {return '[data-cy="button-confirm-delete-manager"]'}
	visualizCustomerButton = () => {return '[data-testid^="button-visualize-"]'}
	fsCheckBoxPermission = () => {return '[data-cy="checkbox-feature-store"]'}
	backCustomerListBUtton = () => {return '[data-cy="back-button"]'}
}
export default managementElements;
