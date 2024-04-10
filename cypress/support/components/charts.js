import Elements from "../elements/common"

class charts {
	checkChartsUnit(unit, id){
        cy.get(Elements.map(id)).should('be.visible').invoke('text').then(unitChart => {
            expect(unitChart).to.be.eq(unit)
        })
    }

    checkXaxisValues(values, id){
        var valuesList = values.split(',')
        cy.get(Elements.map(id)).find('.highcharts-axis-labels highcharts-xaxis-labels').then(xAxisValues => {
            cy.get(xAxisValues).find("text").then($chartXValues => {
                for (let index = 0; index < $chartXValues.length; index++) {
                    expect(valuesList[index]).to.be.eq($chartXValues[index])
                }
            })
        })
    }

    checkYaxisValues(values, id){
        var valuesList = values.split(',')
        cy.get(Elements.map(id)).find('.highcharts-axis-labels highcharts-yaxis-labels').then(xAxisValues => {
            cy.get(xAxisValues).find("text").then($chartXValues => {
                for (let index = 0; index < $chartXValues.length; index++) {
                    expect(valuesList[index]).to.be.eq($chartXValues[index])
                }
            })
        })
    }

}
export default charts;