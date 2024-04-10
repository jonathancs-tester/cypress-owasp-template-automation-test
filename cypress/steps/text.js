import assertions from '../utils/assertions'
import generateInfo from '../utils/generateInfo'
const Assertions = new assertions
const GenerateInfo = new generateInfo

import {
	elementHasTextsCount,
	elementHasText,
	typeInElement,
	attributeValueHasText,
	attributeHeightHasText,
	expectCountOfElement,
	getText,
	pressButtonSequence,
	checkClipboard
} from "../components/common"

And(/I can see only one of following text "(.+)" in element "(.+)"/, (texts, id) => {
	elementHasTextsCount(id, texts.split(","), 1)
})

And(/I can't see any of following text "(.+)" in element "(.+)"/, (texts, id) => {
	elementHasTextsCount(id, texts.split(","), 0)
})

And(/I can see text "(.+)" in element "(.+)"/, function (text, id) {
	elementHasText(id, text, { template: this.template })
})

And(/I can see text "(.+)" attribute value in element "(.+)"/, (text, id) => {
	attributeValueHasText(id, text)
})

And(/I can see text ([0-9]+) attribute height in element "(.+)"/, function (text, id) {
	attributeHeightHasText(id, text, { template: this.template })
})

And(/I can see text list "(.*[^;])" in element "(.+)"/, (list, id) => {
	const texts = list.split(';')
	for (let text of texts) {
		elementHasText(id, text)
	}
})

And(/I should see is ((equal to)|(greater than)|(less than)) ([0-9]+) items of "(.+)"/, function (compare, count, id) {
	expectCountOfElement(id, compare, parseInt(count), { template: this.template })
})


And(/I get (after|before) info in "(.+)"/, function (time, id) {
	getText(id, { template: this.template }).then((element) => {
		cy.wrap(element).as(time)
	})
})

And(/I compare after value is (equal to|greater than|less than) "(.+)" value/, (compare, value) => {
	expect("@after").to.not.be.undefined
	cy.get('@after').then(($after) => {
		Assertions.compareInfo(parseFloat($after), compare, parseFloat(value))
	});
})

And(/I compare after info is (equal deep to|equal to|not equal) before info/, (compare) => {
	expect("@after").to.not.be.undefined
	expect("@before").to.not.be.undefined
	cy.get('@after').then(($after) => {
		cy.get('@before').then(($before) => {
			Assertions.compareInfo($after, compare, $before)
		});
	});
})

And(/I write "(.+)" text in element "(.+)"/, function (value, id) {
	if (id.includes('Grid')) {
		typeInElement(value, id, false, { template: this.template })
	} else {
		typeInElement(value, id, true, { template: this.template })
	}
})

And(/I write "(.+)" random text in element "(.+)"/, function (value, id) {
	value = GenerateInfo.randomNumberInitialInfo(value)

	if (id.includes('Grid')) {
		typeInElement(value, id, false, { template: this.template })
	} else {
		typeInElement(value, id, true, { template: this.template })
	}
})

And(/I press "(.+)" sequence in element "(.+)"/, function (value, id) {
	pressButtonSequence(value, id, { template: this.template })
})

And(/I check if have "(.+)" text in "(.+)" clipboard button/, function (value, id) {
	checkClipboard(value, id, { template: this.template })
})