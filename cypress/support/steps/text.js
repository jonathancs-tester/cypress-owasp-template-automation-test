import assertions from '../utils/assertions'
const Assertions = new assertions

import { 
	elementHasTextsCount, 
	elementHasText, 
	typeInElement,
	attributeValueHasText,
	expectCountOfElement,
	getText
} from "../pageobjects/common"

And(/I can see only one of following text "(.+)" in element "(.+)"/, (texts, id) => {
	elementHasTextsCount(id, texts.split(","), 1)
})

And(/I can't see any of following text "(.+)" in element "(.+)"/, (texts, id) => {
	elementHasTextsCount(id, texts.split(","), 0)
})

And(/I can see text "(.+)" in element "(.+)"/, function(text, id){
	elementHasText(id, text, { template: this.template })
})

And(/I can see text "(.+)" attribute value in element "(.+)"/, (text, id) => {
	attributeValueHasText(id, text)
})

And(/I can see text list "(.*[^;])" in element "(.+)"/, (list, id) => {
	const texts = list.split(';')
	for (let text of texts) {
		elementHasText(id, text)		
	}
})

And(/I should see is (equal to)|(greater than)|(less than) ([0-9]+) items of "(.+)"/, function(count, compare, id){
	expectCountOfElement(id, compare, parseInt(count))
})


And(/I get (after|before) info in "(.+)"/, (time, id) => {
	getText(id).then((element) => {
		cy.wrap(element).as(time)
	})
})

And(/I compare after info is (equal to)|(not equal) before info/, (id, compare) => {
	expect('@after').to.not.be.undefined
	expect('@before').to.not.be.undefined
	Assertions.compareInfo('@before', compare, '@after')
})

And(/I write "(.+)" text in element "(.+)"/, (value, id) => {
	typeInElement(value, id)
})