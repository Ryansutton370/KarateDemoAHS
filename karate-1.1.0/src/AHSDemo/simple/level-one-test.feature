@LevelOneTest
Feature: level one test

@LevelOneTest-UI-login
Scenario: Successful login navigates to success page, with correct heading
    #Set up chrome driver
   * def chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
   * configure driver = { type: 'chrome', executable:'#(chromePath)', showDriverLog: true }
    
    #Navigate to this url
    Given driver 'https://demo.opencart.com/admin/'
    

    #Enter the username 'AHSDemoTest' and password 'AHSDemoPwd'
    And clear('#input-username')
    And clear('#input-password')

    And input('#input-username', 'demo')
    And input("#input-password", 'demo')

    #Submit anticipates a new page load
    And submit().click("//button[@type='submit']")

    #Validate that the landing page has the header "Dashboard"
    #And def header = waitFor("//h1")
    And match text("//h1") == 'Dashboard'
    And highlight("//h1")

@LevelOneTest-API-GET 
Scenario: Get a list of users, validate that all users are formatted correctly
     Given url 'https://gorest.co.in/public/v1/users'
     When method GET
     Then status 200
    
     #Printing the response in the report allows for easier debugging
     Then print response
     
     #Validate that all ids are numbers
     #Create an array of every id in the response
     And def id = karate.jsonPath(response,"$..id")
     #Fuzzy match to ensure that all ids are numbers
     And match each id == '#number'

    #Validate that all users have a name that is a string, and is not null and not empty
    And def name = karate.jsonPath(response,"$..name")
    And match each name == '#string'
    And match each name == '#notnull'
    And match each name != ""
