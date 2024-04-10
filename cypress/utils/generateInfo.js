class generateInfo {
	randomNumberInitialInfo(value){
		const uuid = () => Cypress._.random(0, 1e6)
		const id = uuid()
		
		return id+'-'+Cypress.env('browser')+'-'+value
	}

	concatVariable(value){		
		return value + Cypress.env('browser')
	}
}
export default generateInfo;