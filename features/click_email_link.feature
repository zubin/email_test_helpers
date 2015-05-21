Feature: Click email link

  Scenario Outline:
    Given emails are sent with "<delivery type>"
    And a "Welcome" email sent to "first@example.com" containing:
      """html
      <h1><a href="http://first-email/first-link">Welcome</a></h1>
      <p><a href="http://first-email/last-link">Confirm</a></p>
      """
    And a "Goodbye" email sent to "last@example.com" containing:
      """html
      <h1><a href="http://last-email/first-link">Goodbye</a></h1>
      <p><a href="http://last-email/last-link">Confirm</a></p>
      """
    Then "<code>" should visit "<url>"

    Examples:
      | delivery type | code                                             | url                           |
      | html          | click_email_link                                 | http://last-email/first-link  |
      | html          | click_email_link('confirm')                      | http://last-email/last-link   |
      | html          | click_email_link('last-link')                    | http://last-email/last-link   |
      | html          | find_email(subject: 'Welcome'); click_email_link | http://first-email/first-link |
      | multipart     | click_email_link                                 | http://last-email/first-link  |
      | multipart     | click_email_link('confirm')                      | http://last-email/last-link   |
      | multipart     | click_email_link('last-link')                    | http://last-email/last-link   |
      | multipart     | find_email(subject: 'Welcome'); click_email_link | http://first-email/first-link |
