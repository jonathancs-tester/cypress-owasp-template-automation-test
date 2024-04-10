import Elements from "../elements/common"

export const changeStepSlider = (step, id, { template } = { template: {} }) => {
	cy.get(Elements.map(id, { template })).should('be.visible').then($initialSlider => {
		cy.get($initialSlider).trigger("mousedown", { button: 0 });
		cy.get(".rc-slider-dot").should('be.visible').then($endSlider => {
			if($endSlider.length > 1)
				cy.get($endSlider.eq(step-1)).trigger("mousemove");
		})
	})
	cy.get(Elements.map(id, { template })).trigger("mouseup", { button: 0 });
}

//TODO: Melhorar essa função de slider
export const changeBeforeAfterSlider = (forestHorizonDefault,forestHorizonValue,id) => {
	cy.get(Elements.map(id)).invoke('attr', 'value').should('eq', forestHorizonDefault.toString())
	cy.get(Elements.map(id))
		.then($el => $el[0].stepDown(forestHorizonDefault) )
		.trigger('change')
	cy.get(Elements.map(id))
		.then($el => $el[0].stepUp(forestHorizonValue-1) )
		.trigger('change')
	cy.get(Elements.map(id)).trigger("mouseup");
}