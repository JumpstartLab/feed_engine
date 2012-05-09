Feature: Posting An Image
  Background:
    Given I am viewing the dashboard at "/dashboard"
    And I click the "image" tab

  Scenario: Viewing the image message form
    Then I should see a form to create an image message

  Scenario: Submitting an empty image message
    When I click post
    Then I should see an error message requiring a link to an image
    And I should see the form to create an image message

  Scenario: Submitting an image link with length greater than 2048 characters
    When I fill in the image link field with a link of 2049 characters
    And I click post
    Then I should see an error message requiring the image link to be less than or equal to 2048 characters
    And I should see the form to create an image message
    And the image url I have entered is present

Scenario: Submitting a link with length of an improper format
    When I fill in the link field with "abc123"
    And I click post
    Then I should see an error message requiring the link format to look like an http/https link
    And I should see the form to create an image message
    And the image url I have entered is present

Scenario: Submitting a link with length of an improper extension
    When I fill in the link field with "http://foo.com/bar.html"
    And I click post
    Then I should see an error message requiring the link format to end in an image extension (car-insensitive: jpg, jpeg, gif, bmp, png)
    And I should see the form to create an image message
    And the image url I have entered is present

  Scenario: Submitting a message successfully
    When I fill in the link field with "http://hungryacademy.com/monster.png"
    And I click post
    Then I should see a confirmation message that my message has been saved
    And I should see my dashboard

  Scenario: Submitting a message with too long of a comment
    When I fill in the link field with "http://hungryacademy.com/monster.png"
    And I fill in the comment field with 257 'a's
    And I click post
    Then I should see an error message requiring the comment to be less than or equal to 256 characters
    And I should see the form to create an image message
    And the image url I have entered is present
    And the image comment I have entered is present

  Scenario: Submitting a message successfully
    When I fill in the link field with "http://hungryacademy.com/monster.png"
    And I fill in the comment field with "This guy is pretty cute."
    And I click post
    Then I should see a confirmation message that my message has been saved
    And I should see my dashboard