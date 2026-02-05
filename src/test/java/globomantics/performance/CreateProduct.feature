@ignore
Feature: Create and Delete a Product for Performance Test

  Background:
    * url apiUrl
    * def productRequestBody = read('classpath:globomantics/data/newProduct.json')
    * set productRequestBody.name = __gatling.productName
    * set productRequestBody.description = __gatling.productDescription
    * set productRequestBody.price = __gatling.productPrice
    * set productRequestBody.categoryId = __gatling.productCategory

  Scenario: Create and Delete a Product for Performance Test
    Given path 'product'
    And header Content-Type = 'application/json'
    And header karate-request = "Create product: " + __gatling.productName
    And request productRequestBody
    When method post
    Then status 200
    * def productId = response.id

    * karate.pause(10000)

    Given path 'product', productId
    And header karate-request = "Delete product"
    When method delete
    Then status 200
