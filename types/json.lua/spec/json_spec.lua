local tl = require("tl")
local util = require("spec_util")

describe("json", function()
   describe("encode", function()
      it("has a proper type declaration", util.check [[
         local json = require("json")

         local encoded: string = json.encode({ 1, 2, 3, { x = 10 } })
         assert(encoded == '[1,2,3,{"x":10}]')
      ]])
   end)

   describe("decode", function()
      it("has a proper type declaration", util.check [[
         local json = require("json")

         local str = '[1,2,3,{"x":10}]'
         local decoded: any = json.decode(str)
         assert(json.encode(decoded) == str)
      ]])
   end)
end)
