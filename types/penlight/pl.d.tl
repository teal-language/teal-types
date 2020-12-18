local record pl
    -- TODO any function that accepts a function as argument (afaict)
    -- also accepts a few key strings (such as '+') which are internally
    -- converted into the respective function
    -- These special strings are probably all defined in pl.operator,
    -- so you need to retcon the existing functions with it, probably
    -- by creating a FunctionArg type, which is the union a function and
    -- the special strings enum
    record List<T>
        {T}

        new: function({T}): List<T>
        range: function(number, number, number): List<number>
        split: function(string, string): List<string>

        len: function(List<T>): number

        -- TODO check if this is how you declare methods
        append: function(List<T>, T): List<T>
        clone: function(List<T>): List<T>
        extend: function(List<T>, List<T>): List<T>
        insert: function(List<T>, number, T): List<T>
        pop: function(List<T>, number): T
        put: function(List<T>, T): List<T>
        remove: function(List<T>, number): List<T>
        remove_value: function(List<T>, T): List<T>

        chop: function(List<T>, number, number): List<T>
        slice_assign: function(List<T>, number, number, List<T>): List<T>
        splice: function(List<T>, number, List<T>): List<T>

        reverse: function(List<T>): List<T>
        sorted: function(List<T>, function(T, T): boolean): List<T>
        sort: function(List<T>, function(T, T): boolean): List<T>

        clear: function(List<T>): List<T>
        contains: function(List<T>, T): boolean
        count: function(List<T>, T): number
        index: function(List<T>, T, number): number
        minmax: function(List<T>): number, number
        slice: function(List<T>, number, number): List<T>

        concat: function(List<T>, string): string
        join: function(List<T>, string): string

        foreach: function(List<T>, function(T, ...: any), ...: any)
        foreachm: function(List<table>, string, ...: any)
        filter: function(List<T>, function(T, any): boolean, any): List<T>
        transform: function(List<T>, (function(T, ...: any): T), ...: any): List<T>
        map: function<U>(List<T>, (function(T, ...: any): U), ...: any): List<U>
        map2: function<U, V>(List<T>, (function(T, U, ...: any): V), List<U>, ...: any): List<V> -- this is ridiculous

        -- TODO check if there isnt a way to infer type here
        -- I expect there isnt a way, but just to make sure
        mapm: function(List<T>, string, ...: any): List<any>

        reduce: function(List<T>, (function(T, T): T)): T

        -- TODO uncomment this after declaring MultiMap
        -- The first type parameter is the key type, the second one is the value type
        -- partition: function<K>(List<T>, (function(T, ...: any): K), ...: any): MultiMap<K, T>

        iter: function(List<T>): (function(): T)
        iterate: function(string | table | function) -- FILE is also considered a table

        -- TODO metamethods when they get supported in Teal
    end

    record Map<K, V>
        -- TODO so uh, we have a problem
        -- Map has no constructor, it can only be created by
        -- manually setting the metatable of a regular {K: V},
        -- of by calling the record which... is not supported yet
        -- in Teal
        -- {K: V} -- TODO check if this is really not allowed
        keys: List<K>
        values: List<V>

        iter: function(Map<K, V>): (function(): {K, V})
        items: function(Map<K, V>): (function(): {K, V})

        get: function(Map<K, V>, K): V
        set: function(Map<K, V>, K, V)
        setdefault: function(Map<K, V>, K, V): V

        getvalues: function(Map<K, V>, {K}): List<V>
        update: function(Map<K, V>, {K: V})

        len: function(Map<K, V>): number
    end

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

        map: function((function(any, ...: any): any), Array2D, ...: any): Array2D
        map2: function((function(any, any, ...:any): any), number, number, table, table, ...: any): {any}

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
            -- TODO check if these methods return arrays and not lists
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
        query: function(Data, string | table, {table}, boolean): function(): {any}, string

        filter: function(string, FILE | string, FILE | string, boolean)
    end

    record dir
        fnmatch: function(string, string): boolean
        filter: function({string}, string): List<string>

        copyfile: function(string, string, boolean): boolean
        movefile: function(string, string): boolean
        makepath: function(string): boolean, string
        rmtree: function(string): boolean, string
        clonetree: function(string, string, (function(string, string): any))

        getfiles: function(string, string): List<string>
        getdirectories: function(string): List<string>
        walk: function(string, boolean, boolean): (function(): string, List<string>, List<string>)

        dirtree: function(string): (function(): string, boolean)
        getallfiles: function(string, string): List<string>
    end
end

return pl
