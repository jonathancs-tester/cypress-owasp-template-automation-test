import { 
	attachFixtureInElement, 
} from "../pageobjects/common"

And(/I attach fixture "(.+)" in element "(.+)"/, (value, id) => {
	attachFixtureInElement(id, value)
})
