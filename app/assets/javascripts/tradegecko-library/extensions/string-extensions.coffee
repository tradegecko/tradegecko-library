###cli
`import Ember from 'ember'`
###

Humanized =
  'orderLineItem':        "Line Item"
  'order':                "Sales Order"
  'constructorClassName': "Type"

StringExtensions = Ember.Mixin.create
  ###
    Humanize the string by removing underscores and capitalizing every word, e.g.
      "firstName".humanize()            // = "First Name"
      "first_name".humanize()           // = "First Name"

    Also converts specific class names into human-readable labels, e.g.
      "Order".humanize()                // = "Sales Order"

    Uses the last property in property strings, e.g.
      "variant.firstName".humanize()    // = "First Name"
  ###

  humanize: (value) ->
    return "" if Ember.isNone(value)
    # Convert to string
    value = "" + value
    # Return specific string if matches hash
    return humanized if humanized = Humanized[value.camelize()]
    # Remove trailing `_id` and `Id`
    value = value.replace(/_id$|Id$/, '')
    # Returns last property if is a property string
    value = value.split(".").get('lastObject')
    # Split words and capitalize each word
    value.underscore().split("_").map((string) ->
      string.charAt(0).toUpperCase() + string.slice(1)
    ).join(" ")


StringExtensions.apply(Ember.String)
if Ember.EXTEND_PROTOTYPES
  Ember.keys(StringExtensions.mixins[0].properties).forEach (method) ->
    String.prototype[method] = -> Ember.String[method](this)
