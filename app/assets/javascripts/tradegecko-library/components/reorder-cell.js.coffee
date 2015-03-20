App.ReorderCellComponent = Ember.Component.extend
  layoutName: "tradegecko-library/reorder-cell"
  tagName: "a"
  href: "#"
  attributeBindings: "href"
  classNames: "table-cell"
  classNameBindings: "isCurrent cellClassName".w()

  isCurrent: Ember.computed.boundEqual('collection.currentSort', 'sortOn')

  cellClassName: ( ->
    # Humanize to get last property, then dasherize
    "cell_" + @get('sortOn').humanize().dasherize()
  ).property('sortOn')

  click: (event) ->
    event.preventDefault()
    @get('collection').send('sortOn', @get("sortOn"))

  cellText: ( ->
    @get("label") || Ember.String.humanize(@get("sortOn"))
  ).property("label")

