
-- These tests were just copied from the busted docs, and converted
-- from lua to teal
-- We include this here just to ensure our busted type hints work

describe("Busted unit testing framework", function()
   describe("should be awesome", function()
      it("should be easy to use", function()
         assert.truthy("Yup.")
      end)

      it("should have lots of features", function()
         -- deep check comparisons!
         assert.are_same({ table = "great"}, { table = "great" })

         -- or check by reference!
         assert.are_not_equal({ table = "great"}, { table = "great"})

         assert.truthy("this is a string") -- truthy: not false or nil

         assert.is_true(1 == 1)

         assert.falsy(nil)
         assert.has_error(function() error("Wat") end, "Wat")
      end)

      it("should provide some shortcuts to common functions", function()
         assert.are_unique({{ thing = 1 }, { thing = 2 }, { thing = 3 }})
      end)

      it("should have mocks and spies for functional tests", function()
         local thing = require("old_test_module")
         spy.on(thing, "greet")

         assert.spy(thing.greet).was_not_called()

         thing.greet("Hi!")

         assert.spy(thing.greet).was_called()
         assert.spy(thing.greet).was_called_with("Hi!")
      end)
   end)

   describe("test methods", function()
      local obj1:any
      local obj2:any
      local test_module:any

      setup(function()
         test_module = require("old_test_module")
      end)

      teardown(function()
         test_module = nil
      end)

      before_each(function()
         obj1 = { test = "yes" }
         obj2 = { test = "yes" }
      end)

      it("sets up vars with the before_each", function()
         obj2 = { test = "no" }
         assert.are_not_same(obj1, obj2)
      end)

      it("sets up vars with the before_each", function()
         -- obj2 is reset thanks to the before_each
         assert.same(obj1, obj2)
      end)

      describe("nested", function()
         it("also runs the before_each here", function()
            -- if this describe also had a before_each, it would run
            -- both, starting with the parents'. You can go n-deep.
         end)
      end)
   end)

   describe("finally test", function()
      it('checks file contents',function()
         local f = io.popen('echo 5')

         -- ensure that once test has finished f:close() is called
         -- independent of test outcome
         finally(function() f:close() end)

         -- do things with f
      end)
   end)

   describe("busted pending tests", function()
      it("example", function()
         pending("I should finish this test later")
      end)
   end)

   describe("some assertions", function()
      it("tests positive assertions", function()
         assert.is_true(true)  -- Lua keyword chained with _
         assert.are_equal(1, 1)
         assert.has_errors(function() error("this should fail") end)
      end)

      it("tests negative assertions", function()
         assert.is_not_true(false)
         assert.are_not_equals(1, "1")
         assert.has_no_errors(function() end)
      end)

      it("checks if they're equals", function()
         local expected = 1
         local obj = expected

         assert.are_equals(expected, obj)
      end)

      it("checks if they're the same", function()
         local expected = { name = "Jack" }
         local obj = { name = "Jack" }

         assert.are_same(expected, obj)
      end)

      it("checks true", function()
         assert.is_true(true)
         assert.is_not_true("Yes")
         assert.is_truthy("Yes")
      end)

      it("checks false", function()
         assert.is_false(false)
         assert.is_not_false(nil)
         assert.is_falsy(nil)
      end)

      it("should throw an error", function()
         assert.has_error(function() error("Yup,  it errored") end)
         assert.has_no_errors(function() end)
      end)

      it("should throw the error we expect", function()
         local errfn = function()
            error("DB CONN ERROR")
         end

         assert.has_error(errfn, "DB CONN ERROR")
      end)
   end)

   describe("spies", function()
      it("registers a new spy as a callback", function()
         local s = spy.new(function(_:integer) end)

         s(1)
         s(4)

         assert.spy(s).was_called()
         assert.spy(s).was_called(2) -- twice!
         assert.spy(s).was_called_with(4) -- checks the history
      end)

      it("replaces an original function", function()
         local t = {
            greet = function(msg:string) print(msg) end
         }

         local s = spy.on(t, "greet")

         t.greet("Hey!") -- prints 'Hey!'
         assert.spy(t.greet).was_called_with("Hey!")

         s:clear()   -- clears the call history
         assert.spy(s).was_not_called_with("Hey!")

         s:revert()  -- reverts the stub
         t.greet("Hello!") -- prints 'Hello!', will not pass through the spy
         assert.spy(s).was_not_called_with("Hello!")
      end)
   end)

   describe("stubs", function()
      it("replaces an original function", function()
         local t = {
            greet = function(msg:string) print(msg) end
         }

         local greet_stub = stub.new(t, "greet")

         t.greet("Hey!") -- DOES NOT print 'Hey!'
         assert.stub(t.greet).was_called_with("Hey!")

         greet_stub:revert()  -- reverts the stub
         t.greet("Hey!") -- DOES print 'Hey!'
      end)
   end)

   describe("mocks", function()
      it("replaces a table with spies", function()
         local t = {
            thing = function(msg:string) print(msg) end
         }

         local m = mock.new(t) -- mocks the table with spies, so it will print

         m.thing("Coffee")
         assert.spy(m.thing).was_called_with("Coffee")
      end)

      it("replaces a table with stubs", function()
         local t = {
            thing = function(msg:string) print(msg) end
         }

         local m = mock.new(t, true) -- mocks the table with stubs, so it will not print

         m.thing("Coffee")
         assert.stub(m.thing).was_called_with("Coffee")

         mock.revert(m) -- reverts all stubs/spies in m
         m.thing("Tea") -- DOES print 'Tea'
      end)
   end)

   describe("match arguments", function()
      local match = require("luassert.match")

      it("tests wildcard matcher", function()
         local s = spy.new(function(_:string) end)
         local _ = match._

         s("foo")

         assert.spy(s).was_called_with(_)        -- matches any argument
         assert.spy(s).was_not_called_with(_, _) -- does not match two arguments
      end)

      it("tests type matchers", function()
         local s = spy.new(function(_:string) end)

         s("foo")

         assert.spy(s).was_called_with(match.is_string())
         assert.spy(s).was_called_with(match.is_truthy())
         assert.spy(s).was_called_with(match.is_not_nil())
         assert.spy(s).was_called_with(match.is_not_false())
         assert.spy(s).was_called_with(match.is_not_number())
         assert.spy(s).was_called_with(match.is_not_table())
      end)

      it("tests more matchers", function()
         local s = spy.new(function(_:integer) end)

         s(1)

         assert.spy(s).was_called_with(match.is_equal(1))
         assert.spy(s).was_called_with(match.is_same(1))
      end)
   end)

   describe("combine matchers", function()
      local match = require("luassert.match")

      it("tests ref matchers for passed in table", function()
         local record Foo
            cnt:integer
            incrby:function(t:Foo, i:integer)
         end

         local t:Foo = {
            cnt = 0,
            incrby = function(t:Foo, i:integer) t.cnt = t.cnt + i end
         }

         local s = spy.on(t, "incrby")

         s(t, 2)

         assert.spy(s).was_called_with(match.is_ref(t), 2)
      end)

      it("tests ref matchers for self", function()
         local record Foo
            cnt:integer
            incrby:function(t:Foo, i:integer)
         end

         local t:Foo = {
            cnt = 0,
            incrby = function(t:Foo, i:integer) t.cnt = t.cnt + i end
         }

         local s = spy.on(t, "incrby")

         t:incrby(2)

         assert.spy(s).was_called_with(match.is_ref(t), 2)
      end)
   end)

   describe("combine matchers", function()
     local match = require("luassert.match")

     it("tests composite matchers", function()
       local s = spy.new(function(_:string) end)

       s("foo")

       assert.spy(s).was_called_with(match.is_all_of(match.is_not_nil(), match.is_not_number()))
       assert.spy(s).was_called_with(match.is_any_of(match.is_number(), match.is_string(), match.is_boolean()))
       assert.spy(s).was_called_with(match.is_none_of(match.is_number(), match.is_table(), match.is_boolean()))
     end)
   end)
end)
