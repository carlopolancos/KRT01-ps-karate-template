@debug
Feature: Tests on the Globomantics Categories API

  Background:
    * url apiUrl
    * def productRequestBody = read('classpath:globomantics/data/newProduct.json')
    * callonce read('classpath:helpers/ProductSchema.feature')

  @debug
  Scenario: Get all products
    Given path 'product'
    When method get
    Then status 200
    And match response[0].name == "Vintage Minature Car"
#    And match response[0].name == "#string"
#    And match response[0].inStock == "#boolean"
#    And match each response..name == "#string"
    And match response[0].createdAt contains '2020'
    #Will only assert when existing/visible
    And match response[0].rating == '##number'

    #Schema validation
#    And match each response ==
#    """
#    {
#      "id": "#number",
#      "name": "#string",
#      "slug": "#string",
#      "description": "#string",
#      "price": "#string",
#      "categoryId": "#string",
#      "createdAt": "#string",
#      "updatedAt": "#string",
#      "inStock": "#boolean",
#    }
#    """
    And match each response == productSchema

  Scenario: Create and Delete product
    * def productName = 'Fast train'
    * set productRequestBody.name = productName

    #Create Product
    Given path 'product'
    And header Content-Type = 'application/json'
    And request productRequestBody
    When method post
    Then status 200
    And match response.name == productName
    And match response == productSchema
    * def productId = response.id

    #Get Single Product
    Given path 'product', productId
    When method get
    Then status 200
    And match response.id == productId
    And match response.name == productName
    And match response == productSchema


    #Delete product
    Given path 'product', productId
    And header Content-Type = 'application/json'
    When method delete
    Then status 200
    And match response == 'Product: '+productName+' deleted successfully'

  Scenario: Update Product
    * def updatedProductName = 'Updated fast train'
    * set productRequestBody.name = updatedProductName

    Given path 'product', 5
    And header Content-Type = 'application/json'
    And request productRequestBody
    When method put
    Then status 200
    And match response.name == updatedProductName
    And match response == productSchema

  Scenario: Query Parameters
    * def categoryId = '1'
    Given path 'product'
    And param category = 1
    When method get
    Then status 200
    And match each response contains {"categoryId":"1"}
    And match each response contains {"categoryId":#(categoryId)}
    And match each response..categoryId == categoryId
    And match each response == productSchema
