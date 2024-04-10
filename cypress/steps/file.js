import { 
	attachFixtureInElement, 
} from "../components/common"

And(/I attach fixture "(.+)" in element "(.+)"/, (value, id) => {
	attachFixtureInElement(id, value)
})
