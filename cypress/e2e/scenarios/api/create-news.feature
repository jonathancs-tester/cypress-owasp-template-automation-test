@4INTELLIGENCE @API @SCENARIOS @REGRESSION @CREATE_NEWS @CRUD
Feature: Scenarios create news

#200
	@SANITY
	Scenario: Get news by api success
		Given insert "editor" credentials and login via "MFA"
        And create a "text" news by api with "title test get text" title in "varejo" section "success" result
		Then get all news in "varejo" section "success" result
		And save uuid from "title test get text" news in "varejo" section
		And get the "title test get text" by uuid in "varejo" section "success" result
		And delete the news by api with "title test get text" title in "varejo" section "success" result

	@SANITY
	Scenario: Delete news by api success
		Given insert "editor" credentials and login via "MFA"
        And create a "text" news by api with "title test delete text" title in "credito" section "success" result
		And save uuid from "title test delete text" news in "credito" section
		Then delete the news by api with "title test delete text" title in "credito" section "success" result

	@SANITY
	Scenario: Update news by api success
		Given insert "editor" credentials and login via "MFA"
        And create a "text" news by api with "title test update text" title in "inflacao" section "success" result
		And save uuid from "title test update text" news in "inflacao" section
		When update the news by api from "title test update text" to "new update title text" title from "inflacao" to "politica" section "success" result
		Then check if "new update title text" exists in "politica" section "success" result
		And delete the news by api with "new update title text" title in "politica" section "success" result

	@SANITY
	Scenario: Upload image by api success
		Given insert "editor" credentials and login via "MFA"
		Then upload the image "scenarios/img_correct.png" by api "success" result

	Scenario: Get news not found
		Given insert "editor" credentials and login via "MFA"
		Then get all news in "invalid" section "not found" result
		And check if "title not found" exists in "pib" section "not found" result

#201
	@SANITY
	Scenario Outline: Create news by api success
		Given insert "editor" credentials and login via "MFA"
        When create a "<type>" news by api with "<title>" title in "<section>" section "success" result
		Then check if "<title>" exists in "<section>" section "success" result
		And save uuid from "<title>" news in "<section>" section
		And delete the news by api with "<title>" title in "<section>" section "success" result

		Examples: 
			| type	| title				| section	|
			| text	| title test text	| pib		|
			| chart	| title test chart	| industria	|
			| image	| title test image	| emprego	|

#400
	Scenario: Create news by api invalid series
		Given insert "view" credentials and login via "MFA"
        And create a "text" news by api with "test bad request" title in "pib" section "success" result
		And save uuid from "test bad request" news in "pib" section
        Then create a "chart" news by api with "bad request" title in "pib" section "bad request" result
        And create a "text" news by api with "bad request" title in "pib" section "bad request" result
		And update the news by api from "test bad request" to "bad request" title from "pib" to "politica" section "bad request" result

#401
	@F4-1432
	Scenario: Access endpoints without auth @F4-1432
		Given insert "editor" credentials and login via "MFA"
        And create a "text" news by api with "test endpoints without auth" title in "pib" section "unauthorized-without" result
		When save uuid from "test endpoints without auth" news in "pib" section
		Then get all news in "pib" section "unauthorized-without" result
		And get the "test endpoints without auth" by uuid in "pib" section "unauthorized-without" result
		And delete the news by api with "test endpoints without auth" title in "pib" section "unauthorized-without" result
		And update the news by api from "test endpoints without auth" to "fail update unauthorized-without" title from "pib" to "politica" section "unauthorized-without" result
		And upload the image "scenarios/img_correct.png" by api "unauthorized-without"
        And create a "text" news by api with "fail without auth" title in "pib" section "unauthorized-without" result

	Scenario: Access endpoints invalid auth
		Given insert "editor" credentials and login via "MFA"
        And create a "text" news by api with "test endpoints without auth" title in "pib" section "unauthorized-invalid" result
		When save uuid from "test endpoints without auth" news in "pib" section
		Then get all news in "pib" section "unauthorized-invalid" result
		And get the "test endpoints without auth" by uuid in "pib" section "unauthorized-invalid" result
		And delete the news by api with "test endpoints without auth" title in "pib" section "unauthorized-invalid" result
		And update the news by api from "test endpoints without auth" to "fail update unauthorized-invalid" title from "pib" to "politica" section "unauthorized-invalid" result
		And upload the image "scenarios/img_correct.png" by api "unauthorized-invalid" result
        And create a "text" news by api with "fail without auth" title in "pib" section "unauthorized-invalid" result

#403
	@F4-1428	
	Scenario: Create news by api forbidden @F4-1428
		Given insert "view" credentials and login via "MFA"
        When create a "text" news by api with "forbidden" title in "pib" section "forbidden" result

#404
	Scenario: Components not found
		Given insert "editor" credentials and login via "MFA"
		Then get the "title not found" by uuid in "pib" section "not found" result
		And delete the news by api with "title not found" title in "pib" section "not found" result
		And update the news by api from "title not found" to "fail update title not found" title from "pib" to "politica" section "not found" result

#413
	Scenario: Upload large image
		Given insert "editor" credentials and login via "MFA"
		Then upload the image "scenarios/img_5mb.jpg" by api "payload too large" result
