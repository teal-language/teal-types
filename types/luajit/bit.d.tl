--- See https://bitop.luajit.org
local record bit
    --- Normalizes a number to the numeric range for bit operations and returns it.
    --- This function is usually not needed since all bit operations already
    --- normalize all of their input arguments.
    --- @param x: number to normalize
    --- @return integer in the signed 32-bit range
    tobit: function(x: number): integer

    --- Converts its first argument to a hex string. The number of hex digits is
    --- given by the absolute value of the optional second argument. Positive
    --- numbers between 1 and 8 generate lowercase hex digits. Negative numbers
    --- generate uppercase hex digits. Only the least-significant 4*|n| bits are
    --- used. The default is to generate 8 lowercase hex digits.
    --- @param x: `number` to format
    --- @param n: `number` or `nil` (default: `8`)
    --- @return string containing the hex representation
    tohex: function(x: number, n?: number): string

    --- Returns the bitwise not of its argument.
    --- @param x: `number`
    --- @return integer
    bnot: function(x: number): integer

    --- Returns the bitwise or of all of its arguments.
    --- @param x1: `number`
    --- @param ...: additional `number` operands
    --- @return integer
    bor:  function(x1: number, ...: number): integer

    --- Returns the bitwise and of all of its arguments.
    --- @param x1: `number`
    --- @param ...: additional `number` operands
    --- @return integer
    band: function(x1: number, ...: number): integer

    --- Returns the bitwise xor of all of its arguments.
    --- @param x1: `number`
    --- @param ...: additional `number` operands
    --- @return integer
    bxor: function(x1: number, ...: number): integer

    --- Returns the bitwise logical left-shift of its first argument by the
    --- number of bits given by the second argument. Logical shifts treat the
    --- first argument as an unsigned number and shift in 0-bits. Only the
    --- lower 5 bits of the shift count are used (reduces to the range [0..31]).
    --- @param x: `number` to shift
    --- @param n: `number` of bits to shift by
    --- @return integer
    lshift: function(x: number, n: number): integer

    --- Returns the bitwise logical right-shift of its first argument by the
    --- number of bits given by the second argument. Logical shifts treat the
    --- first argument as an unsigned number and shift in 0-bits. Only the
    --- lower 5 bits of the shift count are used (reduces to the range [0..31]).
    --- @param x: `number` to shift
    --- @param n: `number` of bits to shift by
    --- @return integer
    rshift: function(x: number, n: number): integer

    --- Returns the bitwise arithmetic right-shift of its first argument by the
    --- number of bits given by the second argument. Arithmetic right-shift
    --- treats the most-significant bit as a sign bit and replicates it. Only
    --- the lower 5 bits of the shift count are used (reduces to the range
    --- [0..31]).
    --- @param x: `number` to shift
    --- @param n: `number` of bits to shift by
    --- @return integer
    arshift: function(x: number, n: number): integer

    --- Returns the bitwise left rotation of its first argument by the number
    --- of bits given by the second argument. Bits shifted out on one side are
    --- shifted back in on the other side. Only the lower 5 bits of the rotate
    --- count are used (reduces to the range [0..31]).
    --- @param x: `number` to rotate
    --- @param n: `number` of bits to rotate by
    --- @return integer
    rol: function(x: number, n: number): integer

    --- Returns the bitwise right rotation of its first argument by the number
    --- of bits given by the second argument. Bits shifted out on one side are
    --- shifted back in on the other side. Only the lower 5 bits of the rotate
    --- count are used (reduces to the range [0..31]).
    --- @param x: `number` to rotate
    --- @param n: `number` of bits to rotate by
    --- @return integer
    ror: function(x: number, n: number): integer

    --- Swaps the bytes of its argument and returns it. This can be used to
    --- convert little-endian 32 bit numbers to big-endian 32 bit numbers or
    --- vice versa.
    --- @param x: `number` whose bytes to swap
    --- @return integer with bytes swapped
    bswap: function(x: number): integer
end

return bit
