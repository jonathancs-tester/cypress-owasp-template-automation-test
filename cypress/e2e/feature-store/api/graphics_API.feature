@GRAPHICS_API
@4INTELLIGENCE @API @FEATURE_STORE @REGRESSION
Feature: Check observations and projections graphics

    Scenario Outline: Get observation 
        Given insert "admin" credentials and login via "MFA"
        Then check observations of "BRPRC0046" indicator and "BRPRC0046000OOML" serie with "<status>"

        Examples:
            | status        |
            | unauthorized  |
            | success       |

    Scenario Outline: Get projection
        Given insert "admin" credentials and login via "MFA"    
        Then check projections of "BRPRC0046" indicator and "BRPRC0046000OOML" serie with "<status>"

        Examples:
            | status        |
            | unauthorized  |
            | success       |

    Scenario Outline: Get observation on inactive indicator with view user
        Given insert "view" credentials and login via "MFA"
        Then check observations of "ARPRC0114" indicator and "ARPRC0114000OAQL" serie with "<status>"

        Examples:
            | status        |
            | not found     |

    Scenario Outline: Get projection on inactive indicator with view user
        Given insert "view" credentials and login via "MFA"    
        Then check projections of "ARPRC0114" indicator and "ARPRC0114000OAQL" serie with "<status>"

        Examples:
            | status        |
            | not found     |