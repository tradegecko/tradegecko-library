###cli
`import Ember from 'ember'`
###
TooltipCellComponent = Ember.Component.extend
  layoutName: "tooltip-cell"
  classNames: "table-cell tooltip_cell"


#rails
App.TooltipCellComponent = TooltipCellComponent
#

###cli
`export default TooltipCellComponent`
###
