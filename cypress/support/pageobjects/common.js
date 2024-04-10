import download from "../components/download"
import Elements from "../elements/common"
import assertions from '../utils/assertions'

const Assertions = new assertions
const Download = new download

export const elementIsVisible = (id, visible, timeout = 60000) => {
	if (visible) {
		cy.get(Elements.map(id), { timeout: timeout }).should('be.visible')
	} else {
		cy.get(Elements.map(id), { timeout: timeout }).should('not.exist')
	}
}

export const elementIsEmpty = (id, empty, timeout = 60000) => {
	if (empty) {
		cy.get(Elements.map(id), { timeout: timeout }).should('be.empty')
	} else {
		cy.get(Elements.map(id), { timeout: timeout }).should('not.be.empty')
	}
}

export const elementHasTextsCount = (id, values, count) => {
	let result = []
	cy.get(Elements.map(id)).each((element) => {
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
	cy.get(Elements.map(id, { template })).contains(text)
}

export const attributeValueHasText = (id, text) => {
	cy.get(Elements.map(id)).invoke('attr', 'value').should('eq', text.toString())
}

export const elementHasElement = (id, elementID) => {
	cy.get(Elements.map(id)).find(Elements.map(elementID))
}

export const clickVariable = (id, { template } = { template: {} }) => {
	if (id.includes('Download')) 
		Download.setConfiguration()
	cy.get(Elements.map(id, { template })).click()
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

export const setCheckboxValue = (id, value) => {
	cy.get(Elements.map(id)).then((checkbox) => {
		if (value != checkbox.is(':checked')) {
			cy.get(checkbox).click()
		}
	})
}

export const selectFrequency = (frequency, element) => {
	cy.get(Elements.map(element)).parents('.containerLinear').find(Elements.map(frequency)).click()
}

export const waitElementEnabled = (id, enabled) => {
	if (enabled) {
		cy.get(Elements.map(id)).should('not.have.attr', 'disabled')
	} else {
		cy.get(Elements.map(id)).should('have.attr', 'disabled')
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

export const selectValue = (id, value) => {
	cy.get(Elements.map(id)).find(".select__dropdown-indicator").click()
	cy.get('.select__menu').contains(value).click()
}

export const getText = (id) => {
	let texts = []

	cy.get(Elements.map(id)).each(($element) => {
		texts.push($element.text())
	})
	cy.wrap(texts).as("texts")

	return cy.get("@texts")
}

export const typeInElement = (value, id) => {
	cy.get(Elements.map(id)).clear()
	cy.get(Elements.map(id)).type(Elements.template(value))
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

export const expectCountOfElement = (id, compare, count) => {
	cy.get(Elements.map(id)).then(($element) => {
		Assertions.compareInfo($element.length, compare, count)
	})
}

export const closeModal = (id) => {
	cy.get('body').then(($body) => {
		if ($body.find(Elements.map(id)).length > 0)
			cy.get(Elements.map(id)).click()
	})
}