Feature: Posting A Message
  Background:
    Given I have signed up before with "foo@bar.com"
    And I am signed in
    And I am viewing the dashboard at "/dashboard"

  Scenario: Viewing  the message form
    Then I should see a form to create a text message

  Scenario: Submitting an empty message
    When I click post message within the text post form
    Then I should see an error message requiring text contents
    And I should see the form to create a text message

  Scenario: Submitting a message with length greater than 512 character
    When I fill in the message text with 513 'a's
    And I click post message
    Then I should see an error message requiring text to be less than or equal to 512 characters
    And I should see the form to create a text message
    And the data I have entered is present

  Scenario: Submitting a message successfully
    When I fill in the message text with "A witty joke"
    And I click post message
    Then I should see a confirmation message that my message has been saved
    And I should see my dashboard
