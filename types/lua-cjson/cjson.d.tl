local record cjson

    --- Generic
    record Null         -- lightuserdata with null value
        ___null: nil    -- just to make it distincted
    end
    enum NullString "null" end  -- option for encode_invalid_numbers, literal "null"
    type SerializableBasicValue = boolean | number | string | nil | Null
    type Serializable = {number|string: SerializableBasicValue}
    type DeserializeResult = SerializableBasicValue | {string: SerializableBasicValue}  -- number keys will be converted to strings

    --- Variables
    _NAME: string
    _VERSION: string
    null: Null

    --- Functions
    new: function(): cjson
    decode: function(string): DeserializeResult -- will raise error on failure
    decode_invalid_numbers: function(boolean): boolean
    decode_max_depth: function(integer): integer
    encode: function(Serializable): string      -- will raise error on failure
    encode_invalid_numbers: function(boolean | NullString): boolean | NullString
    encode_keep_buffer: function(boolean): boolean
    encode_max_depth: function(integer): integer
    encode_number_precision: function(integer): integer
    encode_sparse_array: function(boolean ,integer, integer): boolean | integer
end

return cjson
