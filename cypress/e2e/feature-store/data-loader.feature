@DATA-LOADER
@4INTELLIGENCE @API @REGRESSION
Feature: Check Data-loader

Background:
    Given insert "admin" credentials and login via "MFA"

    @SANITY
    Scenario Outline: Automated test of the new Feature Store flow
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
        And check if the data were inserted in "<indicator>" indicator in the following series:
            | Series         |
            |BRCRD0081000OOMA|
            |BRCRD0081000OOMC|
            |BRCRD0081000OOML|
            |BRCRD0081000OOMM|
            |BRCRD0081000OOMY|
            |BRCRD0081000OSQA|
            |BRCRD0081000OSQC|
            |BRCRD0081000OSQL|
            |BRCRD0081000OSQM|
            |BRCRD0081000OSQY|
            |BRCRD0081000OSYL|
            |BRCRD0081000OSYY|
        Examples:
            | indicator |
            | BRCRD0081 |

        