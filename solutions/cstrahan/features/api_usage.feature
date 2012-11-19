Feature: API user reads a public feed

  Background:
    Given I am logged out
    And there is a feed with messages at "hungryfeeder.feedengine.com"

  Scenario: Reading a public feed via the API
    When I request "http://api.feedengine.com/feeds/charles.json";
    Then I should see an error for "Token not found"