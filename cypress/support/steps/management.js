import management from '../pageobjects/management'

const Management = new management

Then("it should be possible to find {string} with {string} authority", (user,authority) => {
	Management.checkUserAuthority(user,authority);
})

Given("access user control", () => {
	Management.clickUserControlMenu();
})

When("add new user", () => {
	Management.clickAddUser();
	Management.insertNewUser();
	Management.registerNewUser();
	Management.clickOKButton();
})

And("block all users {string}", (type) => {
	Management.clickBlockAllUsers(type);
})

Then("it should be check the {string} license value", (value) => {
	Management.checkLicenseValue(value);
})

Then("it should be not list {string}", (manager) => {
	Management.checkManagerUser(manager);
})

Then("it should not be possible to create new user", (manager) => {
	Management.checkDisabledCreateUser();
})

Given("error in list users request", (manager) => {
	Management.blockedListUserRequest();
})

And("create new customer", () => {
	Management.createNewCustomer();
})

And("edit license", () => {
	Management.editLicense();
})

And("insert new manager in created Group", () => {
	Management.insertNewManager();
})

And("delete manager", () => {
	Management.deleteManager()
})

And("enter visualize customer page", () => {
	Management.enterVisualizeCustomer()
})

And("back to customer list page", () => {
	Management.backCustomerList()
})