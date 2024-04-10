import managementElements from '../elements/management'
import projectElements from '../elements/models/myprojects'
const ProjectElements = new projectElements
const ManagementElements = new managementElements

class management {

	checkUserAuthority(user,authority) {
		cy.intercept('GET', '**/v1/users?**').as('readUsers')
		cy.get(ProjectElements.nextPageButton()).then(($next) => {
			let found = false;
			for (let index = 0; index < parseInt($next.eq(4).text()); index++) {
				cy.get(ManagementElements.usersTable()).find('td').then(($user) => {
					for (let usr = 0; usr < $user.length; usr++) {
						if ($user.eq(usr).text() == Cypress.env(user)) {
							expect($user.eq(usr).text()).contains(Cypress.env(user))
							expect($user.eq(usr).parents('tr').children().last().text()).contains(authority)
							found = true
						}
					}
					if (found == false) {
						cy.get($next.eq(5)).should('be.enabled').click()
						cy.wait('@readUsers')
					}
				})
			}
		})
	}

	clickUserControlMenu(){
		cy.intercept("GET", "**/users**").as("listUser")
		cy.get(ManagementElements.accessControlUsersButton()).click()
	}

	clickAddUser(){
		cy.get(ManagementElements.createUsersButton()).click()
	}

	insertNewUser(){
		const uuid = () => Cypress._.random(0, 1e6)
		const id = uuid()
		cy.get(ManagementElements.emailUsersInput()).type(`user-${id}@4intelligence.com.br`,{log:false})
	}

	registerNewUser(){
		cy.intercept("POST", "**/users**").as("createUser")
		cy.get(ManagementElements.registerUserButton()).click()
		cy.wait('@createUser')
	}
	
	clickOKButton(){
		cy.get(ManagementElements.okUserButton()).click()
	}

	clickBlockAllUsers(type){
		cy.get(ProjectElements.nextPageButton()).then(($last) => {
			for (let last = 1; last <= parseInt($last.eq($last.length-2).text()); last++) {
				cy.get(ManagementElements.userCreated()).then(($activeUser) => {
					for (let index = 0; index < $activeUser.length; index++) {
						if($activeUser.eq(index).find('p').text() == type){
							cy.get($activeUser.eq(index).find('p')).parent().find('svg').click()
							cy.get(ManagementElements.blockedUserButton('blocked')).click()
							cy.wait('@listUser')
						}
					}
				})
				cy.get(ManagementElements.nextButton()).then(($next) => {
					if($next.is(':enabled')){
						cy.get($next).click()
						cy.wait('@listUser')
					}
				})
			}
		})
	}

	checkManagerUser(user){
		cy.wait('@listUser')
		if(user == 'manager')
			cy.get('td').should('not.contain',Cypress.env('manager_user'))
		else if(user == 'manager_read_project')
			cy.get('td').should('not.contain',Cypress.env('manager_read_project_user'))
	}

	checkLicenseValue(value){
		cy.get(ManagementElements.remainingLicensetext()).find('b').then(($license) => {
			assert.equal($license.text(), value)
		})
	}

	checkDisabledCreateUser(){
		cy.get(ManagementElements.createUsersButton()).should('be.disabled')
	}

	blockedListUserRequest(){
		cy.intercept('GET',
			'**/users**',
			{ forceNetworkError: true }
		).as('brokeListUserRequest')
	}

	createNewCustomer(){
		const id = Cypress._.random(0, 1e6)
		cy.wrap(`${id}-customer`).as('newCustomer')
		cy.get(ManagementElements.createCustomerButton()).click()
		cy.get(ManagementElements.nameCustomerField()).type(`${id}-customer`)
		cy.get(ManagementElements.licensesCustomerField()).type('3')
		cy.get(ManagementElements.fsCheckBoxPermission()).siblings('span').click()
		cy.get(ManagementElements.registerUserButton()).click()
	}

	editLicense(){
		cy.intercept('PATCH', '**api/v2/clients/**').as('editLicense')
		cy.get(ManagementElements.editCustomerLicense()).first().click()
		cy.get(ManagementElements.licensesCustomerField()).clear()
		cy.get(ManagementElements.licensesCustomerField()).type('2')
		cy.get(ManagementElements.confirmButton()).click()
		cy.wait('@editLicense')
	}

	insertNewManager(){
		cy.intercept('POST', '**/managers').as('inserManager')
		cy.get('@newCustomer').then(newCustomer => {
			cy.get(ManagementElements.editManagerUser()).first().click()
			cy.get(ManagementElements.addManagerButton()).click()
			cy.get(ManagementElements.emailManagerCustomerField()).type(`${newCustomer}@test4i.com`)
			cy.get(ManagementElements.confirmButton()).click()
		})
		cy.wait('@inserManager')
	}

	deleteManager(){
		cy.get(ManagementElements.editManagerUser()).first().click()
		cy.get(ManagementElements.deleteManager()).click()
		cy.get(ManagementElements.confirmDeleteManager()).click()
	}

	enterVisualizeCustomer(){
		cy.get(ManagementElements.visualizCustomerButton()).first().click()
	}

	backCustomerList(){
		cy.get(ManagementElements.backCustomerListBUtton()).click()
	}
}
export default management;