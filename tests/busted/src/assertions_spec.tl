
describe("Test Assertions", function()
  it("Checks level and get_level values", function()
    assert.equal(3, assert:get_level(assert:level(3)))
    assert.is_nil(assert:get_level({}))
    assert.is_nil(assert:get_level("hello world"))
    assert.is_nil(assert:get_level(nil))
  end)

  it("Checks to see if tables 1 and 2 are not the same", function()
    local table1 = { derp = false}
    local table2 = { derp = true}
    assert.is_not_same(table1, table2)
  end)

  it("Checks same() assertion to handle nils properly", function()
    assert.is_error(function() assert.same(nil) end)  -- minimum 2 arguments
    assert.same(nil, nil)
    assert.is_not_same("a string", nil)
    assert.is_not_same(nil, "a string")
  end)

  it("Checks to see if tables 1 and 2 are equal", function()
    local table1 = { derp = false}
    local table2 = table1
    assert.equals(table1, table2)
  end)

  it("Checks equals() assertion to handle nils properly", function()
    assert.is_error(function() assert.equals(nil) end)  -- minimum 2 arguments
    assert.equals(nil, nil)
    assert.is_not_equals("a string", nil)
    assert.is_not_equals(nil, "a string")
  end)

  it("Checks to see if table1 only contains unique elements", function()
    local table2 = { derp = false}
    local table3 = { derp = true }
    local table1 = {table2,table3}
    local tablenotunique = {table2,table2}
    assert.is_unique(table1)
    assert.is_not_unique(tablenotunique)
  end)

  it("Checks near() assertion handles tolerances", function()
    assert.is_near(1.5, 2.0, 0.5)
    assert.is_not_near(1.5, 2.0, 0.499)
  end)

  it("Checks matches() assertion does string matching", function()
    assert.is_error(function() assert.matches('.*') end)  -- minimum 2 arguments
    assert.is_error(function() assert.matches(nil, 's') end)  -- arg1 must be a string
    assert.matches("%w+", "test")
    assert.has_match("%w+", "test")
    assert.has_no_match("%d+", "derp")
    assert.has_match("^test", "123 test", "5")
    assert.has_no_match("%d+", "123 test", "4")
  end)

  it("Ensures the is operator doesn't change the behavior of equals", function()
    assert.is_equals(true, true)
  end)

  it("Ensures the is_not operator does change the behavior of equals", function()
    assert.is_not_equals(true, false)
  end)

  it("Ensures that error only throws an error when the first argument function does not throw an error", function()
    local test_function = function() error("test") end
    assert.has_error(test_function)
    assert.has_error(test_function, "test")
    assert.has_no_errors(test_function, "derp")
  end)

  it("Checks to see if var is truthy", function()
    assert.is_not_truthy(nil)
    assert.is_truthy(true)
    assert.is_truthy({})
    assert.is_truthy(function() end)
    assert.is_truthy("")
    assert.is_not_truthy(false)
    assert.error(function() assert.truthy(false) end)
  end)

  it("Checks to see if var is falsy", function()
    assert.is_falsy(nil)
    assert.is_not_falsy(true)
    assert.is_not_falsy({})
    assert.is_not_falsy(function() end)
    assert.is_not_falsy("")
    assert.is_falsy(false)
  end)

  it("Ensures the Not operator does change the behavior of equals", function()
    assert.is_not_equal(true, false)
  end)

  it("Checks true() assertion", function()
    assert.is_true(true)
    assert.is_not_true(123)
    assert.is_not_true(nil)
    assert.is_not_true("abc")
    assert.is_not_true(false)
    assert.is_not_true(function() end)
  end)

  it("Checks false() assertion", function()
    assert.is_false(false)
    assert.is_not_false(123)
    assert.is_not_false(nil)
    assert.is_not_false("abc")
    assert.is_not_false(true)
    assert.is_not_false(function() end)
  end)

  it("Checks boolean() assertion", function()
    assert.is_boolean(false)
    assert.is_boolean(true)
    assert.is_not_boolean(123)
    assert.is_not_boolean(nil)
    assert.is_not_boolean("abc")
    assert.is_not_boolean(function() end)
  end)

  it("Checks number() assertion", function()
    assert.is_number(123)
    assert.is_number(-0.345)
    assert.is_not_number(nil)
    assert.is_not_number("abc")
    assert.is_not_number(true)
    assert.is_not_number(function() end)
  end)

  it("Checks string() assertion", function()
    assert.is_string("abc")
    assert.is_not_string(123)
    assert.is_not_string(nil)
    assert.is_not_string(true)
    assert.is_not_string(function() end)
  end)

  it("Checks table() assertion", function()
    assert.is_table({})
    assert.is_not_table("abc")
    assert.is_not_table(123)
    assert.is_not_table(nil)
    assert.is_not_table(true)
    assert.is_not_table(function() end)
  end)

  it("Checks nil() assertion", function()
    assert.is_nil(nil)
    assert.is_not_nil(123)
    assert.is_not_nil("abc")
    assert.is_not_nil(true)
    assert.is_not_nil(function() end)
  end)

  it("Checks function() assertion", function()
    assert.is_function(function() end)
    assert.is_not_function(nil)
    assert.is_not_function(123)
    assert.is_not_function("abc")
    assert.is_not_function(true)
  end)

  it("Checks userdata() assertion", function()
    local myfile = io.tmpfile()
    assert.is_userdata(myfile)
    myfile:close()
    assert.is_not_userdata(nil)
    assert.is_not_userdata(123)
    assert.is_not_userdata("abc")
    assert.is_not_userdata(true)
    assert.is_not_userdata(function() end)
  end)

  it("Checks thread() assertion", function()
    local mythread = coroutine.create(function() end)
    assert.is_thread(mythread)
    assert.is_not_thread(nil)
    assert.is_not_thread(123)
    assert.is_not_thread("abc")
    assert.is_not_thread(true)
    assert.is_not_thread(function() end)
  end)

  it("Checks '_' chaining of modifiers and assertions", function()
    assert.is_string("abc")
    assert.is_true(true)
    assert.is_not_string(123)
    assert.is_nil(nil)
    assert.is_not_nil({})
    assert.is_not_true(false)
    assert.is_not_false(true)

    -- verify that failing assertions actually fail
    assert.has_error(function() assert.is_string(1) end)
    assert.has_error(function() assert.is_true(false) end)
    assert.has_error(function() assert.is_not_string('string!') end)
    assert.has_error(function() assert.is_nil({}) end)
    assert.has_error(function() assert.is_not_nil(nil) end)
    assert.has_error(function() assert.is_not_true(true) end)
    assert.has_error(function() assert.is_not_false(false) end)
  end)

  it("Checks '.' chaining of modifiers and assertions", function()
    assert.is_string("abc")
    assert.is_true(true)
    assert.is_not_string(123)
    assert.is_nil(nil)
    assert.is_not_nil({})
    assert.is_not_true(false)
    assert.is_not_false(true)
    assert.not_equals(true, false)

    -- verify that failing assertions actually fail
    assert.has_error(function() assert.is_string(1) end)
    assert.has_error(function() assert.is_true(false) end)
    assert.has_error(function() assert.is_not_string('string!') end)
    assert.has_error(function() assert.is_nil({}) end)
    assert.has_error(function() assert.is_not_nil(nil) end)
    assert.has_error(function() assert.is_not_true(true) end)
    assert.has_error(function() assert.is_not_false(false) end)
    assert.has_error(function() assert.equals_not(true, true) end)
  end)

  it("Checks number of returned arguments", function()
    local fn = function()
    end

    local fn1 = function():string, integer, integer
      return "something",2,3
    end

    local fn2 = function():any
      return nil
    end

    local fn3 = function():any, any
      return nil, nil
    end

    local fn4 = function(): any, number, any
      return nil, 1, nil
    end

    assert.returned_arguments(0, fn())
    assert.not_returned_arguments(2, fn1())
    assert.returned_arguments(3, fn1())

    assert.returned_arguments(1, fn2())
    assert.returned_arguments(2, fn3())
    assert.returned_arguments(3, fn4())
  end)

  it("Checks has_error to accept only callable arguments", function()
    local t_ok = setmetatable( {}, { __call = function() end } )
    local t_nok = setmetatable( {}, { __call = function() error("some error") end } )
    local f_ok = function() end
    local f_nok = function() error("some error") end

    assert.has_error(f_nok)
    assert.has_no_error(f_ok)
    assert.has_error(t_nok)
    assert.has_no_error(t_ok)
  end)

  it("Checks has_error compares error strings", function()
    assert.has_error(function() error() end)
    assert.has_error(function() error("string") end, "string")
  end)

  it("Checks has_error compares error objects", function()
    local func = function() end
    assert.has_error(function() error({ "table" }) end, { "table" })
    assert.has_error(function() error(func) end, func)
    assert.has_error(function() error(false) end, false)
    assert.has_error(function() error(true) end, true)
    assert.has_error(function() error(0) end, 0)
    assert.has_error(function() error(1.5) end, 1.5)
    assert.has_error(function() error(10.0^50) end, 10.0^50)
    assert.has_error(function() error(10.0^-50) end, 10.0^-50)
    assert.has_no_error(function() error(true) end, 0)
    assert.has_no_error(function() error(125) end, 1.5)
  end)

  it("Checks has_error compares error objects with strings", function()
    local mt = { __tostring = function(t:table):any return t[1] end }
    assert.has_error(function() error(setmetatable({ "table" }, mt)) end, "table")
  end)

  it("Checks error_matches to accepts at least 2 arguments", function()
    assert.has_error(function() assert.error_matches(error) end)
    assert.has_no_error(function() assert.error_matches(function() error("foo") end, ".*") end)
  end)

  it("Checks error_matches to accept only callable arguments", function()
    local t_ok = setmetatable( {}, { __call = function() end } )
    local t_nok = setmetatable( {}, { __call = function() error("some error") end } )
    local f_ok = function() end
    local f_nok = function() error("some error") end

    assert.error_matches(f_nok, ".*")
    assert.no_error_matches(f_ok, ".*")
    assert.error_matches(t_nok, ".*")
    assert.no_error_matches(t_ok, ".*")
  end)

  it("Checks error_matches does not compare error objects", function()
    assert.no_error_matches(function() error({ "table" }) end, "table")
  end)

  it("Checks error_matches compares error objects that are convertible to strings", function()
    local mt = { __tostring = function(t:table):any return t[1] end }
    assert.error_matches(function() error(setmetatable({ "table" }, mt)) end, "^table$")
  end)

  it("Checks asserts return all their arguments on success", function()
    assert.is_same({true, "bar"}, {assert.is_true(true, "bar")})
    assert.is_same({false, "foobar"}, {assert.is_false(false, "foobar")})
    assert.is_same({"", "truthy"}, {assert.is_truthy("", "truthy")})
    assert.is_same({nil, "falsy"}, {assert.is_falsy(nil, "falsy")})
    assert.is_same({true, "boolean"}, {assert.is_boolean(true, "boolean")})
    assert.is_same({false, "still boolean"}, {assert.is_boolean(false, "still boolean")})
    assert.is_same({0, "is number"}, {assert.is_number(0, "is number")})
    assert.is_same({"string", "is string"}, {assert.is_string("string", "is string")})
    assert.is_same({{}, "empty table"}, {assert.is_table({}, "empty table")})
    assert.is_same({nil, "string"}, {assert.is_nil(nil, "string")})
    assert.is_same({{1, 2, 3}, "unique message"}, {assert.is_unique({1, 2, 3}, "unique message")})
    assert.is_same({"foo", "foo", "bar"}, {assert.is_equal("foo", "foo", "bar")})
    assert.is_same({"foo", "foo", "string"}, {assert.is_same("foo", "foo", "string")})
    assert.is_same({0, 1, 2, "message"}, {assert.is_near(0, 1, 2, "message")})
  end)

  it("Checks assert.has_match returns captures from match on success", function()
    assert.is_same({"string"}, {assert.has_match("(.*)", "string", "message")})
    assert.is_same({"s", "n"}, {assert.has_match("(s).*(n)", "string", "message")})
    assert.is_same({"tri"}, {assert.has_match("tri", "string", "message")})
    assert.is_same({}, {assert.has_no_match("%d+", "string", "message")})
  end)

  it("Checks assert.has_error returns thrown error on success", function()
    assert.is_same({"err message", "err message"}, {assert.has_error(function() error("err message") end, "err message")})
    assert.is_same({{}, {}}, {assert.has_error(function() error({}) end, {})})
    assert.is_same({nil, nil}, {assert.has_error(function() error(nil) end, nil)})
    assert.is_same({nil, "string"}, {assert.has_no_error(function() end, "string")})
  end)

  it("Checks assert.error_matches returns captures of thrown error on success", function()
    assert.is_same({"err", "message"}, {assert.error_matches(function() error("err message") end, "(err) (%w+)$")})
    assert.is_same({}, {assert.error_matches(function() error(nil) end, nil)})
  end)

  it("Checks assert.no_error_matches returns thrown error on success", function()
    assert.is_same({nil, "string"}, {assert.no_error_matches(function() end, "string")})
    assert.is_same({"error", "string"}, {assert.no_error_matches(function() error("error") end, "string")})
  end)

end)
