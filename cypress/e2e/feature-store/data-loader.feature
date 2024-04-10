@DATA-LOADER
@4INTELLIGENCE @API @REGRESSION
Feature: Send to Data-loader

Background:
    Given insert "admin" credentials and login via "MFA"

    @SANITY
    Scenario Outline: Send to data loader of the new Feature Store flow
        And delete all series of "<indicator>" indicator
        And create series in "<indicator>" with the following data:
            | reg   | TP | AG | TS |
            | 000   | O  | OM | A  |
            | 000   | O  | OM | C  |
            | 000   | O  | OM | L  |
            | 000   | O  | OM | M  |
            | 000   | O  | OM | Y  |
            | 000   | O  | SQ | A  |
            | 000   | O  | SQ | C  |
            | 000   | O  | SQ | L  |
            | 000   | O  | SQ | M  |
            | 000   | O  | SQ | Y  |
            | 000   | O  | SY | L  |
            | 000   | O  | SY | Y  |
        Then insert data in new Feature Store flow
        And active "<indicator>" Indicator
        Examples:
            | indicator |
            | BRCRD0081 |