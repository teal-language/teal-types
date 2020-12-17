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
end

return pl
