local record json
	type Array = {Value}
	type Object = {string:Value}
	
	-- Workaround for not being able to union Array and Object
	type Mixed = {string|integer:Value}
	
	type Value = number | string | boolean | Mixed
	
	-- For convenience, encode takes any type and may throw an error at runtime.
	-- You can enforce correctness yourself by specifying types on variables or records.
	--
	-- For example:
	--     local obj: json.Object = {value = 'data'}
	--     local encoded = json.encode(obj)
	
	encode: function(value: any): string
	-- encode: function(value: Value): string
	
	decode: function(str: string): Value
end

return json