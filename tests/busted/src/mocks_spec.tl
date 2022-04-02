describe("Tests dealing with mocks", function()
  local test = {}

  before_each(function()
    test = {
      key = function(_:any):string
        return "derp"
      end,
      foo = { bar = function(_:any):string return "foobar" end }
    }
  end)

  it("makes sure we're returning the same table", function()
    local val = tostring(test)
    assert.is_true(type(mock.new(test)) == "table")
    assert.is_true(tostring(mock.new(test)) == val)
  end)

  it("makes sure function calls are spies", function()
    assert.is_true(type(test.key) == "function")
    mock.new(test)
    assert.is_true(type(test.key) == "table")
    assert.is_true(test.key() == "derp")
  end)

  it("makes sure function calls are stubs when specified", function()
    assert.is_true(type(test.key) == "function")
    mock.new(test, true)
    assert.is_true(type(test.key) == "table")
    assert.is_true(test.key() == nil)
  end)

  it("makes sure call history can be cleared", function()
    mock.new(test)
    test.key()
    test.key("test")
    test.foo.bar()
    test.foo.bar("hello world")
    assert.spy(test.key).was_called()
    assert.spy(test.foo.bar).was_called()
    mock.clear(test)
    assert.spy(test.key).was_not_called()
    assert.spy(test.foo.bar).was_not_called()
  end)

  it("makes sure table can be reverted to pre-mock state", function()
    local val = tostring(test)
    mock.new(test)
    mock.revert(test)
    assert.is_true(type(test.key) == "function")
    assert.is_true(test.key() == "derp")
    assert.is_true(tostring(test) == val)
  end)
end)
