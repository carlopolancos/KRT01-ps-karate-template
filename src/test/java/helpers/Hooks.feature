Feature: Example of Hooks

  Scenario: Example of Hooks
    * def testDataGenerator = Java.type('helpers.TestDataGenerator')
    * def productName = testDataGenerator.getRandomProductName()