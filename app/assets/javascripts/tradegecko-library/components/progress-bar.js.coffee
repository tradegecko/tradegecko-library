###cli
`import Ember from 'ember'`
###

###
  Simple progressbar component
  By default, animates change smoothly
  Setting `jump=true` gives a more step like feel.

  {{progress-bar percent=completion}}
  {{progress-bar percent=completion jump=true}}
###

ProgressBarComponent = Ember.Component.extend
  layoutName: "progress-bar"
  classNames: ["progressbar"]
  classNameBindings: ["jump"]

  percent: null

  width: Ember.computed 'percent', ->
    Ember.String.htmlSafe "width: #{+@get('percent')}%"

#rails
App.ProgressBarComponent = ProgressBarComponent
#

###cli
`export default ProgressBarComponent`
###
