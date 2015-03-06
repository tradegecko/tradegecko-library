###cli
`import Ember from 'ember'`
###

###rails
#= require big
###

HelpersService = Ember.Object.extend

  ###
    Performs a Big.js operation between two numbers.

    @requires Big.js

    @param {Number} first, second
      The two numbers to perform the operation on.

    @param {String} operator
      "plus", "minus", "times", "div", "pow"
      Note that this param comes in between the two numbers for readability.
  ###

  op: (first, operator, second) ->
    throw "Requires Big.js" if typeof Big is "undefined"
    return NaN if (isNaN(first) || isNaN(second))
    # parseNumbers
    first  = +first
    second = +second
    if operator == "div" && second == 0
      # Handle division by zero
      return NaN if first == 0
      if first > 0 then Infinity else -Infinity
    # Handle the infinities because Big.js doesn't
    else if Math.abs(first) == Infinity || Math.abs(second) == Infinity
      operatorMap =
        plus:  "+"
        minus: "-"
        times: "*"
        div:   "/"
      op = operatorMap[operator]
      eval "#{first} #{op} #{second}"
    else
      +Big(first)[operator](second)

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


  ###
    Rounds a number to the specified precision.
    Uses the defaultCurrency's precision by default

    @param {Number} number
      The value to be rounded

    @param {Number} precision
      Number of decimal places to round to. Can be omitted.
  ###

  roundNumber: (number, precision) ->
    unless precision
      return number unless @get('defaultCurrency')
      precision = @get('defaultCurrency.precision')
    factor = Math.pow(10, precision)
    if number > 0
      Math.floor(number * factor + 0.5) / factor
    else
      Math.ceil(number * factor - 0.5) / factor



  ###
    Retrieves the default currency of the current account factory,
    `current:account` if set (typically by an initializer).

    Similar function exists in service:money
  ###

  defaultCurrency: ( ->
    @container?.lookup("current:account")?.get('defaultCurrency')
  ).property().volatile()


if App # Rails
  App.HelpersService = HelpersService
  App.Helpers = App.__container__.lookup('service:helpers')

###cli
`export default HelpersService`
###
