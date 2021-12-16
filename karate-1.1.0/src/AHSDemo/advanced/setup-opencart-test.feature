@setupopencartlocators
Feature: Set up open cart locators

Scenario: Get all page objects from opencart json, format for ease of use
#Get page object locators
* def locators = call read 'opencart-locators.json'
#Define locators for each screen for easier typing
* def loginPage = locators.loginPage
* def dashboardPage = locators.dashboardPage
* def categoriesPage = locators.categoriesPage
* def addCategoryPage = locators.addCategoryPage