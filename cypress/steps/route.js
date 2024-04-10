import {
	visitPage,
} from "../components/common"

And(/I visit "(.+)"/, function (route) {
	visitPage(route)
})
