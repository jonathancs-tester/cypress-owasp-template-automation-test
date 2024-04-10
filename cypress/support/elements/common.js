const anchor = require('./anchor')
const buttons = require('./button')
const checkbox = require('./checkbox')
const radio = require('./radio')
const labels = require('./labels')
const chart = require('./chart')
const input = require('./input')
const sidebar = require('./sidebar')
const select = require('./select')
const loading = require('./loading')
const modal = require('./modal')
const slider = require('./slider')
const cards = require('./cards')
const table = require('./table')
const toggle = require('./toggle')
const { withId, withIdAndSelector, template: templateFunc} = require('./selectors') 

class Elements {
	template = templateFunc
	map = (id, { template } = { template: {}}) => {
		const elements = {
			...anchor,
			...buttons({template}),
			...checkbox,
			...labels,
			...radio,
			...chart,
			...input,
			...sidebar,
			...select,
			...loading,
			...modal,
			...cards({template}),
			...slider({template}),
			...table,
			...toggle,

			"Layout Container Div": withId("layout-container-div"),
			"See More Impacts Collapse": withId("ai-selection-results-see-more-impacts"),

			"Project Overview Title": withId("card-project-overview"),
			"Model Info Info Type": withId("data-info-type"),
			"My Projects Modal": withId("card-my-projects"),
			"Empty Historical Data Graph": withId("transformations-no-checkbox"),
			"Time Feature Date": withId("date/time-feature"),

			"Project Name Container": withId("container-sidebar-project"),
			"Results Waterfall Container": withId("results-waterfall-container"),

			"Results Waterfall Variations": withIdAndSelector("results-waterfall-container", ".highcharts-label text"),

			"Premium groups indicators": withId("content-svg-group-premium"),
			"Layout Container Div Faas": withId("layout-container-div-faas"),

			"Chart Dependent Variables": withId("chart-dependent-variables"),

			"Download User Selection": withId("btn-download-bestmodel"),

			"Potencial Outliers Arima": withId("potential-outliers-arima"),
			"Potencial Outliers Sarima": withId("potential-outliers-sarima"),
			"Potencial Outliers Cooksd": withId("potential-outliers-cooksd"),
			"Table Dependent Variables": withId("div-table-dependent-variables"),
			"Search Dependent Variables": `[data-testid="container-dependent-variable"] input[data-testid="search-dependent-variables"]`,
			"Select or Deselect Variables Button": withId("button-select-or-deselect-variable-"),
			"Project Menu": withId("button-open-project-menu"),
			"Update history": withId("button-open-update-history"),
			"Update List": withId("update-update-"),
			"Update 1": withId("access-update-update-1-button"),
			"Reopen Update History Button": withId("reopen-update-history-button"),
			"Last update": withId("access-update-update-"),
			"Share update": withId("share-update-update-"),
			"Share button": withId("send-updates-button"),
			"Close update": withId("close-update-button"),
			"OK Button": withId("button-ok"),
			"Back Button": withId("button-back"),
			"Add Button": withId("button-add"),
			"Continue Button": withId("button-continue"),
			"Cancel Button": withId("button-cancel"),
			"Delete Confirm Button": withId("button-delete-confirm"),
			"Close Failed Modal": withId("button-modal-failed-ok")

		}
		return elements[id] != undefined ? elements[id] : id
	}
}

export default new Elements 
