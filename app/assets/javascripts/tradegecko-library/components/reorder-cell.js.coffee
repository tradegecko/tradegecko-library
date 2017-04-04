###cli
`import Ember from 'ember'`
###
ReorderCellComponent = Ember.Component.extend
  layoutName: "reorder-cell"
  tagName: "a"
  href: "#"
  attributeBindings: "href"
  classNames: "table-cell"
  classNameBindings: "isCurrent cellClassName tooltip:tooltip_cell".w()

  isCurrent: Ember.computed 'collection.currentSort', 'sortOn', ->
    this.get('collection.currentSort') == this.get('sortOn')

  cellClassName: Ember.computed 'sortOn', ->
    # Humanize to get last property, then dasherize
    "cell_" + @get('sortOn').humanize().dasherize()

  click: (event) ->
    event.preventDefault()
    @get('collection').send('sortOn', @get("sortOn"))

  cellText: Ember.computed 'label', ->
    @get("label") || Ember.String.humanize(@get("sortOn"))

#rails
App.ReorderCellComponent = ReorderCellComponent
#

###cli
`export default ReorderCellComponent`
###
