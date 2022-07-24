local spi = require 'pllua.spi'

local record trigger
   -- This module provides nothing directly to Lua, but a trigger parameter of
   -- type Trigger is passed as the first parameter to trigger functions (and
   -- a different trigger parameter to event-trigger functions).
   record Trigger
      event: string
      tag: string

      new: spi.Row
      old: spi.Row
      row: spi.Row

      name: string

      enum When
         "before"
         "after"
         "instead"
      end
      when: When

      enum Operation
         "insert"
         "update"
         "delete"
         "truncate"
      end
      operation: Operation
      op: Operation

      enum Level
         "row"
         "statement"
      end
      level: Level

      record Relation
         namespace: string  -- eg: 'public'
         attributes: {string: integer}
         name: string
         oid: integer
      end
      relation: Relation
   end
end

return trigger
