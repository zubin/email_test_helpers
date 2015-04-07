Feature: Click email link

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
    * `click_email_link` visits "http://last-email/first-link"

  Scenario: Match by link text
    * `click_email_link('confirm')` visits "http://last-email/last-link"

  Scenario: Match by URL
    * `click_email_link('last-link')` visits "http://last-email/last-link"

  Scenario: Find first email
    * `find_email(subject: "Welcome"); click_email_link` visits "http://first-email/first-link"
