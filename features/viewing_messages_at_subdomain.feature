Feature: View Feed Of My Messages At Sub-Domain

Background:
  Given I have signed up before with "foo@bar.com"
  And my display name is "hungryfeeder"
  And I have created messages
  And I am signed in

Scenario: Viewing my feed at my sub-domain
  When I view my subdomain site
  Then I should see my most recent messages

Scenario: Viewing the bare domain logged in
  And I view feedengine.com
  Then I am redirected to my dashboard at "feedengine.com/dashboard"

Scenario: Viewing the bare domain logged out
  When I log out
  And I view feedengine.com
  Then I see a prominent link to sign up for an account
  And I see a log in form