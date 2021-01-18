local record pl
    -- This is not divided into multiple files due to circular
    -- dependency issues. For now, everything is declared here
    -- and just reexported in the right file

    record List<T>
        {T}

        new: function({T}): pl.List<T>
        metamethod __call: function<T>(pl.List, {T}): pl.List<T>
        metamethod __concat: function(pl.List<T>, pl.List<T>): pl.List<T>

        range: function(number, number, number): pl.List<number>
        split: function(string, string): pl.List<string>

        len: function(pl.List<T>): number

        append: function(pl.List<T>, T): pl.List<T>
        clone: function(pl.List<T>): pl.List<T>
        extend: function(pl.List<T>, pl.List<T>): pl.List<T>
        insert: function(pl.List<T>, number, T): pl.List<T>
        pop: function(pl.List<T>, number): T
        put: function(pl.List<T>, T): pl.List<T>
        remove: function(pl.List<T>, number): pl.List<T>
        remove_value: function(pl.List<T>, T): pl.List<T>

        chop: function(pl.List<T>, number, number): pl.List<T>
        slice_assign: function(pl.List<T>, number, number, pl.List<T>): pl.List<T>
        splice: function(pl.List<T>, number, pl.List<T>): pl.List<T>

        reverse: function(pl.List<T>): pl.List<T>
        sorted: function(pl.List<T>, string | function(T, T): boolean): pl.List<T>
        sort: function(pl.List<T>, string | function(T, T): boolean): pl.List<T>

        clear: function(pl.List<T>): pl.List<T>
        contains: function(pl.List<T>, T): boolean
        count: function(pl.List<T>, T): number
        index: function(pl.List<T>, T, number): number
        minmax: function(pl.List<T>): number, number
        slice: function(pl.List<T>, number, number): pl.List<T>

        concat: function(pl.List<T>, string): string
        join: function(pl.List<T>, string): string

        foreach: function(pl.List<T>, string | function(T, ...: any), ...: any)
        foreachm: function(pl.List<table>, string, ...: any)
        filter: function<U>(pl.List<T>, (string | function(T, U): boolean), U): pl.List<T>

        transform: function(pl.List<T>, (string | function(T, ...: any): T), ...: any): pl.List<T>

        map: function<U>(pl.List<T>, (string | function(T, ...: any): U), ...: any): pl.List<U>
        map2: function<U, V>(pl.List<T>, (string | function(T, U, ...: any): V), pl.List<U>, ...: any): pl.List<V>
        mapm: function<U>(pl.List<T>, string, ...: any): pl.List<U>
        reduce: function(pl.List<T>, (string | function(T, T): T)): T

        partition: function<K>(List<T>, (function(T, ...: any): K), ...: any): pl.Map<K, List<T> >

        iter: function(pl.List<T>): (function(): T)
        iterate: function(string | table | function) -- FILE is also considered a table
    end

    record Map<K, V>
        metamethod __call: function<K, V>(any, {K: V}): Map<K, V>

        -- These two are substitutes for maprecords ({K: V})
        metamethod __index: function(pl.Map<K, V>, K): V
        metamethod __newindex: function(pl.Map<K, V>, K, V)

        keys: pl.List<K>
        values: pl.List<V>

        iter: function(pl.Map<K, V>): (function(): {K, V})
        items: function(pl.Map<K, V>): (function(): {K, V})

        get: function(pl.Map<K, V>, K): V
        set: function(pl.Map<K, V>, K, V)
        setdefault: function(pl.Map<K, V>, K, V): V

        getvalues: function(pl.Map<K, V>, {K}): pl.List<V>
        update: function(pl.Map<K, V>, {K: V})

        len: function(pl.Map<K, V>): number
    end

    record Date
        metamethod __call: function(pl.Date, number, boolean): pl.Date
        metamethod __call: function(pl.Date, {pl.Date.datefield: number}, boolean): pl.Date
        metamethod __call: function(pl.Date, number, number, number, number, number, number)

        metamethod __lt: function(pl.Date, pl.Date): boolean
        metamethod __add: function(pl.Date, pl.Date): pl.Date
        metamethod __add: function(pl.Date, {pl.Date.datefield: number}): pl.Date
        metamethod __sub: function(pl.Date, pl.Date): pl.Date

        enum datefield
            'year'
            'month'
            'day'
            'hour'
            'min'
            'sec'
        end

        set: function(pl.Date, number)
        tzone: function(pl.Date, number): number
        toUTC: function(pl.Date): pl.Date
        toLocal: function(pl.Date): pl.Date

        year: function(pl.Date): number
        month: function(pl.Date): number
        day: function(pl.Date): number
        hour: function(pl.Date): number
        min: function(pl.Date): number
        sec: function(pl.Date): number
        yday: function(pl.Date): number

        year: function(pl.Date, number)
        month: function(pl.Date, number)
        day: function(pl.Date, number)
        hour: function(pl.Date, number)
        min: function(pl.Date, number)
        sec: function(pl.Date, number)
        yday: function(pl.Date, number)

        is_weekend: function(pl.Date): boolean
        weekday_name: function(pl.Date, boolean): string
        month_name: function(pl.Date, boolean): string

        add: function(pl.Date, {pl.Date.datefield: number})
        diff: function(pl.Date, pl.Date): pl.Date

        last_day: function(pl.Date): number

        Interval: function(number): pl.Date

        record Format
            metamethod __call: function(string): pl.Date.Format
            parse: function(string): pl.Date
            tostring: function(pl.Date): string
            US_order: function(boolean)
        end
    end

    -- MultiMap inherits from Map, so this is just a weird case that can't
    -- really be easily described in teal for now. Same for OrderedMap and Set.

    -- TODO MultiMap
    -- TODO OrderedMap
    -- TODO Set

    record app
        script_name: function(): string
        require_here: function(string): any
        appfile: function(string): string
        platform: function(): string
        lua: function(): string, string
        parse_args: function({string}, table, table)
    end

    record array2d
        record Array2D<T> -- record just for generics
            {{T}}
        end

        new: function<T>(number, number, T): Array2D<T>

        size: function<T>(pl.array2d.Array2D<T>): number, number
        column: function<T>(pl.array2d.Array2D<T>, number): List<T>
        flatten: function<T>(pl.array2d.Array2D<T>): List<T>
        reshape: function<T>(pl.array2d.Array2D<T>, number, boolean): pl.array2d.Array2D<T>

        swap_rows: function<T>(pl.array2d.Array2D<T>, number, number)
        swap_cols: function<T>(pl.array2d.Array2D<T>, number, number)

        reduce_rows: function<T>(function(T, T): T, pl.array2d.Array2D<T>): pl.List<T>
        reduce_cols: function<T>(function(T, T): T, pl.array2d.Array2D<T>): pl.List<T>
        reduce2: function<T>(function(T, T): T, function(T, T): T, pl.array2d.Array2D<T>): T

        map: function<T, R, A>(
            (string | function<U>(T, ...: A): R),
            pl.array2d.Array2D<T>, ...: A
        ): pl.array2d.Array2D<R>

        map2: function<T1, T2, R, A>(
            (string | function({T1}, {T2}, ...: A): {R}),
            number, number,
            pl.array2d.Array2D<T1>, pl.array2d.Array2D<T2>,
            ...: A
        ): pl.array2d.Array2D<R>
        map2: function<T1, T2, R, A>(
            (string | function({T1}, {T2}, ...: A): R),
            number, number,
            pl.array2d.Array2D<T1>, {T2},
            ...: A
        ): Array2D<R>
        map2: function<T1, T2, R, A>(
            (string | function({T1}, {T2}, ...: A): R),
            number, number,
            {T1}, pl.array2d.Array2D<T2>,
            ...: A
        ): pl.array2d.Array2D<R>
        map2: function<T1, T2, R, A>(
            (string | function({T1}, {T2}, ...: A): R),
            number, number,
            {T1}, {T2},
            ...: A
        ): {R}

        product: function<T, U, R>(
            (string | function(T, U): R),
            {T}, {U}
        ): pl.array2d.Array2D<R>

        extract_rows: function<T>(pl.array2d.Array2D<T>, {number}): pl.array2d.Array2D<T>
        extract_cols: function<T>(pl.array2d.Array2D<T>, {number}): pl.array2d.Array2D<T>

        remove_row: function<T>(pl.array2d.Array2D<T>, number)
        remove_col: function<T>(pl.array2d.Array2D<T>, number)

        parse_range: function(string): number, number, number, number
        range: function<T>(pl.array2d.Array2D<T>, string): {T}
        slice: function<T>(pl.array2d.Array2D<T>, number, number, number, number): {T}
        set: function<T>(pl.array2d.Array2D<T>, T, number, number, number, number)
        write: function<T>(pl.array2d.Array2D<T>, FILE, string, number, number, number, number)

        forall: function<T>(
            pl.array2d.Array2D<T>,
            (function({T}, number): any...),
            (function(number): any...),
            number, number, number, number
        )
        move: function<T>(
            pl.array2d.Array2D<T>,
            number, number,
            pl.array2d.Array2D<T>,
            number, number, number, number
        )

        iter: function<T>(
            pl.array2d.Array2D<T>, boolean,
            number, number, number, number
        ): (function(): (T | {number, number, T}))

        columns: function<T>(pl.array2d.Array2D<T>): (function(): List<T>)
    end

    record class
        metamethod __index: function(any, string): Class
        metamethod __call: function(any, Class): Class

        record Class
            class_of: function(Class, Instance): boolean
            cast: function(Class, Instance)
        end

        record Instance
            -- FIXME this is not ideal, but I can't think of a better solution...
            metamethod __index: function(Instance, any): any

            is_a: function(Instance, Class): boolean
        end
    end

    record compat
        lua51: boolean
        jit: boolean
        jit52: boolean
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

    record comprehension
        type generator = (function(): {any})
        type parser = (function(string): generator)
        new: function(): parser
    end

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

        lines: function(FILE | string): function(): string, pl.config.ReadError
        read: function(FILE | string, {pl.config.ReadOpt: any}): table, pl.config.ReadError
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

        type rowiterator = function(): any...

        record Data
            {{any}}

            fieldnames: pl.List<string>
            original_fieldnames: {string}

            column_by_name: function(pl.data.Data, string): pl.List<any>

            select: function(pl.data.Data, string): pl.data.rowiterator
            select_row: function(pl.data.Data, string): function(): {any}

            copy_select: function(pl.data.Data, string): Data
            column_names: function(pl.data.Data): {string}

            write_row: function(pl.data.Data, FILE, {any})

            write: function(pl.data.Data, FILE)
            read: function(FILE | string, {pl.data.ReadOpt: any}): pl.data.Data, string
        end
        write: function(array2d.Array2D, FILE, {string}, string): boolean, string

        new: function({{any}}, {string})

        query: function(pl.data.Data, (string | table), {table}, boolean): pl.data.rowiterator, string
        filter: function(string, FILE | string, FILE | string, boolean)
    end

    record dir
        fnmatch: function(string, string): boolean
        filter: function({string}, string): pl.List<string>

        copyfile: function(string, string, boolean): boolean
        movefile: function(string, string): boolean
        makepath: function(string): boolean, string
        rmtree: function(string): boolean, string
        clonetree: function(string, string, (function(string, string): any))

        getfiles: function(string, string): pl.List<string>
        getdirectories: function(string): pl.List<string>
        walk: function(string, boolean, boolean): (function(): string, pl.List<string>, pl.List<string>)

        dirtree: function(string): (function(): string, boolean)
        getallfiles: function(string, string): pl.List<string>
    end

    record file
        -- TODO copy declarations from other functions
        -- this whole module is just renaming of other functions
    end

    record func
        record PHExp end

        _0: pl.func.PHExp
        _1: pl.func.PHExp
        _2: pl.func.PHExp
        _3: pl.func.PHExp
        _4: pl.func.PHExp
        _5: pl.func.PHExp

        -- FIXME properly define return type of this... thing
        import: function(string, {any: function})
        register: function(function, string): function

        tail: function<T>({T}): {T}

        isPE: function(table): boolean
        repr: function(pl.func.PHExp): string
        instantiate: function(pl.func.PHExp): function
        I: function(pl.func.PHExp): function

        -- FIXME this is horrible...
        bind1: function<T, U>((function(T): U), T): (function(): U)
        bind1: function<T1, T2, U>((function(T1, T2): U), T1): (function(T2): U)
        bind1: function<T1, T2, T3, U>(
            (function(T1, T2, T3): U),
            T1
        ): (function(T2, T3): U)
        bind1: function<T1, T2, T3, T4, U>(
            (function(T1, T2, T3, T4): U),
            T1
        ): (function(T2, T3, T4): U)
        bind1: function<T1, T2, T3, T4, T5, U>(
                (function(T1, T2, T3, T4, T5): U), T1
            ): (function(T2, T3, T4, T5): U)
        bind1: function<T1, T2, T3, T4, T5, T6, U>(
                (function(T1, T2, T3, T4, T5, T6): U), T1
            ): (function(T2, T3, T4, T5, T6): U)

        -- FIXME Will these screw up the above definitions?
        bind1: function<T, U>((function(...: T): U), T): (function(...: T): U)

        compose: function<T, U, V>(
            (function(T): U),
            (function(U): V)
        ): (function(T): V)

        -- FIXME same as above
        compose: function<T, U, V>(
            (function(...: T): U...),
            (function(...: U): V...)
        ): (function(...: T): V...)
        compose: function(
            (function(...: any): any...),
            (function(...: any): any...)
        ): (function(...: any): any...)

        -- FIXME same as above
        bind: function<T, U>((function(T, ...: any): U), T): (function(...: any): U)

        bind: function<T1, T2, U>((function(T1, T2, ...: any): U), T1, T2): (function(...: any): U)
        bind: function<T1, T2, U>((function(T1, T2, ...: any): U), pl.func.PHExp, T2): (function(T1, ...: any): U)

        -- This is literally exponential, I am NOT doing a 4 parameter version
        bind: function<T1, T2, T3, U>((function(T1, T2, T3, ...: any): U), T1, T2, T3): (function(...: any): U)
        bind: function<T1, T2, T3, U>((function(T1, T2, T3, ...: any): U), pl.func.PHExp, T2, T3): (function(T1, ...: any): U)
        bind: function<T1, T2, T3, U>((function(T1, T2, T3, ...: any): U), T1, pl.func.PHExp, T3): (function(T2, ...: any): U)
        bind: function<T1, T2, T3, U>((function(T1, T2, T3, ...: any): U), pl.func.PHExp, pl.func.PHExp, T3): (function(T1, T2, ...: any): U)
        bind: function<T1, T2, T3, U>((function(T1, T2, T3, ...: any): U), T1, T2, pl.func.PHExp): (function(T3, ...: any): U)
        bind: function<T1, T2, T3, U>((function(T1, T2, T3, ...: any): U), pl.func.PHExp, T2, pl.func.PHExp): (function(T1, T3, ...: any): U)
        bind: function<T1, T2, T3, U>((function(T1, T2, T3, ...: any): U), T1, pl.func.PHExp, pl.func.PHExp): (function(T2, T3, ...: any): U)
    end

    import_into: function(table): (table, table)

    record input
        type linegetter = function(...: any): string
        type source = string | table

        enum FieldsOpt
            'no_fail'
        end

        alltokens: function<T>(pl.input.linegetter, string, function(string): T): (function(): T)
        create_getter: function(source): pl.input.linegetter
        numbers: function(source): (function(): number)
        words: function(source): (function(): string)

        -- {fields, nil} is a hacky substitute for a 1-tuple type
        fields: function({number, nil}, string, source, {pl.input.FieldsOpt: any}): (function(): string)
        fields: function(
            {number, number},
            string,
            source,
            {pl.input.FieldsOpt: any}
        ): (function(): string, string)
        fields: function(
            {number, number, number},
            string,
            source,
            {pl.input.FieldsOpt: any}
        ): (function(): string, string, string)
        fields: function(
            {number, number, number, number},
            string,
            source,
            {pl.input.FieldsOpt: any}
        ): (function(): string, string, string, string)
        fields: function(
            {number} | number,
            string,
            source,
            {pl.input.FieldsOpt: any}
        ): (function(): string...)
    end

    record lapp
        enum argtype
            'string'
            'number'
            'file'
            'file-in'
            'boolean'
        end

        show_usage_error: boolean

        quit: function(string, boolean)
        open: function(string, string): FILE
        error: function(string, boolean)
        assert: function(boolean, string)
        add_type: function(string, (argtype | function(string): any), function(any))
        process_options_string: function(string, {string}): {string: any}

        metamethod __call: function(pl.lapp, string, {string}): {string: any}
    end

    record lexer
        type token = {string, string}
        type tokenaction = function(string, {string: any}): (string, string)
        type tokendesc = {string, pl.lexer.tokenaction}
        type tokenstream = function(any): (string, string)

        scan: function(
            string | FILE,
            {tokendesc, tokenaction},
            {string: boolean},
            {string: any}
        ): tokenstream
        lua: function(
            string | FILE,
            {string: boolean},
            {string: any}
        )
        cpp: function(
            string | FILE,
            {string: boolean},
            {string: any}
        )

        insert: function(pl.lexer.tokenstream, string, string)
        insert: function(pl.lexer.tokenstream, {pl.lexer.token} | pl.lexer.tokenstream)

        getline: function(pl.lexer.tokenstream): string
        getrest: function(pl.lexer.tokenstream): string
        lineno: function(pl.lexer.tokenstream): number, number
        get_keywords: function(): {string: boolean}

        get_separated_list: function(
            pl.lexer.tokenstream,
            string,
            string
        ): {{pl.lexer.token}}, pl.lexer.token

        skipws: function(pl.lexer.tokenstream): pl.lexer.token
        expecting: function(
            pl.lexer.tokenstream,
            string,
            boolean
        ): pl.lexer.token
    end

    record luabalanced
        match_string: function(string, number): string, number
        match_bracketed: function(string, number): string, number
        match_expression: function(string, number): string, number
        match_namelist: function(string, number): string, number
        match_explist: function(string, number): string, number

        enum snippettype
            'e'
            'c'
            's'
        end
        match_gsub: function(
            string,
            (function(pl.luabalanced.snippettype, string): string)
        ): string
    end

    record operator
        enum OpRepr
            '+'
            '-'
            '*'
            '/'
            '%'
            '^'
            '..'
            '()'
            '[]'
            '<'
            '<='
            '>'
            '>='
            '=='
            '~='
            '#'
            'and'
            'or'
            '{}'
            '~'
            ''
        end

        optable: {pl.operator.OpRepr: function}

        -- TODO properly annotate types as in func
        call: function(function, ...: any): any...
        index: function(table, any): any

        eq: function(any, any): boolean
        neq: function(any, any): boolean
        lt: function(any, any): boolean
        le: function(any, any): boolean
        gt: function(any, any): boolean
        ge: function(any, any): boolean

        len: function(string | table): number

        add: function(number, number): number
        sub: function(number, number): number
        mul: function(number, number): number
        div: function(number, number): number
        pow: function(number, number): number
        mod: function(number, number): number
        unm: function(number): number
        concat: function(string, string): string

        add: function(any, any): any
        sub: function(any, any): any
        mul: function(any, any): any
        div: function(any, any): any
        pow: function(any, any): any
        mod: function(any, any): any
        unm: function(any): any
        concat: function(any, any): any

        lnot: function(any): boolean
        land: function(any, any): boolean
        lor: function(any, any): boolean

        table: function(...: any): {any}
        match: function(string, string): boolean
        nop: function(...: any)
    end

    record path
        is_windows: boolean
        sep: string
        dirsep: string

        dir: function(string): function(): string
        mkdir: function(string): boolean, string
        rmdir: function(string): boolean, string

        currentdir: function(): string
        chdir: function(string): boolean, string

        getsize: function(string): number

        isdir: function(string): boolean
        isfile: function(string): boolean
        isabs: function(string): boolean
        exists: function(string): boolean

        getatime: function(string): number
        getmtime: function(string): number
        getctime: function(string): number

        splitpath: function(string): string, string
        splitext: function(string): string, string

        abspath: function(string, string): string
        dirname: function(string): string
        basename: function(string): string
        extension: function(string): string

        -- 2 mandatory parts
        join: function(string, string, ...: string): string

        normcase: function(string): string
        normpath: function(string): string
        relpath: function(string, string): string
        expanduser: function(string): string

        tmpname: function(): string
        common_prefix: function(string, string): string
        package_path: function(string): string, string

        -- TODO attrib (is there a way to
        -- copy these and functions from lfs.d.tl?)
        -- TODO linkattrib
    end

    record permute
        iter: function({any}): (function(): {any})
        table: function({any}): {{any}}
    end

    record pretty
        read: function(string): table, string
        load: function(string, table, boolean): table, string
        write: function(table, string, boolean): string, string
        dump: function(table, string)
        debug: function(...: any)

        enum PrettyNumberKind
            'N'
            'M'
            'T'
        end
        number: function(number, pl.pretty.PrettyNumberKind, number)
    end

    record seq
        matching: function(string): (function(string): number, number, any...)
        list: function<T>({T}): (function(): T)

        -- TODO check if this is an OK overload
        keys: function(table): (function(): any)
        keys: function<K>({K: any}): (function(): K)

        range: function(number, number): (function(): number)
        minmax: function<T>({T} | function(): T): T, T
        sum: function<T>({T} | function(): T): T, number
        sum: function<T, U>({T} | function(): T, function(T): U): U, number

        copy: function<T>({T} | function(): T): pl.List<T>
        copy2: function<T1, T2, R1, R2>((function(T1, T2): R1, R2), T1, T2): {{R1, R2}}
        copy_tuples: function(function(): any...): {{any}}

        random: function(number, number, number): (function(): number)
        sort: function<T>((function(): T), function(T, T): boolean): (function(): T)
        zip: function<T, U>((function(): T), (function(): U)): (function(): T, U)
        printall: function<T>({T} | function(): T, string, number, function(T): string)

        -- The official documentation is wrong, this only returns 1 value
        count_map: function<T>({T} | function(): T): pl.Map<T, number>

        -- TODO
        map: function<T, U>((function(T): U), {T} | function(): T): (function(): U)
        map: function<T1, T2, U>((function(T1, T2): U), ({T1} | function(): T1), T2): (function(): U)
        map: function<T1, T2, U>((function(T1, T2): U), ({{T1, T2}} | function(): T1, T2)): (function(): U)

        filter: function<T>(({T} | function(): T), (function(T): boolean)): (function(): T)
        filter: function<T, U>(({T} | function(): T), (function(T, U): boolean), U): (function(): T)

        reduce: function<T, R>((function(R, T): R), ({T} | function(): T), R): R
        take: function<T>(({T} | function(): T), number): function(): T
        take: function<T, U>((function(): T, U), number): function(): T, U

        skip: function<T>({T}, number): {T}
        skip: function<T>((function(): T), number): {T}

        enum: function<T>(({T} | function(): T)): function(): number, T
        enum: function<T, U>((function(): T, U)): function(): number, T, U

        -- TODO Is this necessary?
        mapmethod: function(({table} | function(): table), string): function(): any
        mapmethod: function<T>(({table} | function(T): table), string, T): function(): any
        mapmethod: function<T, U>(({table} | function(T, U): table), string, T, U): function(): any

        last: function<T>(({T} | function(): T)): function(): T, T

        foreach: function<T>(({T} | function(): T), (function(T)))

        lines: function(string | FILE, ...: any): function(): any...
    end

    record sip
        enum PatCompileOpt
            'at_start'
        end
        type matcher = function(string, table): boolean

        create_pattern: function(string, {pl.sip.PatCompileOpt: boolean}): string, {string}|string, {any}
        compile: function(string, {pl.sip.PatCompileOpt: boolean}): matcher, {string}|string
        match: function(string, string, table, {PatCompileOpt: boolean}): boolean
        match_at_start: function(string, string, table): boolean
    end

    record strict
        module: function(table): table
        module: function(table, table): table
        module: function(string, table, table): table

        make_all_strict: function(table)

        closed_module: function(table, string)
    end

    record stringio
        record WriteBuffer
            write: function(pl.stringio.WriteBuffer, {string | number})
        end
        record ReadBuffer
            read: function(...: string): any...
        end

        create: function(): pl.stringio.WriteBuffer
        open: function(string): pl.stringio.ReadBuffer
    end

    record stringx
        isalpha: function(string): boolean
        isdigit: function(string): boolean
        isalnum: function(string): boolean
        isspace: function(string): boolean
        islower: function(string): boolean
        isupper: function(string): boolean
        startswith: function(string): boolean
        endswith: function(string): boolean

        join: function(string, {string} | function(): string): string
        splitlines: function(string, boolean): pl.List<string>
        split: function(string, string, string): pl.List<string>
        expandtabs: function(string, number): string

        lfind: function(string, string, number, number): number
        rfind: function(string, string, number, number): number
        replace: function(string, string, string, number): string
        count: function(string, string, boolean): number

        ljust: function(string, number, string): string
        rjust: function(string, number, string): string
        center: function(string, number, string): string
        lstrip: function(string, string): string
        rstrip: function(string, string): string
        strip: function(string, string): string

        splitv: function(string, string): string, string...
        partition: function(string, string): string, string, string
        rpartition: function(string, string): string, string, string
        at: function(string, number): string

        lines: function(string): function(): string

        title: function(string): string
        shorten: function(string, number, boolean): string
        quote_string: function(string): string
    end

    record tablex
        size: function(table): number

        index_by: function(table, {any}): pl.List<any>
        index_by: function<T, U>({T: U}, {T}): pl.List<T, U>

        -- TODO check if these are OK
        transform: function<T, U>((function(T): U), {any: T})
        transform: function<T, A, U>((function(T, A): U), {any: T}, A)
        transform: function<T, U>((function(T): U), {T})
        transform: function<T, A, U>((function(T, A): U), {T}, A)
        transform: function<A>((function(any, A)), table, A)

        range: function(number, number, number): {number}
        reduce: function<T, R>((function(R, T): R), {T}, R): R
        index_map: function<T, U>({T: U}): {U: T}

        makeset: function<T>({T}): {T: boolean}
        union: function<T>({T: any}, {T: any}): {T: any}
        intersection: function<T>({T: any}, {T: any}): {T: any}
        merge: function<T>({T: any}, {T: any}, boolean): {T: any}
        difference: function<T>({T: any}, {T: any}, boolean): {T: any}

        count_map: function<T>({T}, function(T, T): boolean): {T: number}
        set: function<T>({T}, T, number, number)
        new: function<T>(number, T): {T}
        clear: function<T>({T}, number)

        removevalues: function<T>({T}, number, number)
        readonly: function<T>(table): table

        update: function(table, table): table
        copy: function(table): table
        deepcopy: function(table): table
        icopy: function<T>({T}, {T}, number, number, number)

        insertvalues: function<T>({T}, {T})
        insertvalues: function<T>({T}, number, {T})

        compare: function<T>({T}, {T}, function(T, T): boolean): boolean
        deepcompare: function(table, table, boolean, number): boolean
        compare_no_order: function<T>({T}, {T}, function(T, T): boolean): boolean

        find: function<T>({T}, T, number): number
        rfind: function<T>({T}, T, number): number

        type cmpf = function<T, U>(T, U): boolean
        find_if: function<T, U, R>({T}, cmpf<T, U>, U): number, R

        search: function(table, any, {table}): string

        map: function<K, T, R>((function(T): R), {K: T}): {K: R}
        map: function<K, T, A, R>((function(T, A): R), {K: T}, A): {K: R}

        imap: function<T, R>((function(T): R), {T}): {R}
        imap: function<T, A, R>((function(T, A): R), {T}, A): {R}

        map_named_method: function(string, {table}, ...: any): pl.List<any>

        map2: function<T, U, A, R>((function(T, U, A): R), {any: T}, {any: U}, A): {any: R}
        imap2: function<T, U, A, R>((function(T, U, A): R), {T}, {U}, A): {R}
        mapn: function<T, R>((function(...: T): R), ...: {T}): {R}
        pairmap: function<K, V, R>((function(K, V): R)): {R}

        filter: function<T>({T}, (function(T): boolean)): pl.List<T>
        filter: function<T, A>({T}, (function(T, A): boolean), A): pl.List<T>

        foreach: function<K, V>((function(V, K)), {K: V})
        foreach: function<K, V, A>((function(V, K, A)), {K: V}, A)
        foreachi: function<V>((function(V, number)), {V})
        foreachi: function<V, A>((function(V, number, A)), {V}, A)

        sort: function<K, V>({K: V}, cmpf): function(): K, V
        sortv: function<K, V>({K: V}, cmpf): function(): K, V

        keys: function({any}): pl.List<number>
        keys: function<K>({K: any}): pl.List<K>
        values: function<V>({any: V}): pl.List<V>
        values: function<V>({V}): pl.List<V>

        sub: function<V>({V}, number, number): pl.List<V>
        zip: function<T>(...: {T}): {{T}}
        zip: function<T1, T2>({T1}, {T2}): {{T1, T2}}
        zip: function<T1, T2, T3>({T1}, {T2}, {T3}): {{T1, T2, T3}}
    end

    record template
        record CompiledTemplate
            render: function(pl.template.CompiledTemplate, table, table, boolean): string
        end

        enum CompileOpt
            'chunk_name'
            'escape'
            'inline_escape'
            'inline_brackets'
            'newline'
            'debug'
        end

        substitute: function(string, table): string
        compile: function(string, {pl.template.CompileOpt: any}): pl.template.CompiledTemplate, string, string
    end

    record test
        error_handler: function(string, number, string, string, string)
        complain: function(any, any, string, number)
        assertmatch: function(string, string, number)
        assertraise: function(function, string, number)
        asserteq: function(any, any, number, number)
        asserteq2: function(any, any, any, any, number, number)
        tuple: function(...: any): {any}

        timer: function(string, number, function): number
        timer: function<A>(string, number, function(A), A): number
    end

    record text
        format_operator: function

        indent: function(string, number, string): string
        dedent: function(string): string
        wrap: function(string, number): pl.List<string>
        fill: function(string, number): string

        record Template
            -- metamethod __call -- TODO
            substitute: function(pl.text.Template, {string: any}): string
            safe_substitute: function(pl.text.Template, {string: any}): string
            indent_substitute: function(pl.text.Template, {string: any}): string
        end
    end

    record types
        type: function(any): string

        is_type: function(any, any): boolean
        is_callable: function(any): boolean
        is_integer: function(number): boolean
        is_empty: function(any, boolean)
        is_indexable: function(any): boolean
        is_iterable: function(any): boolean
        is_writeable: function(any): boolean

        to_bool: function(any, {string}, boolean): boolean
    end

    record url
        quote: function(string, boolean): string
        unquote: function(string): string
    end

    record utils
        record packedarray<T>
            {T}
            n: number
        end
        pack: function<T>(...: T): pl.utils.packedarray
        unpack: function<T>({T}, number, number)
        printf: function(string, ...: any)
        fprintf: function(FILE, string, ...: any)
        import: function(string | table, table)
        choose: function<T>(boolean, T, T): T

        array_tostring: function<T>({T}, table, function(T, number): string): string
        is_type: function(any, string | metatable): boolean

        enum knownpattern
            'FLOAT'
            'INTEGER'
            'IDEN'
            'FILE'
        end
        patterns: {pl.utils.knownpattern: string}

        enum knownmt
            'List'
            'Map'
            'Set'
            'MultiMap'
        end
        record stdmt_entry
            _name: string
        end

        stdmt: {pl.utils.knownmt: pl.utils.stdmt_entry}

        function_arg: function(number, function | string, string): function
        assert_arg: function<T>(
            number,
            T,
            string | metatable,
            (function(any): boolean),
            string,
            number
        ): T
        assert_string: function<T>(number, T): T

        enum errormode
            'default'
            'error'
            'quit'
        end
        on_error: function(pl.utils.errormode)
        raise: function(string)

        readfile: function(string, boolean): string
        writefile: function(string, string, boolean): boolean, string
        readlines: function(string, boolean): {string}

        executeex: function(string, boolean): boolean, number, string, string
        quote_arg: function(string | {string}): string
        quit: function(string, ...: any)
        quit: function(number, string, ...: any)

        escape: function(string): string
        split: function(string, string, boolean, number): {string}
        splitv: function(string, string): string...

        -- T must be callable, but this should be a good enough compromise
        -- to guarantee function signature remains intact after memoization
        memoize: function<T>(T): T

        add_function_factory: function<T>(metatable, (function(T): function))
        string_lambda: function(string): function(...: any): any...
        bind1: function<T, U, R>((string | function(T, U, ...: any): R), T): function(U, ...: any): R
        bind2: function<T, U, R>((string | function(T, U, ...: any): R), U): function(T, ...: any): R
    end

    record xml

    end
end

return pl
