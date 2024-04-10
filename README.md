# 4casthub-automation-test
UI and API Automation tests for 4CastHUB

# API Testing with Docker

## Requirements
Before to start to understand how the tests work it's necessary to have docker dependencies installed in your machine and some configurations at QMetry plugin realized.

#### QMetry
Each QMetry project have their own configurations and they are responsible to define some important parameters at the test report upload. 
At QMetry access the Configuration page localized inside the project whose tests will be runned. It's needed to create Labels, Environment and Build parameters.

In Labels is usual to create the following labels: 'API', 'Postman' and 'Project Name'.
In Environment it it necessary to register the test server URL and finally in Build we register the version which will be tested.

Access the Automation page still localized at the QMetry's project and save the API Key parameter. This key will used at nexts steps.


#### Docker dependencies
Verify all docker dependencies is installed correctly.
If docker isn't installed yet it's possible to do this throught the following links:

1- [Install Docker](https://docs.docker.com/engine/install/ubuntu/)

2- [Install Docker Compose](https://docs.docker.com/compose/install/)

If you don't know if the machine already has all dependencies installed run the following commands:

```
docker -v //docker version will be printed

and

docker-compose -v //docker compose version will be printed

```

#### Test environment
Our project has a folder called 'collection' in which we save the test collection that will be runned. So before start the tests is important to verify is the file is there.

We also have a file called '.env' whose mainly function is to set all environments configurations. It is divided in 'Postman Settings' and 'QMetry Settings'.

**Usually all this environments informations are given for us testers by the development team.**

##### Postman Settings has only two parameters: 

1- AUTH: all requests require a token to works properly. We save this token here at AUTH parameter.

2- BASEURL: as well as the mentioned token previously, all requests are sent to a specify URL. This URL is called 'baseURL' and is saved here at BASEURL parameter.

3- FEATURE_NAME: This parameter defines which feature available, i.e, cenarios, faas, and etc.

4- PROJECT_NAME: This parameter defines which project available, i.e, 4casthub, and in the future geocast.

_If you don't have this parameters on your hands yet open your postman collection, access the 'three point' icon, choose 'Edit' option and finally access the 'Variables' tab. There will be saved all essential parameteres that are required to the successfully sent._

In some cases we run a collection which has a particular environment. The collection enviroment is a file (postman environment file) containing all relevant collections' information. So it is important to verify if all mandatory environment variables are configurated porperly.

##### Cypress Settings

Here we must to configure:

1- BASEURL: as well as the mentioned token previously, all requests are sent to a specify URL. This URL is called 'baseURL' and is saved here at BASEURL parameter.

2- FEATURE: This parameter defines which kind of test will be runned: sanity or regression test that respect to user needs, requirements, and business processes conducted to determine whether or not a system satisfies the acceptance criteria, i.e LOGIN, SANITY, and REGRESSION. PS: The test type must to be in uppercase.

3- DEVICE: This parameter define device type where the automation ui tests will be executed, i.e web, android or ios.

4- BROWSER: A web browser, or simply "browser," is an application used to access and view websites. This parameter defines which device type that your test will be executed, i.e chrome and firefox.

5- MODE: This information provide automated control of a web page in an environment similar to popular web browsers, i.e gui or headless.A headless browser is a web browser without a graphical user interface and they are executed via a command-line interface or using network communication.

##### QMetry Settings

Here we must to configure:

1- TESTCYCLE_SUMMARY: test cycle's name that will registered in QMetry after the report upload.

2- BUILD: build version registered previously.

3- APIKEY: that's the most important parameter. Here we save the key mentioned above. Each project has their own API key. This parameter must be changed every time you need to run a differente project.

4- TEST_TYPE: This parameter defines which kind of test will be runned: sanity or regression tests. The test type must to be in lowercase ('regression' or 'sanity' for example).

### Docker Services

Our project already has some services configured. All they are in 'docker-compose' file and are divided in API and UI services. 

#### API
Some API services examples:

```
4hub-postman-api-sanity //sanities tests runner 

4hub-postman-api-regression //regression tests runner

4hub-api-test //test (sanity or regression) runner and report upload

4hub-zap-security-api-test //security tests (Owasp Zap)

4hub-nikto-security-api-test //security tests (nikto)
```

#### UI
Some UI services examples:

```
4hub-e2e-test //test runner and report upload

```


### Before Test
Before run the tests the user must to run a script responsible to delete all previous reports:

```
npm run pretest
```

## Testing

At the first time we run a specific test it is needed to build its image firstly. We can do this running the following command:

```
docker-compose up --build {service_name} 
```

After we already can run the tests:

*Remember to run pre test command before execute the command above*

```
docker-compose up {service_name}
```

### Reports
After run all wished tests two reports are generated: HTML and QMetry reports.
We can also have back and front end reports.
The basic difference is where they are saved. Back end reports are at the 'vli-automation-test/api/reports' directory. Front end reports are at 'vli-automation-test/ui/cypress/reporting' directory.

#### HTML
The HTML report, as its name says, is a report in a HTML format. It is possible to access these informations accesing it's containing folder and then opening the HTML file.

Doing the a HTML page will be opened and all tests information will be displayed: collection info, test summary, requests details, etc.

_HTML reports are just available to API tests._


#### QMetry
It is possible to access the QMetry report too. The user just have to access the project page at QMetry and then access 'Test cycle' tab. There will be all reports generated and its details.

After all tests have been run its reports are generated and will be located at 'reports' folder.

In addiction all tests already have been uploaded at QMetry automatically. To check them you just need to access the test cycle's project tab.

### References
[Postman requests](https://github.com/postmanlabs/postman-app-support/)

[Running collections on the command line with Newman](https://learning.postman.com/docs/running-collections/using-newman-cli/command-line-integration-with-newman/)

[Running K6](https://k6.io/docs/getting-started/running-k6/)

[Getting started with OWASP](https://www.zaproxy.org/getting-started/)

[Docker guide](https://docs.docker.com/get-started/overview/)

[Testing your app with Cypress](https://docs.cypress.io/guides/getting-started/testing-your-app)

[QMetry Test Management](https://www.qmetry.com/qmetry-test-management/)