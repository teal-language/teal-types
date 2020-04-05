local json = require("json")

local encoded = json.encode({ 1, 2, 3, { x = 10 } })
assert(encoded == '[1,2,3,{"x":10}]')

local decoded = json.decode(encoded)
assert(json.encode(decoded) == '[1,2,3,{"x":10}]')
