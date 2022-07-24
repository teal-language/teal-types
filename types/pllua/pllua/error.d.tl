local record err
   enum SQLErrorSeverity
      "error"
   end

   -- SQL errors caught in Lua code are represented as objects rather than strings,
   -- though print() or tostring() will give a formatted text representation
   -- The pllua.error module provides the following simple functions as a table:
   record SQLError
      -- Mandatory fields:
      category: string  -- The error category name, e.g. "data_exception", or a 5-character sqlstate category code (xx000) if no name is known
      errcode: string  -- The error code name, e.g. "numeric_value_out_of_range", or a 5-character sqlstate if no name for the error is known
      severity: SQLErrorSeverity  -- A string "error" (other values like "warning" should never be seen)
      sqlstate: string  -- The 5-character sqlstate code for the error
      message: string  -- The error message text

      -- Optional fields:
      context: string|nil  -- The error context
      column: string|nil  -- Name of a column associated with the error, if any
      constraint: string|nil  -- Name of a constraint associated with the error, if any
      datatype: string|nil  -- Name of a data type associated with the error, if any
      detail: string|nil  -- Detail message supplied for the error, if any
      hint: string|nil  -- The hint text for the error
      internal_position: integer|nil  -- the character position within the internal query
      internal_query: string|nil  -- internal query text for the error
      message_id: string|nil  -- Untranslated error message text (not available in PostgreSQL 9.5)
      pg_source_file: string|nil  -- Source file of the error
      pg_source_function: string|nil  -- Source function name of the error
      pg_source_line: integer|nil  -- source line number of the error
      position: integer|nil  -- character position of the error within the original query
      schema: string|nil  -- Name of a schema associated with the error, if any
      table: string|nil  -- Name of a table associated with the error, if any 
   end

   -- returns "error" if e is an SQL error object, otherwise nothing
   type: function(e: SQLError): SQLErrorSeverity
   type: function(e: any): nil

   -- returns e.errcode if e is an SQL error object, otherwise nothing
   errcode: function(e: SQLError): string  -- returns e.errcode
   errcode: function(e: any): nil

   -- returns e.category if e is an SQL error object, otherwise nothing
   category: function(e: SQLError): string
   category: function(e: any): nil
end

return err
