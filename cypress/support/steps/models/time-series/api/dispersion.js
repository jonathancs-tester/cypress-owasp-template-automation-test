/* global Given, Then, When */

import dispersion from '../../../../components/betaview'

const Dispersion = new dispersion

And("check if {string} and {string} variables not found in all models by Beta View", (var1,var2,model) => {
	Dispersion.checkExclusionBetaView(var1,var2);
})

And("check if {string} univariate model in Beta View", (exist) => {
	if(exist == 'not exist')
		Dispersion.checkModelUnivariate();
})