--[[
	NOTE: For simplicity, this def file returns one single record, instead
	of returning a library record that contains a vector record.
	
	This allows to define functions that accept vectors easier, you just
	need to use the name that you store the library in.
	
	For example:
	local Vector = require 'brinevector'
	function doThing(x: Vector) end
	-- Instead of
	function doThing(x: Vector.Vector) end
]]

local record Vector
	-- Static functions
	metamethod __call: function(self: Vector, x: number, y: number): Vector
	isVector: function(value: any): boolean
	
	-- Fields
	x: number
	y: number
	
	-- Metamethods
	metamethod __add: function(left: Vector, right: Vector): Vector
	metamethod __sub: function(left: Vector, right: Vector): Vector
	metamethod __mul: function(left: Vector, right: Vector | number): Vector
	metamethod __mul: function(left: Vector | number, right: Vector): Vector
	metamethod __mod: function(left: Vector, right: Vector | number): Vector
	metamethod __mod: function(left: Vector | number, right: Vector): Vector
	metamethod __div: function(left: Vector, right: Vector | number): Vector
	metamethod __unm: function(self: Vector): Vector
	metamethod __len: function(self: Vector): number
	
	-- __index / __newindex getters / setters
	length: number
	angle: number
	normalized: Vector
	length2: number
	inverse: Vector
	copy: Vector
	floor: Vector
	ceil: Vector
	
	-- Explicit getters
	getLength: function(self: Vector): number
	getAngle: function(self: Vector): number
	getNormalized: function(self: Vector): Vector
	getLengthSquared: function(self: Vector): number
	getInverse: function(self: Vector): Vector
	getCopy: function(self: Vector): Vector
	getFloor: function(self: Vector): Vector
	getCeil: function(self: Vector): Vector
	
	-- Vector ops
	dot: function(self: Vector, other: Vector): number
	angled: function(self: Vector, angle: number): Vector
	rotated: function(self: Vector, deltaAngle: number): Vector
	trim: function(self: Vector, length: number): Vector
	hadamard: function(self: Vector, other: Vector): Vector
	split: function(self: Vector): number, number
	clamp: function(self: Vector, min: number, max: number): Vector
end

return Vector
