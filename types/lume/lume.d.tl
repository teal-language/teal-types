local lume = record
    -- Returns the number x clamped between the numbers min and max.
    clamp: function(x: number, min: number, max: number): number

    -- Rounds x to the nearest integer; rounds away from zero if we're midway between two integers. 
    -- If increment is set then the number is rounded to the nearest increment.
    round: function(x: number, increment: number): number

    -- Returns 1 if x is 0 or above, returns -1 when x is negative.
    sign: function(x: number): number

    -- Returns the linearly interpolated number between a and b, amount should be in the range of 0 - 1; if amount is outside of this range it is clamped.
    lerp: function(a: number, b: number, amount: number): number

    -- Similar to lume.lerp() but uses cubic interpolation instead of linear interpolation.
    smooth: function(a: number, b: number, amount: number): number

    -- Ping-pongs the number x between 0 and 1.
    pingpong: function(x: number): number

    -- Returns the distance between the two points. 
    -- If squared is true then the squared distance is returned -- this is faster to calculate and can still be used when comparing distances.
    distance: function(x1: number, y1: number, x2: number, y2: number, squared: boolean): number

    -- Returns the angle between the two points.
    angle: function(x1: number, y1: number, x2: number, y2: number): number

    -- Given an angle and magnitude, returns a vector.
    vector: function(angle: number, magnitude: number): (number, number)

    -- Returns a random number between a and b. If only a is supplied a number between 0 and a is returned.
    -- If no arguments are supplied a random number between 0 and 1 is returned.
    random: function(a: number, b: number): number

    -- Returns a random value from array t. If the array is empty an error is raised.
    randomchoice: function<N>(t: {N}): N

    -- Takes the argument table t where the keys are the possible choices and the value is the choice's weight.
    -- A weight should be 0 or above, the larger the number the higher the probability of that choice being picked.
    -- If the table is empty, a weight is below zero or all the weights are 0 then an error is raised.
    weightedchoice: function<N>(t: {N:number}): N

    -- Returns true if x is an array -- the value is assumed to be an array if it is a table which contains a value at the index 1.
    -- This function is used internally and can be overridden if you wish to use a different method to detect arrays.
    isarray: function<N>(x: {N}): boolean

    -- Pushes all the given values to the end of the table t and returns the pushed values. Nil values are ignored.
    push: function<N>(t: {N}, ...: N): N...

    -- Removes the first instance of the value x if it exists in the table t. Returns x.
    remove: function<N>(t: {N}, x: N): N

    -- Nils all the values in the table t, this renders the table empty. Returns t.
    clear: function<N>(t: {N}): {N}
    clear: function<K, V>(t: {K:V}): {K:V}

    -- Copies all the fields from the source tables to the table t and returns t. 
    -- If a key exists in multiple tables the right-most table's value is used.
    extend: function<K, V>(t: {K:V}, ...: {K:V}): {K:V}

    -- Returns a shuffled copy of the array t.
    shuffle: function<N>(t: {N}): {N}

    SortFunction = functiontype<V>(a: V, b: V): boolean

    -- Returns a copy of the array t with all its items sorted. 
    -- If comp is a function it will be used to compare the items when sorting.
    -- If comp is a string it will be used as the key to sort the items by.
    sort: function<N>(t: {N}, comp: SortFunction<N>): {N}
    sort: function<N>(t: {N}, comp: string): {N}

    -- Iterates the supplied iterator and returns an array filled with the values.
    array: function<N>(it: function(): N): {N}

    -- Iterates the table t and calls the function fn on each value followed by the supplied additional arguments. 
    -- If fn is a string the method of that name is called for each value. 
    -- The function returns t unmodified.
    each: function<N>(t: {N}, fn: function(...: any), ...: any): {N}
    each: function<K, V>(t: {{K:V}}, fn: string, ...: any): {{K:V}}

    MapFunction = functiontype<V, R>(item: V): R

    -- Applies the function fn to each value in table t and returns a new table with the resulting values.
    map: function<V, R>(t: {V}, fn: MapFunction<V, R>): {R}
    map: function<K, V, R>(t: {K:V}, fn: MapFunction<V, R>): {K:R}
    map: function<K, V>(t: {{K:V}}, key: K): {V}
end

return lume
