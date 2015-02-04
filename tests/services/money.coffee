module "App.MoneyService",
  beforeEach: ->
    @service = App.MoneyService.create()

test "convert", ->
  equal @service.convert(100, from: rate: 1.25), 80,  "converts to base currency"
  equal @service.convert(100, to: rate: 1.25), 125,   "converts to working currency"
  equal @service.convert(1.2, from: rate: 0.4), 3,    "does math properly"
  equal @service.convert(1.1, from: null), 1.1,       "returns value if no currency"
  equal @service.convert(1.1, from: rate: null), 1.1, "returns value if no rate"
  ok !@service.convert(null, from: rate: 1),          "returns false if no value"

test "format", ->
  _accounting = accounting
  window.accounting = undefined
  throws @service.format, "Requires accounting.js",
        "throws Error if accounting.js is not required"
  window.accounting = _accounting

  equal @service.format(123.456, "inherit", symbol: false), "123.46",
        "excludes symbol if symbol: false"

  currency = @service.get('defaultCurrency')
  currency.precision = 1
  equal @service.format(123.456, currency), "$123.5",  "formats precision"
  currency.symbol = "☃"
  equal @service.format(123.456, currency), "☃123.5",  "formats symbol"
  currency.format = "%n %u"
  equal @service.format(123.456, currency), "123.5 ☃", "formats format"
  currency.negativeFormat = "%u(%n)"
  equal @service.format(-123.456, currency), "☃(123.5)", "formats negative format"
