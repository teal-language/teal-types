-- Module added in pllua version 2.0.3.

require 'pllua.pgtype'

local record time
   record CalendarTable
      -- available for: timestamptz, timestamp, date, interval
      year: integer
      month: integer
      day: integer
      -- available for: timestamptz, timetz, timestamp, time, interval
      hour: integer
      min: integer
      sec: integer
      usec: integer
      -- available for: timestamptz, timetz
      timezone: integer
      -- available for: timestamptz
      timezone_abbrev: string
      isdst: boolean
   end

   record DatetimeDatum
      userdata

      as_table: function(): CalendarTable

      -- only available for timestamptz, timezone cannot be an abbreviation (UTC and UTC±hh[:mm] is allowed though):
      as_table: function(timezone: integer|string): CalendarTable

      typeinfo: TypeInfo

      -- available for: timestamptz, timestamp, date, interval
      year: integer
      month: integer
      day: integer
      -- available for: timestamptz, timetz, timestamp, time, interval
      hour: integer
      min: integer
      sec: integer
      usec: integer
      -- available for: timestamptz, timetz
      timezone: integer
      -- available for: timestamptz
      timezone_abbrev: string
      isdst: boolean

      -- available for timestamptz, timestamp, date:
      week: integer
      epoch: number
      epoch_msec: number
      iso_year: integer
   end
end

return time
