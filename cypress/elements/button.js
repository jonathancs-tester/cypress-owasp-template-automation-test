const { withId, template: templateFunc } = require('./selectors')

export default function({ template } = { template: {} }) {
    return {
        "Menu Model Explorer": '[data-testid=li-label${index}]:not([disabled])',
        "Menu Model Explorer Without Validate": '[data-testid=li-label${index}]',
        "OK Button": withId("button-ok"),
        "Confirm Button": withId("button-confirm"),
        "Back Button": withId("button-back"),
        "Add Button": withId("button-add"),
        "Save Button": withId("button-save"),
        "Continue Button": withId("button-continue"),
        "Delete Confirm Button": withId("button-delete-confirm"),
        "Open Filters Sidebar Button": withId("open-filters-sidebar-button"),
        "Close Filters Sidebar Button": withId("close-filters-sidebar-button"),

        //Feature Store - TODO: Precisa de ser organizado dentro da pasta de feature store
        "Delete Serie Button": templateFunc(withId("button-delete-series-${name}"), template),
        "Confirm delete series button": templateFunc(withId("button-delete-series"), template),
        "Group Card Menu": templateFunc(withId("button-menu-${name}-${browser}"), template),
        "Group Card Delete Menu": templateFunc(withId("menu-button-delete-${name}-${browser}"), template),
        "Group Card Edit Menu": templateFunc(withId("menu-button-edit-${name}-${browser}"), template),
        "Feature Store Variable New Tab Button": templateFunc(withId("feature-store-variable-card-link-${name}"), template),
        "Data Button 4i Card": templateFunc(withId("button-data-section"), template),
        "Data Tab Button": templateFunc(withId("tab-${name}"), template),
    }
}