@VERIFY-DATA-LOADER
@4INTELLIGENCE @API @REGRESSION
Feature: Check Data-loader

Background:
    Given insert "admin" credentials and login via "MFA"

    @SANITY
    Scenario Outline: Check to send data of the new Feature Store flow
        Then check if the data were inserted in "<indicator>" indicator in the following series:
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

        