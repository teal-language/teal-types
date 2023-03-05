local record json
	type Array = {Value}
	type Object = {string:Value}
	
	-- Workaround for not being able to union Array and Object
	type Mixed = {string|integer:Value}
	
	type Value = number | string | boolean | Mixed
	
	encode: function(value: Value): string
	decode: function(str: string): Value
end

return json