Feature: Tests on the Globomantics Categories API

    Background:
        * url apiUrl
        * def testData = callonce read('classpath:helpers/Hooks.feature')
        * def productName = testData.productName
        * configure afterScenario = function() { karate.log('Scenario complete') }
        * configure afterFeature =
        """
            function() {
                karate.log('Feature complete')
                karate.call('classpath:helpers/PrintMessage.feature')
            }
        """

    Scenario: Get all categories
        Given path 'category'
        When method get
        Then status 200
        * print 'productName value is: ' + productName
        * def fun =
        """
            function() {
                for (var i=1; i <=5; i++){
                    karate.log('Loop iteration: 1')
                    karate.call('classpath:helpers/PrintMessage.feature')
        }
            }
        """
        * call fun

    Scenario: Get single category
        Given path 'category', 1
        When method get
        Then status 200
        * print 'productName value is: ' + productName
        * def slug = response.slug
        * if (slug == 'babies-toys') karate.log('Slug is babies-toys')
        * def checkSlug = slug == 'babies-toys' ? 'Slug is expected' : 'NOT expected slug'
        * print checkSlug
        * if (responseStatus == 200) karate.call('classpath:helpers/PrintMessage.feature')

        * if (responseStatus == 200) karate.abort()
#        * if (responseStatus == 200) karate.fail('failure eror Message')
        Given pahh 'catgeory', 2
        When method get
        Then status 200


#    Scenario: Create a category
#        Given path 'category'
#        And header Content-Type = 'application/json'
#        And request '{"name":"My new category"}'
#        When method post
#        Then status 200

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

    Scenario: Get all products - with retry
        * configure retry = {count:10, interval:5000}

        Given path 'product'
        And retry until response[0].categoryId == '1'
        When method get
        Then status 200

        * def sleep = function(pause) { java.lang.Thread.sleep(pause*1000) }
        * print 'Starting sleep'
        * sleep(5)
        * print 'Ending sleep'