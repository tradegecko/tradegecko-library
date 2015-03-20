SortableController = Ember.ArrayController.extend App.SortableControllerMixin,
  model: [
    Ember.Object.create
      id: 3
      status: "active"
      createdAt: new Date('2012/01/01')
      note: "Allo"
    Ember.Object.create
      id: 1
      status: "active"
      createdAt: new Date('2012/02/02')
      note: null
    Ember.Object.create
      id: 2
      status: "expired"
      createdAt: new Date('2012/03/03')
      note: "Go Go Captain"
  ]

module "SortableControllerMixin",
  setup: ->
    @controller = SortableController.create()

test "defaults to sort by id", ->
  deepEqual @controller.get('arrangedContent').mapBy('id'), [1,2,3]

test "toggles sort direction when `sortOn` triggered on same property", ->
  @controller.send('sortOn', 'id')
  deepEqual @controller.get('arrangedContent').mapBy('id'), [3,2,1]

test "treats null as a value", ->
  @controller.send('sortOn', 'note')
  deepEqual @controller.get('arrangedContent').mapBy('id'), [1,3,2]

test "secondary sorts by defaultSort if the primary value is the same", ->
  @controller.send('sortOn', 'status')
  deepEqual @controller.get('arrangedContent').mapBy('id'), [1,3,2]

test "sorts by date", ->
  @controller.send('sortOn', 'createdAt')
  deepEqual @controller.get('arrangedContent').mapBy('id'), [3,1,2]

test "reverse sorts by date", ->
  @controller.send('sortOn', 'createdAt')
  @controller.send('sortOn', 'createdAt')
  deepEqual @controller.get('arrangedContent').mapBy('id'), [2,1,3]

test "respects overridden sortAscending", ->
  controller = SortableController.create(sortAscending: false)
  deepEqual controller.get('arrangedContent').mapBy('id'), [3,2,1]
