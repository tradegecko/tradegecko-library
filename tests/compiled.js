(function() {
  module("App.Helpers");

  test("parseNumber", function() {
    equal(App.Helpers.parseNumber("3.3", 4), 3.3, "parses string into float");
    equal(App.Helpers.parseNumber(null, 5.1), 5.1, "returns default if falsy");
    return equal(App.Helpers.parseNumber(NaN), 0, "returns 0 otherwise");
  });

}).call(this);
