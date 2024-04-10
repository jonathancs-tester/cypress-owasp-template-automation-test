import Elements from '../elements/common'

class dispersion {

	checkExclusionBetaView(var1, var2) {
		var model, id_var1, id_var2, model_var1, model_var2, exclusion_var1='null', exclusion_var2='null';
		cy.get(Elements.map('N Model Menu Select')).last().then(($element) => {
			model = parseInt($element.text())
			cy.intercept('GET', '**/betaview/**').as('betaView')
			cy.get($element).click()		
			cy.wait('@betaView',{timeout:180000}).then(({response}) => {
				
				for (let index = 0; index < response.body.variables.y.length; index++) {
					if (response.body.variables.y[index] == var1){
						id_var1 = index;
					} else if (response.body.variables.y[index] == var2){
						id_var2 = index;
					}
				}
				for (let data = 0; data < response.body.variables.data.length; data++) {
					for (let model_id = 0; model_id < model; model_id++) {
						if(response.body.variables.data[data].coef[id_var1][model_id] != 'null'){
							exclusion_var1 = response.body.variables.data[data].coef[id_var1][model_id]
							model_var1 = model_id
						}
						if(response.body.variables.data[data].coef[id_var2][model_id] != 'null'){
							exclusion_var2 = response.body.variables.data[data].coef[id_var2][model_id]
							model_var2 = model_id
						}
					}
				}

				if(exclusion_var1 != 'null' && exclusion_var2 != 'null' && model_var1 == model_var2)
					assert.isNotOk(exclusion_var1+' and '+ exclusion_var2, 'Variables is not excluded')
			})
		})
	}

	checkModelUnivariate() {
		var univariate = 0;
		cy.get(Elements.map('N Model Menu Select')).last().then(($element) => {
			cy.intercept('GET', '**/betaview/**').as('betaView')
			cy.get($element).click()
			cy.wait('@betaView',{timeout:180000}).then(({response}) => {
				for (let model_id = 0; model_id < response.body.variables.data[0].coef[0].length; model_id++) {
					for (let data = 0; data < response.body.variables.data.length; data++) {
						for (let x_var = 0; x_var < response.body.variables.y.length; x_var++) {
							if(response.body.variables.data[data].coef[x_var][model_id] == 'null'){
								univariate++;	
							}
						}
					}
					if(univariate >= (response.body.variables.y.length * response.body.variables.data.length)){
						assert.isNotOk('Model is univariate')
					}
					univariate = 0;
				}
			})
		})
	}
}
export default dispersion;
