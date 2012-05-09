Feature: Posting A Link
  Background:
    Given I am viewing the dashboard at "/dashboard"
    And I click the "link" tab

  Scenario: Viewing  the link message form
    Then I should see a form to create a link message

  Scenario: Submitting an empty link message
    When I click post
    Then I should see an error message requiring a link
    And I should see the form to create a link message

  Scenario: Submitting a link with length greater than 2048 characters
    When I fill in the link field with a link of 2049 characters
    And I click post
    Then I should see an error message requiring the link to be less than or equal to 2048 characters
    And I should see the form to create a link message

Scenario: Submitting a link with length of an improper format
    When I fill in the link field with "abc123"
    And I click post
    Then I should see an error message requiring the link format to look like an http/https link
    And I should see the form to create a link message
    And the link url I have entered is present

  Scenario: Submitting a message successfully
    When I fill in the link field with "http://hungryacademy.com/"
    And I click post
    Then I should see a confirmation message that my message has been saved
    And I should see my dashboard

  Scenario: Submitting a message with too long of a comment
    When I fill in the link field with "http://hungryacademy.com/"
    And I fill in the comment field with 257 'a's
    And I click post
    Then I should see an error message requiring the comment to be less than or equal to 256 characters
    And I should see the form to create a link message
    And the link url I have entered is present
    And the link comment I have entered is present

  Scenario: Submitting a message  successfully
    When I fill in the link field with "http://hungryacademy.com/"
    And I fill in the comment field with "I love this site!"
    And I click post
    Then I should see a confirmation message that my message has been saved
    And I should see my dashboard