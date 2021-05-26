local record Csv

    -- Usually it's an array of strings, except when, in which case you'll need
    -- to cast the return value appropriately:
    --   * header is true: then the keys will be based on the field names at
    --     the csv header.
    --   * columns is specified: then the keys will be the same keys as the
    --     keys in columns.
    type ResultGenerator = function(): {string}

    record Buffer
        lines: function(Buffer): ResultGenerator
        close: function(Buffer)
        name: function(Buffer): string
    end

    record Parameters
        -- Comma and tab are usually autodetected, otherwise use this field
        separator: string

        -- Set header to true if the file contains a header (first line) and
        -- each set of fields will be keyed by the names in the header rather
        -- than by integer index.
        header: boolean

        -- Provides a mechanism for column remapping, the keys here will be
        -- the resulting keys for the rows returned by the ResultGenerator, and
        -- the values will depend on the type:
        -- * boolean: then that will determine whether values for that column
        --   will be included in the result.
        -- * string: short for specifying a ColumnDefinition with the name.
        columns: {string:boolean|string|ColumnDefinition}
    end

    record ColumnDefinition
        -- Use the value at the column with the given name in the header.
        name: string
        -- A column can have more than one name: {first = { names =
        -- {"word","worm"} }} to help cope with badly specified file formats
        -- and spelling mistakes.
        names: {string}

        -- Mapper that will be applied to the value.
        transform: function(value: string): any
        
        -- Uses this value instead of nil/false returned by the mapper.
        default: any
    end

    open: function(filename: string, parameters: Parameters|nil): Buffer
    openstring: function(content: string, parameters: Parameters|nil): Buffer
end

return Csv
