###cli
`import Ember from 'ember'`
###
SortableControllerMixin = Ember.Mixin.create
  defaultSortProperty: 'id'

  setDefaults: ( ->
    @set('defaultSortAscending', @get('sortAscending'))
    @_resetSortable()
  ).on('init')

  sortParam: ( ->
    direction = if @get('sortAscending') then "asc" else "desc"
    sort      = @get('currentSort').underscore()
    "#{sort} #{direction}"
  ).property('sortAscending', 'currentSort')

  _resetSortable: ->
    @setProperties
      sortProperties: [@get('defaultSortProperty')]
      sortAscending:  @get('defaultSortAscending')

  currentSort: ( (key, value) ->
    if arguments.length is 1
      @get('sortProperties.firstObject')
    else
      values = value.split(",").concat(@get('defaultSortProperty')).compact()
      @set('sortProperties', values)
      value
  ).property('sortProperties')

  actions:
    sortOn: (value) ->
      if @get('currentSort') == value
        @toggleProperty('sortAscending')
      else
        @set('sortAscending', @get('defaultSortAscending'))
      @set('currentSort', value)

#rails
App.SortableControllerMixin = SortableControllerMixin
#

###cli
`export default SortableControllerMixin`
###
