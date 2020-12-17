local record pl
    record app
        script_name: function(): string
        require_here: function(string): any
        appfile: function(string): string
        platform: function(): string
        lua: function(): string, string
        parse_args: function({string}, table, table)
    end

    record array2d
        type Array2D = {{any}}

        size: function(Array2D): number, number
        column: function(Array2D, any): {any}
        reduce_rows: function(function(any, any): any, Array2D): {any}
        reduce_cols: function(function(any, any): any, Array2D): {any}
        reduce2: function(function(any, any): any, function(any, any): any, Array2D): any

        map: function(function(any, ...: any): any, Array2D, any...): Array2D
        map2: function(function(any, any, ...:any): any, number, number, table, table, any...): {any}

        product: function(function(any, any): any, {any}, {any}): Array2D
        flatten: function(Array2D): {any}

        reshape: function(Array2D, number, boolean): Array2D

        swap_rows: function(Array2D, number, number)
        swap_cols: function(Array2D, number, number)

        extract_rows: function(Array2D, {number}): Array2D
        extract_cols: function(Array2D, {number}): Array2D

        remove_row: function(Array2D, number)
        remove_col: function(Array2D, number)

        parse_range: function(string): number, number, number, number
        range: function(Array2D, string): {any}
        slice: function(Array2D, number, number, number, number): {any}
        set: function(Array2D, any, number, number, number, number)
        write: function(Array2D, FILE, string, number, number, number, number)

        forall: function(Array2D, function({any}, number), function(number), number, number, number, number)
        move: function(Array2D, number, number, Array2D, number, number, number, number)

        iter: function(Array2D, boolean, number, number, number, number): (function(): any) | {number, number, any}

        columns: function(Array2D): (function(): {any})

        new: function(number, number, any): Array2D
    end

    -- TODO class

    record compat
        lua51: boolean
        jit: boolean
        jit52: boolean | nil
        is_windows: boolean

        dir_separator: string

        execute: function(string): boolean, number

        enum LoadMode
            'b'
            't'
            'bt'
        end
        load: function(any, string, LoadMode, {string: any})

        getfenv: function(function): {string: any}
        setfenv: function(function, {string: any})
    end

    -- TODO comprehension

    record config
        enum ReadOpt
            'smart'
            'variabilize'
            'convert_numbers'
            'trim_space'
            'trim_quotes'
            'list_delim'
            'keysep'
        end

        enum ReadError
            'not a file-like object'
            'file is nil'
        end

        lines: function(FILE | string): function(): string, ReadError
        read: function(FILE | string, {ReadOpt: any}): table, ReadError
    end

    record data
        enum ReadOpt
            'delim'
            'fieldnames'
            'no_convert'
            'convert'
            'numfields'
            'last_field_collect'
            'thousands_dot'
            'csv'
        end

        record Data
            {{any}}

            -- TODO check if this is the right way to declare "methods"
            column_by_name: function(Data, string): {any}

            -- FIXME not entirely sure these two are right...
            -- Incomplete documentation, spaghetti code everywhere, no comments in sight
            select: function(Data, string): function(): any...
            select_row: function(Data, string): function(): {any}

            copy_select: function(Data, string): Data
            column_names: function(Data): {string}

            -- FIXME What is the purpose of this function?
            -- Am I misunderstanding something? Or should this just
            -- not need a Data instance to work?
            write_row: function(Data, FILE, {any})

            write: function(Data, FILE)
            read: function(FILE | string, {ReadOpt: any}): Data, string
        end
        write: function(array2d.Array2D, FILE, {string}, string): boolean, string

        -- TODO documentation specifically mentions this is a {{any}}
        -- Is an Array2D a better or worse description of it? Would it cause any conflicts?
        new: function(array2d.Array2D, {string})

        -- TODO the second parameter could be specified better.
        -- If it is a table, it does have a shallow structure which I haven't
        -- identified properly, but shouldn't be too hard to understand
        query: function(Data, string | table, table, boolean): function(): {any}, string

        filter: function(string, FILE | string, FILE | string, boolean)
    end
end

return pl
