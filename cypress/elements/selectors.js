export const withId = (id) => { return `[id^="${id}"],[data-testid^="${id}"],[data-cy^="${id}"],[data-tooltip-content^="${id}"],[data-tooltip-html^="${id}"]` }
export const withIdAndSelector = (id, selector) => { return `[id^="${id}"] ${selector},[data-testid^="${id}"] ${selector},[data-cy^="${id}"] ${selector}, [data-tooltip-content^="${id}"] ${selector},[data-tooltip-html^="${id}"] ${selector}` }
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

export const templateAttributes = (id) => {
	const regex = /^([a-zA-Z ]+)\[(.*)\]$/;
	const match = id.match(regex);
  
	if (!match) {
	  return { _name: id };
	}
  
	const elementName = match[1];
	const attributesMatch = match[2];
	const attributes = attributesMatch.split(';');
	const attributeRegex = /([a-zA-Z]*)=(.*)/;
	const result = { _name: elementName };
  
	for (let attr of attributes) {
	  	const match = attr.match(attributeRegex);
		
	  	if (match === null) {
			result[attr] = true;
			continue;
	  	}
	  
	  	const attribute = match[1];
	  	const value = match[2];
	  
	  	if (/^([0-9]+.[0-9]+)+|[0-9]+$/y.test(value)) {
			result[attribute] = parseFloat(value);
			continue;
	  	}
	  
	  	if (/^(true|false)$/.test(value)) {
			if (value === "true") result[attribute] = true;
			else result[attribute] = false;
	  	}
	  
		result[attribute] = value.replaceAll('"', '');
	}	
	return result;
};