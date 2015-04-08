Feature: Find email

  Background:
    Given a "Welcome" email sent to "first@example.com" containing:
      """html
      <h1><a href="http://first-email/first-link">Welcome</a></h1>
      <p><a href="http://first-email/last-link">Confirm</a></p>
      """
    And a "Goodbye" email sent to "last@example.com" containing:
      """html
      <h1><a href="http://last-email/first-link">Goodbye</a></h1>
      <p><a href="http://last-email/last-link">Confirm</a></p>
      """

  Scenario: No args
    * `find_email` finds "Goodbye" email

  Scenario: Find by subject
    * `find_email(subject: "Welcome")` finds "Welcome" email

  Scenario: Find by recipient
    * `find_email(to: 'first@example.com')` finds "Welcome" email

  Scenario: Match by subject
    * `find_email(subject: /welcome/i)` finds "Welcome" email

  Scenario: No matches
    * `find_email(subject: "welcome")` raises "EmailTestHelpers::NotFound"

