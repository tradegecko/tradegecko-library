module "Strings"

test "humanize", ->
  equal "Order".humanize(), "Sales Order",
        "converts special keywords"
  equal "order_line_item".humanize(), "Line Item",
        "converts special underscored keywords"
  equal Ember.String.humanize(null), "", "returns blank string if falsy"
  equal "order_id".humanize(), "Order", "removes trailing _ids"
  equal "order.orderNumber".humanize(), "Order Number", "gets last property"
  equal "someLong_messy_Property".humanize(), "Some Long Messy Property",
        "humanizes camelCase and underscores"
