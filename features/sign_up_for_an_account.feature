Feature: Sign Up For An Account

Background:
  Given I am viewing the root
  And I am not logged in

Scenario: Signing up
  Given I have never signed up
  When I click the sign up link
  Then I should see the sign up form at "/signup"

  When I fill in email address with  "foo@bar.com"
  And I fill in display name with "displayname"
  And I fill in password and password confirmation with "hungry"
  And I submit the form
  Then I should see a confirmation message thanking me for signing up
  And I should be viewing the dashboard at '/dashboard'
  And I should receive a welcome email at my address

@wip
Scenario: Signing up with an already-used email address
  Given I have signed up before with "foo@bar.com"
  When I click the sign up link
  Then I should see the sign up form at "/signup"

  When I fill in email address with "foo@bar.com"
  And I fill in display name with "displayname"
  And I fill in password and password confirmation with "hungry"
  And I submit the form
  Then I should see an error message that the email is taken
  And I should be viewing the signup form
  And the data I have entered is still present

@wip
Scenario: Signing up with a malformed email address
  Given I have never signed up before
  When I click the sign up link
  Then I should see the sign up form at "/signup"

  When I fill in email address with "foo#bar.com"
  And I fill in display name with "displayname"
  And I fill in password and password confirmation with "hungry"
  And I submit the form
  Then I should see an error message that the email is not of the right format
  And I should be viewing the signup form
  And the data I have entered is still present

@wip
Scenario: Signing up with an empty email address
  Given I have never signed up before
  When I click the sign up link
  Then I should see the sign up form at "/signup"

  When I fill in display name with "displayname"
  And I fill in password and password confirmation with "hungry"
  And I submit the form
  Then I should see an error message that email is required
  And I should be viewing the signup form
  And the data I have entered is still present

@wip
Scenario: Signing up with an malformed display name
  Given I have never signed up before
  When I click the sign up link
  Then I should see the sign up form at "/signup"

  When I fill in email address with "foo@bar.com"
  And I fill in display name with "display name"
  And I fill in password and password confirmation with "hungry"
  And I submit the form
  Then I should see an error message that the display name must be only letters, numbers, dashes, or underscores
  And I should be viewing the signup form
  And the data I have entered is still present

@wip
Scenario: Signing up with an empty display name
  Given I have never signed up before
  When I click the sign up link
  Then I should see the sign up form at "/signup"

  When I fill in email address with "foo@bar.com"
  And I fill in password and password confirmation with "hungry"
  And I submit the form
  Then I should see an error message that the display name is required
  And I should be viewing the signup form
  And the data I have entered is still present

@wip
Scenario: Signing up with an empty password
  Given I have never signed up before
  When I click the sign up link
  Then I should see the sign up form at "/signup"

  When I fill in email address with "foo@bar.com"
  And I fill in display name with "displayname"
  And I submit the form
  Then I should see an error message that the password must be 6 or more characters
  And I should be viewing the signup form
  And the data I have entered is still present

@wip
Scenario: Signing up with a password confirmation that doesn't match
  Given I have never signed up before
  When I click the sign up link
  Then I should see the sign up form at "/signup"

  When I fill in email address with "foo@bar.com"
  And I fill in display name with "display name"
  And I fill in password with "hungry"
  And I fill in password confirmation with "academy"
  And I submit the form
  Then I should see an error message that the password must be 6 or more characters
  And I should be viewing the signup form
  And the data I have entered is still present

