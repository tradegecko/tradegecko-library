module "App.Helpers"

test "parseNumber", ->
  equal App.Helpers.parseNumber("3.3", 4), 3.3,  "parses string into float"
  equal App.Helpers.parseNumber(null, 5.1), 5.1, "returns default if falsy"
  equal App.Helpers.parseNumber(NaN), 0,         "returns 0 otherwise"

