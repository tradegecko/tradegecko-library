(function() {
  var EnumerableExtensions;

  if (!Ember) {
    return;
  }

  EnumerableExtensions = Ember.Mixin.create({

    /*
      Flattens the array
      E.g. [[1], [2,3]].flatten(); // = [1, 2, 3]
     */
    flatten: function() {
      return Array.prototype.concat.apply([], this);
    },

    /*
      Finds and returns the highest value of a given property in an enumerable.
      E.g. [{age: 7}, {age: 77}].maxBy('age'); // = 77
    
      @param {String} key
        The property for which we want the largest value.
    
      @param {Number} start
        Optional minimum value. It's the value that will be returned if no higher value is found.
     */
    maxBy: function(key, start) {
      return this.reduce(function(previousValue, item, index, enumerable) {
        var value;
        value = Ember.get(item, key);
        if (value > previousValue) {
          return value;
        } else {
          return previousValue;
        }
      }, start || -Infinity);
    },

    /*
      Computes the sum of the elements in an enumerable.
      E.g. [7, 77].sum()); // = 84
    
      @requires Big.js
    
      @param {String} key
        The property we want the sum of.
     */
    sum: function() {
      return +this.reduce(function(previousValue, value, index, enumerable) {
        if (isNaN(value)) {
          value = 0;
        }
        return previousValue.plus(+value);
      }, new Big(0));
    },
    sumBy: function(key) {
      return this.mapBy(key).sum();
    }
  });

  Ember.Enumerable.reopen(EnumerableExtensions);

  if (Ember.EXTEND_PROTOTYPES) {
    EnumerableExtensions.apply(Array.prototype);
  }

}).call(this);

(function() {
  var Humanized, StringExtensions, fn, method, _ref;

  if (!Ember) {
    return;
  }

  Humanized = {
    'orderLineItem': "Line Item",
    'order': "Sales Order",
    'constructorClassName': "Type"
  };

  StringExtensions = Ember.Mixin.create({

    /*
      Humanize the string by removing underscores and capitalizing every word, e.g.
        "firstName".humanize()            // = "First Name"
        "first_name".humanize()           // = "First Name"
    
      Also converts specific class names into human-readable labels, e.g.
        "Order".humanize()                // = "Sales Order"
    
      Uses the last property in property strings, e.g.
        "variant.firstName".humanize()    // = "First Name"
     */
    humanize: function(value) {
      var humanized;
      if (Ember.isNone(value)) {
        return "";
      }
      value = "" + value;
      if (humanized = Humanized[value.camelize()]) {
        return humanized;
      }
      value = value.replace(/_id$/, '');
      value = value.split(".").get('lastObject');
      return value.underscore().split("_").map(function(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
      }).join(" ");
    }
  });

  StringExtensions.apply(Ember.String);

  if (Ember.EXTEND_PROTOTYPES) {
    _ref = StringExtensions.mixins[0].properties;
    for (method in _ref) {
      fn = _ref[method];
      String.prototype[method] = function() {
        return fn(this);
      };
    }
  }

}).call(this);

(function() {
  if (!Ember) {
    return;
  }

  App.Helpers = Ember.Object.createWithMixins({

    /*
      Performs a Big.js operation between two numbers.
    
      @requires Big.js
    
      @param {Number} first, second
        The two numbers to perform the operation on.
    
      @param {String} operator
        "plus", "minus", "times" or "divide".
        Note that this param comes in between the two numbers for readability.
     */
    op: function(first, operator, second) {
      if (!Big) {
        throw "Requires Big.js";
      }
      if (isNaN(first) || isNaN(second)) {
        return NaN;
      }
      if (operator === "div" && +second === 0) {
        if (first === 0) {
          return NaN;
        }
        if (first > 0) {
          return Infinity;
        } else {
          return -Infinity;
        }
      } else {
        return +Big(+first)[operator](+second);
      }
    },

    /*
      Parses a value into a float. Defaults to 0.
      This should be used instead of parseFloat where possible.
    
      @param {Number} number
        The value to be parsed
    
      @param {Number} defaultValue
        The value to use if `number` is undefined or NaN. Defaults to 0.
     */
    parseNumber: function(number, defaultValue) {
      var value;
      if (defaultValue == null) {
        defaultValue = 0;
      }
      value = parseFloat(number);
      if (isNaN(value)) {
        value = defaultValue;
      }
      return value;
    }
  });

}).call(this);
