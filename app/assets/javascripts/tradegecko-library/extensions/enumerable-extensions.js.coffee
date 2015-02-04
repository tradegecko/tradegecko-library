EnumerableExtensions = Ember.Mixin.create

  ###
    Flattens the array
    E.g. [[1], [2,3]].flatten(); // = [1, 2, 3]
  ###

  flatten: ->
    Array::concat.apply([], this)

  ###
    Finds and returns the highest value of a given property in an enumerable.
    E.g. [{age: 7}, {age: 77}].maxBy('age'); // = 77

    @param {String} key
      The property for which we want the largest value.

    @param {Number} start
      Optional minimum value. It's the value that will be returned if no higher value is found.
  ###

  maxBy: (key, start) ->
    @reduce (previousValue, item, index, enumerable) ->
      value = Ember.get(item, key)
      if value > previousValue then value else previousValue
    , start || -Infinity

  ###
    Computes the sum of the elements in an enumerable.
    E.g. [7, 77].sum()); // = 84

    @requires Big.js

    @param {String} key
      The property we want the sum of.
  ###

  sum: ->
    throw "Requires Big.js" if typeof Big is "undefined"
    +@reduce (previousValue, value, index, enumerable) ->
      value = 0 if isNaN(value)
      previousValue.plus +value
    , new Big(0)

  sumBy: (key) ->
    @mapBy(key).sum()


Ember.Enumerable.reopen(EnumerableExtensions)
EnumerableExtensions.apply(Array.prototype) if Ember.EXTEND_PROTOTYPES
