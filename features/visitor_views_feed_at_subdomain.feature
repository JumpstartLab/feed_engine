Feature: Visitor Views Feed Of Messages At Sub-Domain

Background:
  Given I am logged out
  And there is a feed with messages at "hungryfeeder.feedengine.com"

Scenario: Viewing feed as a visitor
  When I view hungryfeeder.feedengine.com
  Then I should see the most recent messages

Scenario: Viewing the bare domain logged out
  When I view feedengine.com
  Then I see a prominent link to sign up for an account
  And I see a log in form