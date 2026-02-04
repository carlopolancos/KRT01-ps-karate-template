Feature: Video Game Database Test Script
  for API specification, see: https://videogamedb.uk/swagger-ui/index.html

  Background:
    Given url 'https://videogamedb.uk/api/v2'

  Scenario: get all video games and then get the first game by id
    Given path 'videogame'
    When method get
    Then status 200

    * def firstGame = response[0]

    Given path 'videogame', firstGame.id
    When method get
    Then status 200

  Scenario: create a videogame
  * def newVideoGame =
  """
  {
    "category": "Platform",
    "name": "Mario" ,
    "rating": "Mature",
    "releaseDate": "2012-05-04",
    "reviewScore": 85
  }
  """

  Given path 'videogame'
  And request newVideoGame
  When method post
  Then status 200