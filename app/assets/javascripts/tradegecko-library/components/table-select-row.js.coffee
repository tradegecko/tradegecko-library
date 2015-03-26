###cli
`import Ember from 'ember'`
###
TableSelectRowComponent = Ember.Component.extend
  classNames: "table-cell cell_select"
  layoutName: "table-select-row"

  click: (event) ->
    event.stopPropagation()

#rails
App.TableSelectRowComponent = TableSelectRowComponent
#

###cli
`export default TableSelectRowComponent`
###
