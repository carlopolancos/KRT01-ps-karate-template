Feature: Product Schema

  Scenario: Product Schema
  * def productSchema =
    """
    {
      "id": "#number",
      "name": "#string",
      "slug": "#string",
      "description": "#string",
      "price": "#string",
      "categoryId": "#string",
      "createdAt": "#string",
      "updatedAt": "#string",
      "inStock": "#boolean",
    }
    """