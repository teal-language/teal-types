local enum Level
   "DEBUG"
   "INFO"
   "WARN"
   "ERROR"
   "FATAL"
   "OFF"
end

local type Append = function<T>(params: T, ...: any): Log

local record Log
   append: Append
   setLevel: function (self: Log, level: Level)
   log: function(self: Log, level: Level, ...: any)
   getPrint: function(self: Log, level: Level): function(...: any)

   debug: function(self: Log, ...: any)
   info: function(self: Log, ...: any)
   warn: function(self: Log, ...: any)
   error: function(self: Log, ...: any)
   fatal: function(self: Log, ...: any)

   DEBUG: Level
   INFO: Level
   WARN: Level
   ERROR: Level
   FATAL: Level
   OFF: Level
end

local record logging
   Level: Level
   Append: Append
   Log: Log

   _COPYRIGHT: string
   _DESCRIPTION: string
   _VERSION: string

   DEBUG: Level
   INFO: Level
   WARN: Level
   ERROR: Level
   FATAL: Level
   OFF: Level

   new: function(append: function(self: Log, level: Level, msg: string | function), startLevel: Level): Log
   buildLogPatterns: function(patterns: table, default: string): table
   date: function(format: string, time: integer | string): string
   defaultLogPatterns: function(patt: string | table): table
   defaultTimestampPattern: function(patt: string): string
   defaultLevel: function(level: Level): Level
   defaultLogger: function(logger: Log): Log

   -- Deprecated
   getDeprecatedParams: function(lst: table, ...: any)

   -- Appenders (dynamically added to logging when required)
   record ConsoleParameters
      enum ConsoleDestination
         "stdout"
         "stderr"
      end

      destination: ConsoleDestination
      logPattern: string
      logPatterns: { Level : string }
      timestampPattern: string
      logLevel: Level
   end
   console: Append<ConsoleParameters>

   record FileParameters
      filename: string
      datePattern: string
      logPattern: string
      logPatterns: { Level : string }
      timestampPattern: string
      logLevel: Level
   end
   file: Append<FileParameters>

   record RollingFileParameters
      filename: string
      maxFileSize: number
      maxBackupIndex: number
      logPattern: string
      logPatterns: { Level : string }
      timestampPattern: string
      logLevel: Level
   end
   rolling_file: Append<RollingFileParameters>

   -- TODO : add more appenders
end

return logging
