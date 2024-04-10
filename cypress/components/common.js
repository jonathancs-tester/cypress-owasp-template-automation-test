import download from "./download"
import Elements from "../elements/common"
import assertions from '../utils/assertions'
import dependent_variable from "../elements/time_series/project_results/dependent_variable"

const Assertions = new assertions
const Download = new download

export const elementIsVisible = (id, visible, { template, timeout } = { template: {}, timeout: 60000 }) => {
	if (visible) {
		Elements.get(id, { template, timeout }).should('be.visible')
	} else {
		cy.get(Elements.map(id)).should('not.exist')
	}
}

export const elementIsEmpty = (id, empty, { template, timeout } = { template: {}, timeout: 60000 }) => {
	if (empty) {
		Elements.get(id, { template, timeout }).should('be.empty')
	} else {
		Elements.get(id, { template, timeout }).should('not.be.empty')
	}
}

export const elementHasTextsCount = (id, values, count) => {
	let result = []
	Elements.get(id).each((element) => {
		result.push(values.some((value) => {
			return element.text().includes(value)
		}))
	})
	cy.then(() => {
		let found = result.filter((v) => v).length
		expect(found).to.eq(count)
	})
}

export const elementHasText = (id, text, { template } = { template: {} }) => {
	Elements.get(id, { template }).contains(Elements.template(text))
}

export const attributeValueHasText = (id, text) => {
	cy.get(Elements.map(id)).invoke('attr', 'value').should('eq', text.toString())
}

export const attributeHeightHasText = (id, text, { template } = { template: {} }) => {
	Elements.get(id, { template }).then(($element) => {
		console.log($element)
	})
}

export const elementHasElement = (id, elementID) => {
	cy.get(Elements.map(id)).find(Elements.map(elementID))
}

export const clickVariable = (id, { template } = { template: {} }) => {
	if (id.includes('Download') || id.includes('Export'))
		Download.setConfiguration()

	Elements.get(id, { template }).click();
}

export const clickVariableByName = (id, name) => {
	if (id.includes('Download'))
		Download.setConfiguration()
	cy.get(Elements.map(id)).contains(Elements.template(name)).click()
}

export const openTab = (id, { template } = { template: {} }) => {
	if (id.includes('Download'))
		Download.setConfiguration()
	cy.get(Elements.map(id, { template })).invoke("removeAttr", "target").click()
}

export const setCheckboxValue = (id, value, { template } = { template: {} }) => {
	Elements.get(id, { template }).then((checkbox) => {
		if (value != checkbox.is(':checked')) {
			//TODO: Verificar se futuramente vamos quebrar o checkbox em toggle
			if (id.includes('Checkbox'))
				cy.get(checkbox).siblings('span').click()
			else
				cy.get(checkbox).click()
		}
	})
}

export const selectFrequency = (frequency, element) => {
	cy.get(Elements.map(element)).find(Elements.map(frequency)).click()
}

export const waitElementEnabled = (id, enabled, { template } = { template: {} }) => {
	if (enabled) {
		Elements.get(id, { template }).should('not.have.attr', 'disabled')
	} else {
		Elements.get(id, { template }).should('have.attr', 'disabled')
	}
}

export const getSelectOptions = (id) => {
	let options = []

	cy.get(Elements.map(id)).click()
	cy.get(".select__option").each(($option) => {
		options.push($option.text())
	})
	cy.get(Elements.map(id)).click()
	cy.wrap(options).as("selectOptions")

	return cy.get("@selectOptions")
}

export const selectValue = (id, value, { template } = { template: {} }) => {
	Elements.get(id, {template}).find(".select__dropdown-indicator").click()
	cy.get('.select__menu').contains(value).click()
}

export const selectExactlyValue = (id, value, { template } = { template: {} }) => {
	Elements.get(id, {template}).find(".select__dropdown-indicator").click()
	cy.get('.select__menu').find('.select__option').each(($element) => {
		if($element.text() == value){
			cy.get($element).should('not.have.class','select__option--is-disabled').click()
		}
	})
}

export const getText = (id, { template } = { template: {} }) => {
	let texts = []

	Elements.get(id, { template }).each(($element) => {
		texts.push($element.text())
	})
	cy.wrap(texts).as("texts")

	return cy.get("@texts")
}

export const typeInElement = (value, id, clear, { template } = { template: {} }) => {
	if(clear){
		Elements.get(id, { template }).should('be.visible').clear()
	}
	Elements.get(id, { template }).type(Elements.template(value, template))
}

export const pressButtonSequence = (value, id, { template } = { template: {} }) => {
	Elements.get(id, { template }).type(`{${Elements.template(value, template)}}`)
}

export const attachFixtureInElement = (id, fixture) => {
	if (fixture.includes('rds')) {
		cy.fixture(fixture, 'binary')
			.then(Cypress.Blob.binaryStringToBlob)
			.then(fileContent => {
				cy.get(Elements.map(id)).attachFile({
					fileContent,
					fileName: fixture,
					mimeType: 'application/octet-stream',
					encoding: 'utf-8',
				});
			});
	} else
		cy.get(Elements.map(id)).attachFile(fixture)
}

export const expectCountOfElement = (id, compare, count,  { template } = { template: {} }) => {
	Elements.get(id, { template }).then(($element) => {
		Assertions.compareInfo($element.length, compare, count)
	})
}

export const closeModal = (id) => {
	cy.get('body').then(($body) => {
		if ($body.find(Elements.map(id)).length > 0)
			cy.get(Elements.map(id)).click()
	})
}

export const visitPage = (route) => {
	cy.visit(route, {failOnStatusCode: false})
}

export const checkClipboard =(value, id, { template } = { template: {} }) => {
	Elements.get(id, { template }).then((clipBoardButton) => {
		if(Cypress.env('browser') == 'chrome'){
			cy.wrap(Cypress.automation('remote:debugger:protocol', {
				command: 'Browser.grantPermissions',
				params: {
				  permissions: ['clipboardReadWrite', 'clipboardSanitizedWrite'],
				  origin: window.location.origin,
				},
			}))
			cy.get(clipBoardButton).focus()
			cy.get(clipBoardButton).click()
			cy.window().then((win) => {
				win.navigator.clipboard.readText().then((text) => {
					expect(value).to.equal(text)
				});
			});
		}
	})
}