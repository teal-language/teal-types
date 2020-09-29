local type EmptyString = enum "" end

local record ltn12
   type Filter = function<T, K>(T): K|EmptyString, T
   type Sink = function<T>(T|EmptyString, string): boolean, string
   type Source = function<T>(): T|EmptyString, string

   type FancySink = function<T>(T|EmptyString, string): boolean, string|FancySink<T>
   type FancySource = function<T>(): T|EmptyString, string|FancySource<T>

   -- Docs just say returns a truthy value on success
   -- Since this value should really only be
   -- used to check for truthiness, any seems fine here
   type Pump = function<T>(Source<T>, Sink<T>): any, string

   record filter
      -- Technically each filter's type should be dependent on the last
      -- For two or three types this seems reasonable, but the generic case
      -- requires a much more advanced type system
      -- e.g. function<a,b,...,z>(Filter<a,b>, Filter<b,c>, ...): Filter<a,z>
      chain: function<A, B, C>(Filter<A, B>, Filter<B, C>): Filter<A, C>
      chain: function<T>(Filter<T, T>, Filter<T, T>, ...: Filter<T, T>): Filter<T, T>

      cycle: function<T, K>(Filter<T, K>): Filter<T, K>
      cycle: function<T, K>(Filter<T, K>, T): Filter<T, K>
      cycle: function<T, K>(Filter<T, K>, T, any): Filter<T, K>
   end
   record pump
      all: Pump<any>
      step: Pump<any>
   end
   record sink
      chain: function<T, K>(Filter<T, K>, Sink<K>): Sink<T>
      error: function<T>(string): Sink<T>
      file: function(FILE, string): Sink<string>
      null: function(): Sink<any>
      simplify: function<T>(FancySink<T>): Sink<T>
      table: function<T>(): Sink<T>, {T}
      table: function<T>({T}): Sink<T>, {T}
   end
   record source
      -- same situation with filter.chain and dependent types
      cat: function<T, K>(Source<T>, Source<K>): Source<T|K>
      cat: function<T>(Source<T>, ...: Source<T>): Source<T>
      chain: function<T, K>(Source<T>, Filter<T, K>): Source<K>
      empty: function(): Source<any>
      error: function(string): Source<any>
      file: function(FILE): Source<string>
      file: function(FILE, string): Source<string>
      simplify: function<T>(FancySource<T>): Source<T>
      string: function(string): Source<string>
      table: function<T>({T}): Source<T>, {T}
   end
end

return ltn12
