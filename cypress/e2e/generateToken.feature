@GENERATE_TOKEN
Feature: GENERATE TOKEN

    Scenario Outline: Generate token - "<user>"
        Given insert "<user>" credentials and login via "MFA"

        Examples:
            |  user                     |
            |  admin                    |
            |  view                     |
            |  feature_store            |
            |  manager                  |
            |  manager_without_project  |
            |  read_project             |
            |  classification           |
            |  time_series              |