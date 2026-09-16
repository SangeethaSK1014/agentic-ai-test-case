Feature: User Login

  Scenario: Successful login with valid credentials
    Given Active, registered user exists.
    And the test data is Email: user@example.com; Password: ValidPass123!
    When 1. Open login page. 2. Enter email. 3. Enter password. 4. Click Log In.
    Then Dashboard is displayed. Session cookie (or token) is created. Redirect URL = /dashboard.

  Scenario: Invalid password – generic error
    Given Active, registered user exists.
    And the test data is Email: user@example.com; Password: WrongPass!
    When 1. Open login page. 2. Enter correct email. 3. Enter wrong password. 4. Click Log In.
    Then Login page remains. Error message exactly "Invalid email or password". No session is created.

  Scenario: Unregistered email – same generic error
    Given No account exists for the provided email.
    And the test data is Email: unknown@example.com; Password: AnyPass123!
    When 1. Open login page. 2. Enter unregistered email. 3. Enter password. 4. Click Log In.
    Then Login page remains. Error message "Invalid email or password" is shown. No session is created.

  Scenario: Empty fields validation
    Given Active, registered user exists.
    And the test data is Email: (blank); Password: (blank)
    When 1. Open login page. 2. Leave email and password fields empty. 3. Click Log In.
    Then Inline validation prompts to fill required fields. No request is sent to the server.

  Scenario: Invalid email format
    Given Active, registered user exists.
    And the test data is Email: invalid-email; Password: ValidPass123!
    When 1. Open login page. 2. Enter invalid email format. 3. Enter password. 4. Click Log In.
    Then Inline message "Enter a valid email address" is displayed. No request is sent.

  Scenario: Account lockout after consecutive failed attempts
    Given Active, registered user exists.
    And the test data is Email: user@example.com; Password: WrongPass! (used for 5 attempts)
    When 1. Open login page. 2. Attempt login with wrong password five times within 15 minutes. 3. Attempt login with correct password after the fifth failure.
    Then After fifth failure, account is locked. When correct credentials are entered, message "Your account is locked. Try again later." is shown. No login occurs.

  Scenario: Case sensitivity of email and password
    Given Active, registered user exists.
    And the test data is Email: USER@EXAMPLE.COM; Password: ValidPass123! (correct case) and Password: validpass123! (incorrect case)
    When 1. Open login page. 2. Enter email with different case but same letters. 3. Enter correct password case and click Log In – expect success. 4. Repeat with password case altered and click Log In – expect error.
    Then Email case variation is accepted; login succeeds with correct password case. Password case variation is rejected with error "Invalid email or password".

  Scenario: Session persistence after successful login
    Given User has successfully logged in.
    And the test data is N/A
    When 1. Perform a successful login. 2. Refresh the browser without logging out.
    Then User remains logged in; session persists for up to 24 hours. Dashboard remains accessible.

  Scenario: Login attempt with inactive account
    Given User account is deactivated.
    And the test data is Email: inactive@example.com; Password: ValidPass123!
    When 1. Open login page. 2. Enter email of inactive account. 3. Enter password. 4. Click Log In.
    Then Error message "This account is inactive. Contact support." is displayed. User is not logged in and no session is created.
