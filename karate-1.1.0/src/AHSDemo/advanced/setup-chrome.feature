@setup-chrome 
Feature: setup-chrome

Scenario: Set up chrome driver
   #Set up chrome driver
   * def chromePath = 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
   * configure driver = { type: 'chrome', executable:'#(chromePath)', showDriverLog: true }
   