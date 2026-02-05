Feature: Create Authentication Token

  Scenario:
    * url apiUrl
    Given path 'authenticate'
#    And request '{"username": "admin","password": "admin"}'
    And request {"username": "#(adminUsername)","password": "#(adminPassword)"}
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    * def token = response.token
    * print 'Value of the token is: ' + token
