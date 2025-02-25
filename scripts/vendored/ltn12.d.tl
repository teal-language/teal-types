local record ltn12
   type Filter = function(string): string, string

   type Sink = function(string, string): boolean, string

   -- returns nil, nil to indicate EOF
   type Source = function(): string, string

   type RewindSource = function(? string): string, string

   type FancySink = function(string, string): boolean, string | FancySink
   type FancySource = function(): string, string | FancySource

   -- Docs just say returns a truthy value on success
   -- Since this value should really only be
   -- used to check for truthiness, any seems fine here
   type Pump = function(Source, Sink): any, string

   record filter
      chain: function(Filter, Filter, ...: Filter): Filter
      cycle: function<A, B>((function(A, string, B): string, A), A, B): Filter
   end
   record pump
      all: function(Source, Sink, ? Pump): any, string
      step: Pump
   end
   record sink
      chain: function(Filter, Sink): Sink -- simplified
      error: function(string): Sink
      file: function(FILE, ? string, ? integer): Sink
      null: function(): Sink
      simplify: function(FancySink): Sink
      table: function({string}): Sink, {string}
   end
   record source
      cat: function(Source, ...: Source): Source
      chain: function(Source, Filter): Source -- simplified
      empty: function(): Source
      error: function(string): Source
      file: function(FILE, ? string, ? integer): Source
      rewind: function(Source): RewindSource
      simplify: function(FancySource): Source
      string: function(string): Source
      table: function({string}): Source, {string}
   end
end

return ltn12
