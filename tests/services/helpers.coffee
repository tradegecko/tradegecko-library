module "App.HelpersService",
  beforeEach: ->
    @service = App.Helpers

test "parseNumber", ->
  equal @service.parseNumber("3.3", 4), 3.3,  "parses string into float"
  equal @service.parseNumber(null, 5.1), 5.1, "returns default if falsy"
  equal @service.parseNumber(NaN), 0,         "returns 0 otherwise"

test "op", ->
  _big = Big
  window.Big = undefined
  throws @service.op, "Requires Big.js", "throws Error if Big.js is not required"
  window.Big = _big

  ok isNaN(@service.op(undefined, 'plus', 1)),    "returns NaN if first value is NaN"
  ok isNaN(@service.op(1, 'plus', NaN)),          "returns NaN if second value is NaN"
  ok isNaN(@service.op(0, 'div', 0)),             "0 / 0 = NaN"
  equal @service.op(1, 'div', 0), Infinity,       "1 / 0 = Infinity"
  equal @service.op(-1, 'div', 0), -Infinity,     "-1 / 0 = -Infinity"
  equal @service.op(1, 'plus', "2"), 3,           "handles strings"
  equal @service.op(1.1, 'times', "2.2"), 2.42,   "handles floats"
  ok @service.op(1.1, 'plus', 1.3) != (1.1+1.3),  "does math correctly"

test "roundNumber", ->
  equal @service.roundNumber(1.23456, 3), 1.235,     "rounds correctly"
  equal @service.roundNumber(-1.575, 2), -1.58,      "rounds negatives correctly"
  equal @service.roundNumber("1.23456", "3"), 1.235,  "works with strings"
  equal @service.roundNumber(1.23456), 1.23456,
        "returns unrounded if no precision, account, or default currency"
