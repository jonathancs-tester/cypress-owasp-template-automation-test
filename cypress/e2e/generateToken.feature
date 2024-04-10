@GENERATE_TOKEN
Feature: GENERATE TOKEN

    Scenario Outline: Generate token - "<user>"
        Given insert "<user>" credentials and login via "<mode>"

        Examples:
            |  user                     | mode  |
            |  admin                    | MFA   |
            |  view                     | MFA   |
            |  feature_store            | MFA   |
            |  manager                  | MFA   |
            |  manager_without_project  | MFA   |
            |  read_project             | MFA   |
            |  classification           | MFA   |
            |  time_series              | MFA   |
            |  freemium                 | DEV   |