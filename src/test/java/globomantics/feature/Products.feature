Feature: Tests on the Globomantics Categories API

  Background:
    * url 'http://localhost:8080/api/'
    Given path 'authenticate'
    And request '{"username": "admin","password": "admin"}'
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * def token = response.token
    * print 'Value of the token is: ' + token

#  Scenario: Get all products
#    Given path 'product'
#    When method get
#    Then status 200

#  Scenario: Create and Delete product
#    * def productName = 'Fast train'
#    * def productJSON =
#      """
#      {
#        "name": #(productName),
#        "description": "A toy train with 3 carriages",
#        "price": "19.99",
#        "categoryId": 1,
#        "inStock": true
#      }
#      """
#
#    #Create Product
#    Given path 'product'
#    And header Authorization = 'Bearer ' + token
#    And header Content-Type = 'application/json'
#    And request productJSON
#    When method post
#    Then status 200
#    And match response.name == productName
#    * def productId = response.id
#
#    #Get Single Product
#    Given path 'product', productId
#    When method get
#    Then status 200
#    And match response.id == productId
#    And match response.name == productName
#
#    #Delete product
#    Given path 'product', productId
#    And header Authorization = 'Bearer ' + token
#    And header Content-Type = 'application/json'
#    When method delete
#    Then status 200
#    And match response == 'Product: '+productName+' deleted successfully'
#
#  Scenario: Update Product
#    * def updatedProductName = 'Updated fast train'
#    * def updatedProductJSON =
#    """
#    {
#      "name": #(updatedProductName),
#      "description": "A toy train with 3 carriages",
#      "price": "29.99",
#      "categoryId": 2,
#      "inStock": true
#    }
#    """
#
#    Given path 'product', 5
#    And header Authorization = 'Bearer ' + token
#    And header Content-Type = 'application/json'
#    And request updatedProductJSON
#    When method put
#    Then status 200
#    And match response.name == updatedProductName

  Scenario: Query Parameters
    * def categoryId = '1'
    Given path 'product'
    And param category = 1
    When method get
    Then status 200
    And match each response contains {"categoryId":"1"}
    And match each response contains {"categoryId":#(categoryId)}
    And match each response..categoryId == categoryId