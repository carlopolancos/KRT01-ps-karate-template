@debug
Feature: List all products for Performance Test

  Background:
    * url apiUrl

  Scenario: Get all products
    Given path 'product'
    And header karate-request = "Get all products"
    When method get
    Then status 200