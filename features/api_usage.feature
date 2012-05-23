Feature: API user reads a public feed

  Scenario: Reading a public feed via the API
    Given there is a feed called "hungryfeeder"
    When I request "http://api.feedengine.com/feeds/hungryfeeder.json";
    And I specify an Accept header of "application/json"
    Then I should receive a JSON array of feed items