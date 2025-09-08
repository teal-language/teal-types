local record sql
    postgres: function():Driver
    record Driver
        connect:function(Driver,string):Connection
    end


    record Connection
        setautocommit:function(Connection,boolean):boolean
        escape: function(Connection,string):string
        execute:function(Connection,string):Cursor|number
        commit: function(Connection):boolean
        rollback: function(Connection):boolean
        close:function(Connection):boolean
    end
    --these 2 enums are to enable a hack that makes it a lot more nicer to work with the cursor
    -- see https://github.com/teal-language/teal-types/pull/18#discussion_r518265263
    enum Numeric
        "n"
    end

    enum Alpha
        "s"
    end

    record Cursor
        close:function(Cursor):boolean
        --this is the hack: https://github.com/teal-language/teal-types/pull/18#discussion_r518265263
        fetch: function(Numeric): {string}
        fetch: function(Alpha): {string:string}

        getcolnames:function(Cursor):{string}
        getcoltypes:function(Cursor):{string}
        numrows:function(Cursor):number
    end
end
return sql
