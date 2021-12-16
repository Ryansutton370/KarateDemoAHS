@login 
Feature: login

Scenario: User navigates to login page, logs in
    #Set up chrome driver
    * call read('setup-chrome.feature')

    #Set up heroku locators
    * call read('setup-opencart-test.feature')

    #Navigate to url
    Given driver 'https://demo.opencart.com/admin/'

    #Clear username and password input
    And clear(loginPage.usernameInput)
    And clear(loginPage.passwordInput)

    #Enter test env password
    And input(loginPage.usernameInput, loginPage.testUsername)
    And input(loginPage.passwordInput, loginPage.testPassword)

    And submit().click(loginPage.loginBtn)

    #Validate successful navigation
    And match text(dashboardPage.dashboardHeading) == 'Dashboard'