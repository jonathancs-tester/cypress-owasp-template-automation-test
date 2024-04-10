export const withId = (id) => { return `[id^="${id}"],[data-testid^="${id}"],[data-cy="${id}"]` }
export const withIdAndSelector = (id, selector) => { return `[id^="${id}"] ${selector},[data-testid^="${id}"] ${selector},[data-cy="${id}"] ${selector}` }
export const template = (input, variables = {}) => {
    const t = this && this.template ? this.template : {}

    const templateVariables = {
        browser: Cypress.env('browser'),
        ...t
    }

    let output = input;

    for (let v of Object.keys(variables)) {
        output = output.replaceAll(`\${${v}}`, variables[v])
    }

    for (let v of Object.keys(templateVariables)) {
        output = output.replaceAll(`\${${v}}`, templateVariables[v])
    }

    return output
}