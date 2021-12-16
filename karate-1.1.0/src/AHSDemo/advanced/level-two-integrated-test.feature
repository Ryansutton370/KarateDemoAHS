@LevelTwoTestUI
Feature: Opencart Add Category

@AddCategory
Scenario Outline: User navigates to Add Category form, 
    enters data, changes tabs, data remains when user returns,
    user is denied permission to add category, sees warning, and can dismiss warning
    
    #Abstract away the login flow
    * call read('login.feature')

    #Navigate to Category page
    When click(dashboardPage.catalogDropdown)
    And submit().click(dashboardPage.categoriesLink)
    
    #navigate to Add Category page
    And submit().click(categoriesPage.addNewBtn)
    
    #Example of JavaScript use
    #Category name is a name + FizzBuzz'd number
    And def numberToFizzBuzz = '<number>'
    And def fizzBuzz = call read('fizzBuzz.js')(numberToFizzBuzz)
    And def nameAndFBNumber = '<name>' + " " + fizzBuzz
    
    Then input(addCategoryPage.categoryNameInput, nameAndFBNumber)
    Then input(addCategoryPage.descriptionInput, '<description>')

    #Navigate to SEO tab, add a Keyword
    Then click(addCategoryPage.seoTab)
    And input(addCategoryPage.keywordInput, 'Test Keyword')

    #Navigate back to General tab, validate text remains as entered
    And click(addCategoryPage.generalTab)
    And match value(addCategoryPage.categoryNameInput) == nameAndFBNumber
    #The text is stored as <p> element children, so use a Tree Navigator selector
    #And def description = locate(addCategoryPage.descriptionInput).firstChild
    And match text(addCategoryPage.descriptionContent) == '<description>'

    #Click 'Save' and see warning notification
    And click(addCategoryPage.saveBtn)
    And waitForText(addCategoryPage.permissionAlert, ' Warning: You do not have permission to modify categories!')

    #Dismiss warning notification
    And click(addCategoryPage.permissionAlertExitBtn)
    #Validate that the warning notification is gone
    And def warningExists = exists(addCategoryPage.permissionAlertExitBtn)
    Then if (warningExists) karate.fail('warning did not disapppear')

    Examples:
    |name|number|description|
    |Ryan|3|Category Ryan Fizz|
    #|Eng|15|Category Eng FizzBuzz|

@EnterTodaysDate
Scenario Outline: User enters their name and a FizzBuzz'd number into a text editor
    * call read('setup-chrome.feature')
    * call read('setup-heroku-test.feature')
    Given driver 'http://the-internet.herokuapp.com/tinymce'

    #Use a JavaScript function for FizzBuzz
    And def numberToInput = '<number>'
    And def fizzBuzz = call read('fizzBuzz.js')(numberToInput)
    And def nameAndFBNumber = '<name>' + " " + fizzBuzz


    #Switch to the iframe
    When switchFrame('#mce_0_ifr')
    
    #Clear the current text
    * def clearInput = 
    """
        function() {
            var editor_id = 'tinymce';
            tinymce.get(editor_id).setContent('');
        }
    """

    Then call clearInput

    Then input(editorPage.textInput, nameAndFBNumber)

    #To show it has entered, purely for demonstration
    Then delay(1000)

    Examples:
    |name|number|
    |Ryan|3|
    #|Eng|15|
    #|Edgar|5|





