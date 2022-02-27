local record vector

    new: function(x: number, y: number): vector
    fromPolar: function(angle: number, radius: number): vector
    randomDirection: function(len_min: number, len_max: number): vector

    isvector: function(self: any): boolean
    clone: function(self: vector): vector
    unpack: function(self: vector): number, number
    permul: function(self: vector, other: vector): vector

    len: function(self: vector): number
    toPolar: function(self: vector): number, number
    len2: function(self: vector): number

    dist: function(self: vector, other: vector): number
    dist2: function(self: vector, other: vector): number

    normalized: function(self: vector): vector
    normalizeInPlace: function(self: vector): vector
    rotated: function(self: vector, angle: number): vector
    rotateInPlace: function(self: vector, angle: number): vector

    perpendicular: function(self: vector): vector
    projectOn: function(self: vector, v: vector): vector
    mirrorOn: function(self: vector, v: vector): vector
    cross: function(self: vector, other: vector): number
    angleTo: function(self: vector, other: vector): number

    trimmed: function(self: vector, max_length: number): vector
    trimInPlace: function(self: vector, max_length: number): vector

    metamethod __call: function(self: vector, x: number, y: number): vector

    metamethod __add: function(self: vector, other: vector): vector
    metamethod __sub: function(self: vector, other: vector): vector

    metamethod __mul: function(self: vector, other: vector): vector
    metamethod __mul: function(self: vector, scalar: number): vector

    metamethod __div: function(self: vector, other: vector): vector
    metamethod __div: function(self: vector, scalar: number): vector
    metamethod __idiv: function(self: vector, scalar: number): vector

    metamethod __eq: function(self: vector, other: vector): boolean
    metamethod __lt: function(self: vector, other: vector): boolean
    metamethod __le: function(self: vector, other: vector): boolean

    x: number
    y: number

end

return vector