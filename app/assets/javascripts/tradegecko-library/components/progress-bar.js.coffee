###cli
`import Ember from 'ember'`
###
ProgressBarComponent = Ember.Component.extend
  classNames: ["progressbar"]

  percent: null

  width: ( ->
    "width: #{@get('percent')}%"
  ).property("percent")

#rails
App.ProgressBarComponent= ProgressBarComponent
#

###cli
`export default ProgressBarComponent`
###
