App.TableSelectRowComponent = Ember.Component.extend
  classNames: "table-cell cell_select"
  templateName: "tradegecko-library/table-select-row"

  click: (event) ->
    event.stopPropagation()
