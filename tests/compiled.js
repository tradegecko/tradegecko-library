(function() {
  module("Enumerables");

  test("flatten", function() {
    deepEqual([[1], [2]].flatten(), [1, 2], "flattens arrays");
    return deepEqual([1, 2].flatten(), [1, 2], "doesn't flatten flat arrays");
  });

  test("maxBy", function() {
    equal([
      {
        value: 1
      }, {
        value: 3
      }, {
        value: 2
      }
    ].maxBy('value'), 3, "gets max by property");
    equal([
      {
        value: 1
      }, {
        value: 3
      }, {
        value: 2
      }
    ].maxBy('other', 5), 5, "returns default if no property");
    equal([].maxBy('value', 5), 5, "returns default if no elements");
    return equal([].maxBy('value'), -Infinity, "returns -Infinity otherwise");
  });

  test("sum", function() {
    var _big;
    _big = Big;
    window.Big = void 0;
    throws(App.Helpers.op, "Requires Big.js", "throws Error if Big.js is not required");
    window.Big = _big;
    equal([1, 2, 3].sum(), 6, "sums array elements");
    equal([].sum(), 0, "returns 0 if no elements");
    return equal([1.1, 1.3].sum(), 2.4, "handles floats with Big.js");
  });

  test("sumBy", function() {
    equal([
      {
        value: 1
      }, {
        value: 3
      }, {
        value: 2
      }
    ].sumBy('value'), 6, "sums by property");
    equal([
      {
        value: 1
      }, {
        value: 3
      }, {
        value: 2
      }
    ].sumBy('other'), 0, "returns 0 if no property");
    return equal([].sumBy('value'), 0, "returns 0 if elements");
  });

}).call(this);

(function() {
  module("App.Helpers");

  test("parseNumber", function() {
    equal(App.Helpers.parseNumber("3.3", 4), 3.3, "parses string into float");
    equal(App.Helpers.parseNumber(null, 5.1), 5.1, "returns default if falsy");
    return equal(App.Helpers.parseNumber(NaN), 0, "returns 0 otherwise");
  });

  test("op", function() {
    var _big;
    _big = Big;
    window.Big = void 0;
    throws(App.Helpers.op, "Requires Big.js", "throws Error if Big.js is not required");
    window.Big = _big;
    ok(isNaN(App.Helpers.op(void 0, 'plus', 1)), "returns NaN if first value is NaN");
    ok(isNaN(App.Helpers.op(1, 'plus', NaN)), "returns NaN if second value is NaN");
    ok(isNaN(App.Helpers.op(0, 'div', 0)), "0 / 0 = NaN");
    equal(App.Helpers.op(1, 'div', 0), Infinity, "1 / 0 = Infinity");
    equal(App.Helpers.op(-1, 'div', 0), -Infinity, "-1 / 0 = -Infinity");
    equal(App.Helpers.op(1, 'plus', "2"), 3, "handles strings");
    equal(App.Helpers.op(1.1, 'times', "2.2"), 2.42, "handles floats");
    return ok(App.Helpers.op(1.1, 'plus', 1.3) !== (1.1 + 1.3), "does math correctly");
  });

}).call(this);

(function() {
  module("Strings");

  test("humanize", function() {
    equal("Order".humanize(), "Sales Order", "converts special keywords");
    equal("order_line_item".humanize(), "Line Item", "converts special underscored keywords");
    equal(Ember.String.humanize(null), "", "returns blank string if falsy");
    equal("order_id".humanize(), "Order", "removes trailing _id");
    equal("orderId".humanize(), "Order", "removes trailing Id when camelCase");
    equal("order.orderNumber".humanize(), "Order Number", "gets last property");
    return equal("someLong_messy_Property".humanize(), "Some Long Messy Property", "humanizes camelCase and underscores");
  });

}).call(this);
