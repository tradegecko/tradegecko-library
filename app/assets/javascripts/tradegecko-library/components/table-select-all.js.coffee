App.TableSelectAllComponent = Ember.Component.extend
  classNames: "table-cell cell_select"
  layoutName: "tradegecko-library/table-select-all"

  selectedAll: ((key, value) ->
    if arguments.length is 2
      @get('content').setEach('selected', value)
      value
    else
      @get('content').isEvery('selected')
  ).property('content.@each.selected')
