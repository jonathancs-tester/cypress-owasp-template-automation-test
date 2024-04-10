import {
	getText
} from "../../../components/common"


And(/I get value reference a Cards/, () => {
	getText("Results Cards Label").then((labels) => {
		getText("Results Cards Variation").then((variations) => {
			const cards = labels.reduce((acc, label, i) => {
				acc[label] = {
					variation: variations[i].
						replaceAll(/[+()]/g, "").
						replaceAll(/([0-9]*.[0-9])0/g, `$1`)
				}
				return acc
			}, {})
			cy.wrap(cards).as('valuesCards')
		})
	})
})

And(/I get value reference a Waterfall/, () => {
	getText("Results Waterfall Labels").then((waterfallLabels) => {
		getText("Results Waterfall Variations").then((waterfallVariations) => {
			const waterfall = waterfallLabels.reduce((acc, label, i) => {
				acc[label] = {
					variation: waterfallVariations[waterfallVariations.length - 1 - i].
						replaceAll(/([0-9]*.[0-9])0/g, `$1`)
				}
				return acc
			}, {}) 
			cy.wrap(waterfall).as('valueWaterfall')
		})
	})
})

And(/I compare cards with Waterfall/, () => {
	for (let i in '@valuesCards') {
		expect('@valueWaterfall'[i]).to.not.be.undefined
		expect('@valuesCards'[i].variation).to.eq('@valueWaterfall'[i].variation)
	}
})