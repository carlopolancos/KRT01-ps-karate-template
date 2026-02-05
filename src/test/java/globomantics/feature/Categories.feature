Feature: Tests on the Globomantics Categories API

  Background:
    * url apiUrl

  @stable
  Scenario: Get all categories
    Given path 'category'
    When method get
    Then status 200

#  Scenario: Create a category
#    Given path 'category'
#    And header Content-Type = 'application/json'
#    And request '{"name":"My new category"}'
#    When method post
#    Then status 200

  @skip
  Scenario: Create Update and Delete category
    * def categoryName = 'Master New Category'
    * def categoryNameUpdated = 'Updated Master New Category'

    #Create Category
    Given path 'category'
    And header Content-Type = 'application/json'
    And request '{"name":"'+categoryName+'"}'
    When method post
    Then status 200
    And match response.name == categoryName
    * def categoryId = response.id

    #Get and Verify status
    Given path 'category', categoryId
    When method get
    Then status 200
    And match response.id == categoryId
    And match response.name == categoryName

    #Update Category
    Given path 'category', categoryId
    And header Content-Type = 'application/json'
    And request '{"name":"'+categoryNameUpdated+'"}'
    When method put
    Then status 200
    And match response.name == categoryNameUpdated

    #Get and Verify status
    Given path 'category', categoryId
    When method get
    Then status 200
    And match response.id == categoryId
    And match response.name == categoryNameUpdated

    #Delete Category
    Given path 'category', categoryId
    And header Content-Type = 'application/json'
    When method delete
    Then status 200
    And match response == 'Category: ' + categoryNameUpdated + ' deleted successfully'