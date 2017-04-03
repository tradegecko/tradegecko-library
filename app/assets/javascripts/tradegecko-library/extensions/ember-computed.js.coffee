###cli
`import Ember from 'ember'`
###
Ember.computed.boundEqual = (first, second) ->
  Ember.computed first, second, (key, value) ->
    Ember.get(this, first) == Ember.get(this, second)

Ember.computed.boundGte = (first, second) ->
  Ember.computed first, second, (key, value) ->
    Ember.get(this, first) >= Ember.get(this, second)

Ember.computed.boundGt = (first, second) ->
  Ember.computed first, second, (key, value) ->
    Ember.get(this, first) > Ember.get(this, second)

Ember.computed.boundLte = (first, second) ->
  Ember.computed first, second, (key, value) ->
    Ember.get(this, first) <= Ember.get(this, second)

Ember.computed.boundLt = (first, second) ->
  Ember.computed first, second, (key, value) ->
    Ember.get(this, first) < Ember.get(this, second)
