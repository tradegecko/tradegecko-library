module "App.Helpers"

test "parseNumber", ->
  equal App.Helpers.parseNumber("3.3", 4), 3.3,  "parses string into float"
  equal App.Helpers.parseNumber(null, 5.1), 5.1, "returns default if falsy"
  equal App.Helpers.parseNumber(NaN), 0,         "returns 0 otherwise"

test "op", ->
  _big = Big
  window.Big = undefined
  throws App.Helpers.op, "Requires Big.js", "throws Error if Big.js is not required"
  window.Big = _big

  ok isNaN(App.Helpers.op(undefined, 'plus', 1)),    "returns NaN if first value is NaN"
  ok isNaN(App.Helpers.op(1, 'plus', NaN)),          "returns NaN if second value is NaN"
  ok isNaN(App.Helpers.op(0, 'div', 0)),             "0 / 0 = NaN"
  equal App.Helpers.op(1, 'div', 0), Infinity,       "1 / 0 = Infinity"
  equal App.Helpers.op(-1, 'div', 0), -Infinity,     "-1 / 0 = -Infinity"
  equal App.Helpers.op(1, 'plus', "2"), 3,           "handles strings"
  equal App.Helpers.op(1.1, 'times', "2.2"), 2.42,   "handles floats"
  ok App.Helpers.op(1.1, 'plus', 1.3) != (1.1+1.3),  "does math correctly"
