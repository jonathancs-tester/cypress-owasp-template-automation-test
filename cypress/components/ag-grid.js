export const scrollHorizontalToColElement = (value) => {
	let found = false;

	function checkForText($element) {
		for (let index = 0; index < $element.length; index++) {
			if ($element.eq(index).text() === value) {
				found = true;
				return;
			}
		}
		cy.get('.ag-cell-focus').type('{rightarrow}');
        cy.get('.ag-header-cell-text').last().then(checkForText);
	}

	cy.get('.ag-header-cell-text').last().then(checkForText);
}