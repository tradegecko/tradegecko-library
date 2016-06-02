###cli
`import Ember from 'ember'`
`import Helpers from './helpers'`
`import accounting from 'accounting'`
###

###rails
#= require accountingjs
###

#rails
Helpers = App.Helpers if App
#

MoneyService = Ember.Object.extend

  ###
    Converts a value from the working currency to the base currency.
          - OR -     from the base currency to the working currency.

    E.g. `App.Money.convert(orderTotal, from: rate)`
         `App.Money.convert(baseTotal, to: rate)`

    Note: currency `rate` is in BASE/WORKING
    E.g. Base currency:    SGD
         Working currency: EUR
         `currency.rate` is SGD/EUR = 0.64
         i.e. 1 SGD = 0.64 EUR

    @param {Number} value
      The value to convert

    @param {Object} opts
      Object with one of the following keys:

        `from:` rate
        Converts working currency to base currency

        `to:` rate
        Converts base currency to working currency
  ###

  convert: (value, opts={}) ->
    return unless value
    return value unless rate = opts.from || opts.to

    if opts.from
      Helpers.op(value, 'div', rate)
    else
      Helpers.op(value, 'times', rate)

  ###
    Formats a currency amount for display, according to the Currency
    object and opts hash.

    E.g. `App.Money.format(12.3456, currency: currency, symbol: "$")`

    @requires Accounting.js

    @param {Number} value
      The currency amount to format

    @param {Object} currency
      Formats according to the currency's properties:
        `symbol`                  {String} e.g. '$'
        `precision`               {Number} Number of decimal places
        `decimal`  or `separator` {String} e.g. '.' in $123.45
        `thousand` or `delimiter` {String} e.g. ',' in ¥100,000
        `format`                  {String} %u => Symbol
                                           $n => Numeric value
    @param {Object} opts
      `symbol` {String || `false`}
      Overrides the currency's symbol. Displays nothing if `false`.
  ###

  format: (value, currency="inherit", opts={}) ->
    throw "Requires accounting.js" if typeof accounting is "undefined"
    return "" if Ember.isNone(value)
    currency = @get('defaultCurrency') if currency == "inherit"
    # Get formatting properties from currency
    keys  = "symbol decimal thousand precision format negativeFormat".w()
    props = Ember.getProperties(currency, keys)
    props = @_normalizeNegativeFormat(props)
    # Hide symbol if overriden with `false`
    if opts.symbol == false
      props.symbol = ""
      props.format = "%n"
    # Catch Rails error if precision is too large
    props.precision = 6 if props.precision > 20
    accounting.formatMoney(value, props)

  _normalizeNegativeFormat: (props) ->
    # Normalizes format to handle negativeFormat
    if props.negativeFormat
      props.format =
        pos:  @_normalizeFormat(props.format)
        zero: @_normalizeFormat(props.format)
        neg:  @_normalizeFormat(props.negativeFormat)
    else
      props.format = @_normalizeFormat(props.format)
    return props

  _normalizeFormat: (format) ->
    # Normalizes format to match accounting.js
    #   %n -> %v (number value)
    #   %u -> %s (symbol)
    format.replace("%n", "%v").replace("%u", "%s")


  ###
    Retrieves the default currency of the current account factory,
    `current:account` if set (typically by an initializer).

    Otherwise returns a default currency for formatting with rate 1.
  ###

  defaultCurrency: ( ->
    @container?.lookup("current:account")?.get('defaultCurrency') ||
    @container?.lookup('service:session')?.get('account.defaultCurrency') ||
      symbol:    "$"
      precision:  2
      decimal:   "."
      thousand:  ","
      format:    "%u%n"
      rate:      1
  ).property().volatile()

#rails
App.MoneyService = MoneyService
#

###cli
`export default MoneyService`
###
