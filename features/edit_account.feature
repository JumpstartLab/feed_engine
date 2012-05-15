Feature: User Edits Account

Background:
  Given I have signed up before with "foo@bar.com"
  And I am signed in
  And I am viewing the dashboard

Scenario: User edits account
  When I click the account tab
  Then I should see a form to change my password

  When I fill in the password and password confirmation fields with matching strings 6 or more characters in length
  And I click to change password
  Then I am viewing my dashboard
  And I see a confirmation message
  And my password has changed

Scenario: User fails to enter correct password/confirmation
  When I click the account tab
  Then I should see a form to change my password

  When I fill in the password and password confirmation fields with non-matching strings 6 or more characters in length
  And I click to change password
  Then I see an error message that the password and confirmation must match
  And I see the edit account form