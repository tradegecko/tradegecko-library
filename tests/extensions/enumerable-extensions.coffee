module "Enumerables"

test "flatten", ->
  deepEqual [[1],[2]].flatten(), [1,2], "flattens arrays"
  deepEqual [1,2].flatten(), [1,2],     "doesn't flatten flat arrays"

test "maxBy", ->
  equal [{value: 1}, {value: 3}, {value: 2}].maxBy('value'), 3,
        "gets max by property"
  equal [{value: 1}, {value: 3}, {value: 2}].maxBy('other', 5), 5,
        "returns default if no property"
  equal [].maxBy('value', 5), 5,
        "returns default if no elements"
  equal [].maxBy('value'), -Infinity, "returns -Infinity otherwise"

test "sum", ->
  _big = Big
  window.Big = undefined
  throws App.Helpers.op, "Requires Big.js", "throws Error if Big.js is not required"
  window.Big = _big

  equal [1,2,3].sum(), 6,     "sums array elements"
  equal [].sum(), 0,          "returns 0 if no elements"
  equal [1.1,1.3].sum(), 2.4, "handles floats with Big.js"

test "sumBy", ->
  equal [{value: 1}, {value: 3}, {value: 2}].sumBy('value'), 6,
        "sums by property"
  equal [{value: 1}, {value: 3}, {value: 2}].sumBy('other'), 0,
        "returns 0 if no property"
  equal [].sumBy('value'), 0,
        "returns 0 if elements"
