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
        filter: function<U>(List<T>, function(T, U): boolean, U): List<T>
        transform: function(List<T>, (function(T, ...: any): T), ...: any): List<T>
        map: function<U>(List<T>, (function(T, ...: any): U), ...: any): List<U>
        map2: function<U, V>(List<T>, (function(T, U, ...: any): V), List<U>, ...: any): List<V> -- this is ridiculous

        mapm: function<U>(List<T>, string, ...: any): List<U>
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
        record Array2D<T>
            {{T}}
        end

        new: function<T>(number, number, T): Array2D<T>

        size: function<T>(Array2D<T>): number, number
        column: function<T>(Array2D<T>, number): List<T>
        flatten: function<T>(Array2D<T>): List<T>
        reshape: function<T>(Array2D<T>, number, boolean): Array2D<T>

        swap_rows: function<T>(Array2D<T>, number, number)
        swap_cols: function<T>(Array2D<T>, number, number)

        reduce_rows: function<T>(function(T, T): T, Array2D<T>): List<T>
        reduce_cols: function<T>(function(T, T): T, Array2D<T>): List<T>
        reduce2: function<T>(function(T, T): T, function(T, T): T, Array2D<T>): T

        map: function<T, U>((function<U>(T, ...: any): U), Array2D<T>, ...: any): Array2D<U>

        -- Waaaaayyy too many possible branching return values
        map2: function((function(any, any, ...:any): any), number, number, table, table, ...: any): {any}

        product: function<T, U, V>(function(T, U): V, {T}, {U}): Array2D<V>

        extract_rows: function<T>(Array2D<T>, {number}): Array2D<T>
        extract_cols: function<T>(Array2D<T>, {number}): Array2D<T>

        remove_row: function<T>(Array2D<T>, number)
        remove_col: function<T>(Array2D<T>, number)

        parse_range: function(string): number, number, number, number
        range: function<T>(Array2D<T>, string): {T}
        slice: function<T>(Array2D<T>, number, number, number, number): {T}
        set: function<T>(Array2D<T>, T, number, number, number, number)
        write: function<T>(Array2D<T>, FILE, string, number, number, number, number)

        forall: function<T>(Array2D<T>, function({T}, number), function(number), number, number, number, number)
        move: function<T>(Array2D<T>, number, number, Array2D, number, number, number, number)

        iter: function<T>(Array2D<T>, boolean, number, number, number, number): (function(): (T | {number, number, T}))

        columns: function<T>(Array2D<T>): (function(): List<T>)
    end

    record class
        record Class
            -- TODO {string: any} OR __index
            class_of: function(Class, Instance): boolean
            cast: function(Class, Instance)
        end

        record Instance
            -- TODO {string: any} OR __index
            is_a: function(Instance, Class): boolean
        end
    end

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

    record comprehension
        type generator = (function(): {any})
        type parser = (function(string): generator) -- wtf
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

    record file
        -- TODO copy declarations from other functions
        -- this whole module is just renaming of other functions
    end

    record func
        record PlaceholderExp end

        -- FIXME properly define return type of this... thing
        import: function(string, {any: function})
        register: function(function, string): function

        tail: function<T>({T}): {T}

        isPE: function(table): boolean
        repr: function(PlaceholderExp): string
        instantiate: function(PlaceholderExp): function
        I: function(PlaceholderExp): function

        -- TODO is this worth it? It could aid error detection, but
        -- where to stop?
        bind1: function<T, U>((function(T): U), T): (function(): U)
        bind1: function<T1, T2, U>((function(T1, T2): U), T1): (function(T2): U)
        bind1: function<T1, T2, T3, U>((function(T1, T2, T3): U), T1): (function(T2, T3): U)
        bind1: function<T1, T2, T3, T4, U>((function(T1, T2, T3, T4): U), T1): (function(T2, T3, T4): U)
        bind1: function<T1, T2, T3, T4, T5, U>(
                (function(T1, T2, T3, T4, T5): U), T1
            ): (function(T2, T3, T4, T5): U)
        bind1: function<T1, T2, T3, T4, T5, T6, U>(
                (function(T1, T2, T3, T4, T5, T6): U), T1
            ): (function(T2, T3, T4, T5, T6): U)

        -- FIXME Will these screw up the above definiitons?
        bind1: function<T, U>((function(...: T): U), T): (function(...: T): U)
        bind1: function((function(...: any): any...), any): (function(...: any): any...)

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
        bind: function<T1, T2, T3, U>((function(T1, T2, T3, ...: any): U), T1, T2, T3): (function(...: any): U)
    end

    import_into: function(table): (table, table)

    record input
        type linegetter = function(...: any): string
        type source = string | table

        enum FieldsOpt
            'no_fail'
        end

        alltokens: function<T>(linegetter, string, function(string): T): (function(): T)
        create_getter: function(source): linegetter
        numbers: function(source): (function(): number)
        words: function(source): (function(): string)

        -- FIXME declare return type with overloads for the first parameter
        fields: function({number} | number, string, source, {FieldsOpt: any}): (function(): string...)
    end

    -- TODO lapp
    -- TODO lexer
    -- TODO luabalanced

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

        optable: {OpRepr: function}
        type op = function | OpRepr

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
        number: function(number, PrettyNumberKind, number)
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

        copy: function<T>({T} | function(): T): List<T>
        copy2: function<T1, T2, R1, R2>((function(T1, T2): R1, R2), T1, T2): {{R1, R2}}
        copy_tuples: function(function(): any...): {{any}}

        random: function(number, number, number): (function(): number)
        sort: function<T>((function(): T), function(T, T): boolean): (function(): T)
        zip: function<T, U>((function(): T), (function(): U)): (function(): T, U)
        printall: function<T>({T} | function(): T, string, number, function(T): string)

        -- The official documentation is wrong, this only returns 1 value
        count_map: function<T>({T} | function(): T): Map<T, number>

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

        create_pattern: function(string, {PatCompileOpt: boolean}): string, {string}|string, {any}
        compile: function(string, {PatCompileOpt: boolean}): matcher, {string}|string
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
            write: function(WriteBuffer, {string | number})
        end
        record ReadBuffer
            read: function(...: string): any...
        end

        create: function(): WriteBuffer
        open: function(string): ReadBuffer
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
        splitlines: function(string, boolean): List<string>
        split: function(string, string, string): List<string>
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

        index_by: function(table, {any}): List<any>
        index_by: function<T, U>({T: U}, {T}): List<T, U>

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

        map_named_method: function(string, {table}, ...: any): List<any>

        map2: function<T, U, A, R>((function(T, U, A): R), {any: T}, {any: U}, A): {any: R}
        imap2: function<T, U, A, R>((function(T, U, A): R), {T}, {U}, A): {R}
        mapn: function<T, R>((function(...: T): R), ...: {T}): {R}
        pairmap: function<K, V, R>((function(K, V): R)): {R}

        filter: function<T>({T}, (function(T): boolean)): List<T>
        filter: function<T, A>({T}, (function(T, A): boolean), A): List<T>

        foreach: function<K, V>((function(V, K)), {K: V})
        foreach: function<K, V, A>((function(V, K, A)), {K: V}, A)
        foreachi: function<V>((function(V, number)), {V})
        foreachi: function<V, A>((function(V, number, A)), {V}, A)

        sort: function<K, V>({K: V}, cmpf): function(): K, V
        sortv: function<K, V>({K: V}, cmpf): function(): K, V

        keys: function({any}): List<number>
        keys: function<K>({K: any}): List<K>
        values: function<V>({any: V}): List<V>
        values: function<V>({V}): List<V>

        sub: function<V>({V}, number, number): List<V>
        zip: function<T>(...: {T}): {{T}}
        zip: function<T1, T2>({T1}, {T2}): {{T1, T2}}
        zip: function<T1, T2, T3>({T1}, {T2}, {T3}): {{T1, T2, T3}}
    end

    record template
        record CompiledTemplate
            render: function(CompiledTemplate, table, table, boolean): string
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
        compile: function(string, {CompileOpt: any}): CompiledTemplate, string, string
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
        wrap: function(string, number): List<string>
        fill: function(string, number): string

        record Template
            -- metamethod __call -- TODO
            substitute: function(Template, {string: any}): string
            safe_substitute: function(Template, {string: any}): string
            indent_substitute: function(Template, {string: any}): string
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

    -- TODO utils
    -- TODO xml
end

return pl
