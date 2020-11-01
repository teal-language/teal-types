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
    enum ModeString
        "n"
        "s"
    end
    record Cursor
        close:function(Cursor):boolean
        fetch:function(Cursor,string,ModeString):{string|nil:string}
        getcolnames:function(Cursor):{string}
        getcoltypes:function(Cursor):{string}
        numrows:function(Cursor):number
    end
end
return sql