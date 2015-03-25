App.TableSelectRowComponent = Ember.Component.extend
  classNames: "table-cell cell_select"
  layoutName: "table-select-row"

  click: (event) ->
    event.stopPropagation()
