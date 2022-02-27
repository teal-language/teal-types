local record vector_light

    str: function(x: number, y: number)

	fromPolar: function(angle: number, radius: number): number, number
	toPolar: function(x: number, y: number): number, number
	randomDirection : function(len_min: number, len_max: number): number, number

	-- arithmetic
	mul: function(s: number, x: number, y: number): number, number
	div: function(s: number, x: number, y: number): number, number
	idiv: function(s: number, x: number, y: number): number, number
	add: function(x1: number, y1: number, x2: number, y2: number): number, number
	sub: function(x1: number, y1: number, x2: number, y2: number): number, number
	permul: function(x1: number, y1: number, x2: number, y2: number): number, number
	dot: function(x1: number, y1: number, x2: number, y2: number): number
    cross: function(x1: number, y1: number, x2: number, y2: number): number
	det: function(x1: number, y1: number, x2: number, y2: number): number

	-- relation
	eq: function(x1: number, y1: number, x2: number, y2: number): boolean
    le: function(x1: number, y1: number, x2: number, y2: number): boolean
	lt: function(x1: number, y1: number, x2: number, y2: number): boolean

	-- misc operations
	len: function(x: number, y: number): number
    len2: function(x: number, y: number): number
	dist: function(x1: number, y1: number, x2: number, y2: number): number
    dist2: function(x1: number, y1: number, x2: number, y2: number): number
	normalize: function(x: number, y: number): number
	rotate: function(phi: number, x: number, y: number): number, number
	perpendicular: function(x: number, y: number): number, number
	project: function(x: number, y: number, u: number, v: number): number, number
	mirror: function(x: number, y: number, u: number, v: number): number, number
    angleTo: function(x: number, y: number, u: number, v: number): number
	trim: function(max_length: number, x: number, y: number): number, number
end

return vector_light