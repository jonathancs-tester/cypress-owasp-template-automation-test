const { withIdAndSelector, withId, template: templateFunc } = require('./selectors')

export default function ({ template } = { template: {} }) {
	return {
		"Export Card": withId("card-export"),
		"Results Cards": `${withId("primary-results-card-")},${withId("secondary-results-card-")}`,
		"Results Cards Variation": `${withIdAndSelector("primary-results-card-", "h3 span")},${withIdAndSelector("secondary-results-card-", "h3 span")}`,
		"Understanding the Result": withId("ia-selection-results-content"),
		"Card Results": withId("card-results"),
		"Potential Impacts Modal Card": withId("card-potential-impacts"),
		"Potential Outliers Card": withId("card-potential-outliers"),

		"Annual Summary Card": withId("annual-summary-container"),
		
		//User Selection
		"Simulation Variables Card": `${withIdAndSelector("container-simulations", "h5")}`,
		"Estimated Coefficients Variables Card": `${withIdAndSelector("container-elasticities", "p")}`,
		"Explaining the Results Card": withId("card-explaining-the-results"),

		//My Projects
		"My Project Name Card": `${withIdAndSelector("access-project-", "h5")}`,

		//Data view
		"Variable Importance Error Card": withId("variable-importance-errored"),
		"Correlation Error Card": withId("container-error-correlation"),
		"Final Settings Card": withId("card-final-settings"),
		"Warning Icon": withId("warning-icon"),

		//Final Settings - Modelling
		"Group Name Card": templateFunc(withId("group-name-${name}-${browser}"), template),
		"Forecast Optimized Period Card 1": withId("button-card-1"),
		"Forecast Optimized Period Card 2": withId("button-card-2"),
		"Forecast Optimized Period Card 3": withId("button-card-3"),

		//Feature Store
		"Indicator Card": withId("card-indicator-"),
		"Nth Indicator Card": templateFunc(`:is(div[data-testid^="card-indicator-"]):nth-child(\${position})`, template),
	}
}