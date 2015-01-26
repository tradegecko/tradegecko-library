return unless Ember

EnumerableExtensions = Ember.Mixin.create

  flatten: ->
    Array::concat.apply([], this)

  ###
    Finds and returns the highest value of a given property in an enumerable.
    Ex: [{age: 7}, {age: 77}].maxBy('age'); // = 77

    @param {String} key
      The property for which we want the largest value.

    @param {Number} start
      Optional minimum value. It's the value that will be returned if no higher value is found.

    @returns {Number}
      The highest value for the given property.
  ###

  maxBy: (key, start) ->
    @reduce (previousValue, item, index, enumerable) ->
      value = Ember.get(item, key)
      if value > previousValue then value else previousValue
    , start || -Infinity

  ###
    Computes the sum of a given property in an enumerable.
    Ex: [{age: 7}, {age: 77}].sumBy('age'); // = 84

    @param {String} key
      The property we want the sum of.

    @returns {Number}
      The sum of the given property.
  ###

  sumBy: (key) ->
    decimal = @reduce (previousValue, item, index, enumerable) ->
      value = Ember.get(item, key)
      value = 0 if isNaN(value)
      previousValue.plus +value
    , new Big(0)
    return +decimal


Ember.Enumerable.reopen(EnumerableExtensions)
EnumerableExtensions.apply(Array.prototype) if Ember.EXTEND_PROTOTYPES
