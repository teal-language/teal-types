local match = require 'luassert.match'

describe("Tests dealing with stubs", function()
   local record Test
      record Foo
         bar:{string}|string
      end
      key:function(any):any
      foo:Foo
   end
  local test:Test = {}

  before_each(function()
     test = {
        key = function(_:any):string
           return "derp"
        end
     }
  end)

  it("checks to see if stub keeps track of arguments", function()
    stub(test, "key")
    test.key("derp")
    assert.stub(test.key).was_called_with("derp")
  end)

  it("checks to see if stub keeps track of number of calls", function()
     stub(test, "key")
     test.key()
     test.key("test")
     assert.stub(test.key).was_called(2)
  end)

  it("checks called() and called_with() assertions", function()
    local s = stub.new(test, "key")

    s(1, 2, 3)
    s("a", "b", "c")
    assert.stub(s).was_called()
    assert.stub(s).was_called(2) -- twice!
    assert.stub(s).was_not_called(3)
    assert.stub(s).was_not_called_with({1, 2, 3}) -- mind the accolades
    assert.stub(s).was_called_with(1, 2, 3)
  end)

  it("checks reverting a stub call", function()
     local calls = 0
     local old = function(_:any):string calls = calls + 1 end
     test.key = old
     local s = stub.new(test, "key")
     assert.is_table(s)
     s()
     s()
     assert.stub(s).was_called(2)
     assert.are_equal(calls, 0)   -- its a stub, so no calls
     local old_s = s
     s = s:revert()
     s()
     assert.stub(old_s).was_called(2)  -- still two, stub was removed
     assert.are_equal(s, old)
     assert.are_equal(calls, 1)     -- restored, so now 1 call
  end)

  it("checks reverting a stub call on a nil value", function()
     test = {}
     local s = stub.new(test, "key")
     assert.is_table(s)
     s()
     s()
     assert.stub(s).was_called(2)
     s = s:revert()
     assert.is_nil(s)
  end)

  it("checks creating and reverting a 'blank' stub", function()
     local s = stub.new()   -- use no parameters to create a blank
     assert.is_table(s)
     s()
     s()
     assert.stub(s).was_called(2)
     s = s:revert()
     assert.is_nil(s)
  end)

  it("checks clearing a stub only clears call history", function()
     local s = stub.new(test, "key")
     s.returns("value")
     s.on_call_with("foo").returns("bar")
     s()
     s("foo")
     s:clear()
     assert.stub(s).was_not_called()
     assert.stub(s).was_not_returned_with("value")
     assert.stub(s).was_not_returned_with("bar")
     s("foo")
     assert.stub(s).was_returned_with("bar")
  end)

  it("returns nil by default", function()
    stub(test, "key")

    assert.is_nil(test.key())
  end)

  it("returns a given return value", function()
    stub(test, "key", "foo")

    assert.is_equal("foo", test.key())
  end)

  it("returns default stub arguments", function()
    stub.new(test, "key").returns("foo")

    local arg1 = test.key("bar")

    assert.is_equal("foo", arg1)
  end)

  it("invokes default stub function", function()
    stub.new(test, "key").invokes(function(a:string):string
      return a .. "_x"
    end)

    local arg1 = test.key("bar")

    assert.is_equal("bar_x", arg1)
  end)

  it("returns stub arguments by default", function()
    stub.new(test, "key").by_default.returns("foo")

    local arg1 = test.key()

    assert.is_equal("foo", arg1)
  end)

  it("invokes stub function by default", function()
    stub.new(test, "key").by_default.invokes(function(a:string):string
      return a .. "_x"
    end)

    local arg1 = test.key("bar")

    assert.is_equal("bar_x", arg1)
  end)

  it("on_call_with invokes stub function", function()
    local s = stub.new(test, "key").returns("foo foo")

    s.on_call_with("foo").invokes(function(_:string):string
      return "bar"
    end)

    local arg1 = test.key("foo")
    local foo = test.key()

    assert.is_equal("bar", arg1)
    assert.is_equal("foo foo", foo)
  end)

  it("on_call_with matches arguments for returns", function()
    local t:Test = { foo = { bar = { "test" } } }
    local s = stub.new(test, "key").returns("foo foo")
    s.on_call_with(t).returns("bar")
    t.foo.bar = "value"

    local bar = test.key({ foo = { bar = { "test" } } })
    local foofoo = test.key(t)

    assert.is_equal("bar", bar)
    assert.is_equal("foo foo", foofoo)
  end)

  it("on_call_with matches arguments for invokes", function()
    local t:Test = { foo = { bar = { "test" } } }
    local s = stub.new(test, "key").returns("foo foo")
    s.on_call_with(t).invokes(function():string return "bar bar" end)
    t.foo.bar = "value"

    local bar = test.key({ foo = { bar = { "test" } } })
    local foofoo = test.key(t)

    assert.is_equal("bar bar", bar)
    assert.is_equal("foo foo", foofoo)
  end)

  it("on_call_with matches arguments using refs", function()
    local t1:Test = { foo = { bar = { "test" } } }
    local t2:Test = { foo = { bar = { "test" } } }
    local s = stub.new(test, "key").returns("foo foo")

    s.on_call_with(match.is_ref(t1)).returns("bar")

    t1.foo.bar = "value"
    t2.foo.bar = "value"

    local bar = test.key(t1)
    local foo = test.key(t2)
    local foofoo = test.key({ foo = { bar = { "test" } } })

    assert.is_equal("bar", bar)
    assert.is_equal("foo foo", foo)
    assert.is_equal("foo foo", foofoo)
  end)

end)
