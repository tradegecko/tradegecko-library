Ember.computed.boundEqual = (first, second) ->
  Ember.computed first, second, (key, value) ->
    Ember.get(this, first) == Ember.get(this, second)
