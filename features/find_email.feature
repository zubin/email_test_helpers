Feature: Find email

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
    Then "<code>" should find "<matching email>" email

    Examples:
      | delivery type | code                                | matching email |
      | html          | find_email                          | Goodbye        |
      | html          | find_email(subject: 'Welcome')      | Welcome        |
      | html          | find_email(to: 'first@example.com') | Welcome        |
      | html          | find_email(subject: /welcome/i)     | Welcome        |
      | html          | find_email(body: /welcome/i)        | Welcome        |
      | html          | find_email(subject: 'welcome')      |                |
      | multipart     | find_email                          | Goodbye        |
      | multipart     | find_email(subject: 'Welcome')      | Welcome        |
      | multipart     | find_email(to: 'first@example.com') | Welcome        |
      | multipart     | find_email(subject: /welcome/i)     | Welcome        |
      | multipart     | find_email(body: /welcome/i)        | Welcome        |
      | multipart     | find_email(subject: 'welcome')      |                |
