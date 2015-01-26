return unless Ember

App.Helpers = Ember.Object.createWithMixins

  ###
    Performs a Big.js operation between two numbers.

    @requires Big.js

    @param {Number} first, second
      The two numbers to perform the operation on.

    @param {String} operator
      "plus", "minus", "times" or "divide".
      Note that this param comes in between the two numbers for readability.
  ###

  op: (first, operator, second) ->
    throw "Requires Big.js" unless Big
    return NaN if (isNaN(first) || isNaN(second))
    if operator == "div" && +second == 0
      # Handle division by zero
      return NaN if first == 0
      if first > 0 then Infinity else -Infinity
    else
      +Big(+first)[operator](+second)

  ###
    Parses a value into a float. Defaults to 0.
    This should be used instead of parseFloat where possible.

    @param {Number} number
      The value to be parsed

    @param {Number} defaultValue
      The value to use if `number` is undefined or NaN. Defaults to 0.
  ###

  parseNumber: (number, defaultValue=0) ->
    value = parseFloat(number)
    value = defaultValue if isNaN(value)
    value
