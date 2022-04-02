local match = require('luassert.match')

describe("Tests dealing with spies", function()
   local record Test
      record Foo
         bar:{string}|string
      end
      key:function(any):string
      foo:Foo
   end
   local test:Test = {}

   before_each(function()
      assert:set_parameter("TableFormatLevel", 3)
      test = {
         key = function(_:any):string
            return "derp"
         end,
         foo = { bar = "" }
      }
   end)

   it("checks if a spy actually executes the internal function", function()
      spy.on(test, "key")
      assert.is_true(test.key() == "derp")
   end)

   it("checks to see if spy keeps track of arguments", function()
      spy.on(test, "key")

      test.key("derp")
      assert.spy(test.key).was_called_with("derp")
      assert.errors(function() assert.spy(test.key).was_called_with("herp") end)
   end)

   it("checks to see if spy keeps track of returned arguments", function()
      spy.on(test, "key")

      test.key()
      assert.spy(test.key).was_returned_with("derp")
      assert.errors(function() assert.spy(test.key).was_returned_with("herp") end)
   end)

   it("checks to see if spy keeps track of number of calls", function()
      spy.on(test, "key")
      test.key()
      test.key("test")
      assert.spy(test.key).was_called(2)
   end)

   it("checks returned_with() assertions", function()
      local s = spy.new(function(...):any return ... end)
      local t:Test = { foo = { bar = { "test" } } }
      local _ = match._

      s(1, 2, 3)
      s("a", "b", "c")
      s(t)
      t.foo.bar = "value"

      assert.spy(s).was_returned_with(1, 2, 3)
      assert.spy(s).was_not_returned_with({1, 2, 3}) -- mind the accolades
      assert.spy(s).was_returned_with(_, 2, 3) -- matches don't care
      assert.spy(s).was_returned_with(_, _, _) -- matches multiple don't cares
      assert.spy(s).was_not_returned_with(_, _, _, _) -- does not match if too many args
      assert.spy(s).was_returned_with({ foo = { bar = { "test" } } }) -- matches original table
      assert.spy(s).was_not_returned_with(t) -- does not match modified table
      assert.error_matches(
         function() assert.spy(s).returned_with(5, 6) end,
         "Function never returned matching arguments.\n"
            .. "Returned %(last call if any%):\n"
            .. "%(values list%) %(%(table: 0x%x+%) {\n"
            .. "  %[foo%] = {\n"
            .. "    %[bar%] = {\n"
            .. "      %[1%] = 'test' } } }.\n"
            .. "Expected:\n"
            .. "%(values list%) %(%(number%) 5, %(number%) 6%)")
   end)

   it("checks called() and called_with() assertions", function()
      local s = spy.new(function() end)
      local t:Test = { foo = { bar = { "test" } } }
      local _ = match._

      s(1, 2, 3)
      s("a", "b", "c")
      s(t)
      t.foo.bar = "value"

      assert.spy(s).was_called()
      assert.spy(s).was_called(3) -- 3 times!
      assert.spy(s).was_not_called(4)
      assert.spy(s).was_not_called_with({1, 2, 3}) -- mind the accolades
      assert.spy(s).was_called_with(1, 2, 3)
      assert.spy(s).was_called_with(_, 2, 3) -- matches don't care
      assert.spy(s).was_called_with(_, _, _) -- matches multiple don't cares
      assert.spy(s).was_not_called_with(_, _, _, _) -- does not match if too many args
      assert.spy(s).was_called_with({ foo = { bar = { "test" } } }) -- matches original table
      assert.spy(s).was_not_called_with(t) -- does not match modified table
      assert.error_matches(
         function() assert.spy(s).was_called_with(5, 6) end,
         "Function was never called with matching arguments.\n"
            .. "Called with %(last call if any%):\n"
            .. "%(values list%) %(%(table: 0x%x+%) {\n"
            .. "  %[foo%] = {\n"
            .. "    %[bar%] = {\n"
            .. "      %[1%] = 'test' } } }%)\n"
            .. "Expected:\n"
            .. "%(values list%) %(%(number%) 5, %(number%) 6%)")
   end)

   it("checks called() and called_with() assertions using refs", function()
      local s = spy.new(function() end)
      local t1:Test = { foo = { bar = { "test" } } }
      local t2:Test = { foo = { bar = { "test" } } }

      s(t1)
      t1.foo.bar = "value"

      assert.spy(s).was_called_with(t2)
      assert.spy(s).was_not_called_with(match.is_ref(t2))
      assert.spy(s).was_called_with(match.is_ref(t1))
   end)

   it("checks called_with(aspy) assertions", function()
      local s = spy.new(function() end)

      s(s)

      assert.spy(s).was_called_with(s)
   end)

   it("checks called_at_least() assertions", function()
      local s = spy.new(function() end)

      s(1, 2, 3)
      s("a", "b", "c")
      assert.spy(s).was_called_at_least(1)
      assert.spy(s).was_called_at_least(2)
      assert.spy(s).was_not_called_at_least(3)
      assert.error_matches(
         function() assert.spy(s).was_called_at_least() end,
         "attempt to compare nil with number")
   end)

   it("checks called_at_most() assertions", function()
      local s = spy.new(function() end)

      s(1, 2, 3)
      s("a", "b", "c")
      assert.spy(s).was_called_at_most(3)
      assert.spy(s).was_called_at_most(2)
      assert.spy(s).was_not_called_at_most(1)
      assert.error_matches(
         function() assert.spy(s).was_called_at_most() end,
         "attempt to compare number with nil")
   end)

   it("checks called_more_than() assertions", function()
      local s = spy.new(function() end)

      s(1, 2, 3)
      s("a", "b", "c")
      assert.spy(s).was_called_more_than(0)
      assert.spy(s).was_called_more_than(1)
      assert.spy(s).was_not_called_more_than(2)
      assert.error_matches(
         function() assert.spy(s).was_called_more_than() end,
         "attempt to compare nil with number")
   end)

   it("checks called_less_than() assertions", function()
      local s = spy.new(function() end)

      s(1, 2, 3)
      s("a", "b", "c")
      assert.spy(s).was_called_less_than(4)
      assert.spy(s).was_called_less_than(3)
      assert.spy(s).was_not_called_less_than(2)
      assert.error_matches(
         function() assert.spy(s).was_called_less_than() end,
         "attempt to compare number with nil")
   end)

   it("checks reverting a spy.on call", function()
      local old = test.key
      local s = spy.on(test, "key")
      test.key()
      test.key("test")
      assert.spy(test.key).was_called(2)
      -- revert and call again
      s:revert()
      assert.are_equal(old, test.key)
      test.key()
      test.key("test")
      assert.spy(s).was_called(2) -- still two, spy was removed
   end)

   it("checks reverting a spy.new call", function()
      local calls = 0
      local old = function() calls = calls + 1 end
      local s = spy.new(old)
      assert.is_table(s)
      s()
      s()
      assert.spy(s).was_called(2)
      assert.are_equal(calls, 2)
      local old_s = s
      s = s:revert()
      assert.are_equal(s, old)
      s()
      assert.spy(old_s).was_called(2)  -- still two, spy was removed
      assert.are_equal(calls, 3)
   end)

   it("checks clearing a spy.on call history", function()
      local s = spy.on(test, "key")
      test.key()
      test.key("test")
      s:clear()
      assert.spy(s).was_called(0)
   end)

   it("checks clearing a spy.new call history", function()
      local s = spy.new(function():string return "foobar" end)
      s()
      s("test")
      s:clear()
      assert.spy(s).was_called(0)
      assert.spy(s).was_not_returned_with("foobar")
   end)

   it("checks spy.new can be constructed without arguments", function()
      local s = spy.new()
      s()
      assert.spy(s).was_called(1)
   end)
end)
