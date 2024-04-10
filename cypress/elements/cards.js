const { withId, template: templateFunc } = require('./selectors')

export default function({ template } = { template: {} }) {
    return {
        "Filter Sidebar": withId("filters-sidebar"),
        //Feature Store - TODO: Precisa de ser organizado dentro da pasta de feature store
        "Indicator Card": withId("card-indicator-"),
        "Nth Indicator Card": templateFunc(`:is(div[data-testid^="card-indicator-"]):nth-child(\${position})`, template),
        "Favorites Card": templateFunc(withId("favorite-info-card-${name}-${browser}"), template),
        "Select Favorites Card": templateFunc(withId("group-name-${name}-${browser}"), template),
        "Group Name Card": templateFunc(withId("favorite-card-${name}-${browser}"), template),
        "Favorites Group Card": templateFunc(withId("group-access-${name}-${browser}"), template),
        "Ecomonic Group Card": withId("favorite-card-${name}"),
    }

}