const buttons = require('./button')
const cards = require('./cards')
const checkbox = require('./checkbox')
const datepicker = require('./datepicker')
const radio = require('./radio')
const slider = require('./slider')
const text = require('./text')
const featureStore = require('./feature_store')
const classification = require('./classification')
const timeSeries = require('./time_series')
const general = require('./general')
const { template: templateFunc, templateAttributes } = require('./selectors')

class Elements {
	template = templateFunc

	get = (id, { template, timeout } = { template: {} }) => {
		// Extract attributes and name of the id.
		const attributes = templateAttributes(id);

		// Find selector for id in map.
		const selector = this.map(attributes._name);

		// Apply template with attributes and template
		const templateSelector = this.template(selector, { ...template, ...attributes })

		// Get element.
		cy.get(templateSelector, { timeout }).as('element')

		// Check if we need to get the first.
		if (attributes.position) {
			cy.get('@element').then(element => {
				if (element.length == undefined) {
					cy.wrap(element).as('element')
					return
				}

				let position = attributes.position;
				if (position === "first") position = 0;
				if (position === "last") position = element.length - 1

				if (position > element.length || position < 0) throw `position ${position} out of bounds for element ${id}`

				cy.wrap(element[position]).as('element')
			})
		}
		else if (attributes.position && attributes.position == "last") {
			element = element.last()
		}

		return cy.get('@element');
	}

	map = (id, { template } = { template: {} }) => {
		const elements = {
			...buttons({ template }),
			...cards({ template }),
			...checkbox({ template }),
			...datepicker({ template }),
			...radio(),
			...slider({ template }),
			...text({ template }),
			...classification,
			...timeSeries,
			...general,
			...featureStore,
		}
		return elements[id] != undefined ? elements[id] : id
	}
}

export default new Elements 
