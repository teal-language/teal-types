-- TODO: see https://github.com/teal-language/tl/issues/812

-- See full docs here
-- https://github.com/luvit/luv/blob/master/docs.md

local record uv

   enum RunModes
      "default"
      "once"
      "nowait"
   end

   interface Req
      userdata
      cancel:function(Req):integer, string
      get_type:function(Req):string, integer
   end

   cancel:function(Req):integer, string
   req_get_type:function(Req):string, integer

   interface Handle
      userdata

      --- ### `uv.is_active(handle)`
      -- 
      -- > method form `handle:is_active()`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- 
      -- Returns `true` if the handle is active, `false` if it's inactive. What "active”
      -- means depends on the type of handle:
      -- 
      --   - A [`uv_async_t`] handle is always active and cannot be deactivated, except
      --   by closing it with `uv.close()`.
      -- 
      --   - A [`uv_pipe_t`], [`uv_tcp_t`], [`uv_udp_t`], etc. handle - basically
      --   any handle that deals with I/O - is active when it is doing something that
      --   involves I/O, like reading, writing, connecting, accepting new connections,
      --   etc.
      -- 
      --   - A [`uv_check_t`], [`uv_idle_t`], [`uv_timer_t`], etc. handle is active
      --   when it has been started with a call to `uv.check_start()`, `uv.idle_start()`,
      --   `uv.timer_start()` etc. until it has been stopped with a call to its
      --   respective stop function.
      -- 
      -- @return `boolean` or `fail`
      -- 
      is_active:function(Handle):boolean, string

      --- ### `uv.is_closing(handle)`
      -- 
      -- > method form `handle:is_closing()`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- 
      -- Returns `true` if the handle is closing or closed, `false` otherwise.
      -- 
      -- @return `boolean` or `fail`
      -- 
      -- **Note**: This function should only be used between the initialization of the
      -- handle and the arrival of the close callback.
      -- 
      is_closing:function(Handle):boolean, string

      --- ### `uv.close(handle, [callback])`
      -- 
      -- > method form `handle:close([callback])`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- @param `callback`: `callable` or `nil`
      -- 
      -- Request handle to be closed. `callback` will be called asynchronously after this
      -- call. This MUST be called on each handle before memory is released.
      -- 
      -- Handles that wrap file descriptors are closed immediately but `callback` will
      -- still be deferred to the next iteration of the event loop. It gives you a chance
      -- to free up any resources associated with the handle.
      -- 
      -- In-progress requests, like `uv_connect_t` or `uv_write_t`, are cancelled and
      -- have their callbacks called asynchronously with `ECANCELED`.
      -- 
      -- @return Nothing.
      -- 
      close:function(Handle, callback:function())

      --- ### `uv.ref(handle)`
      -- 
      -- > method form `handle:ref()`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- 
      -- Reference the given handle. References are idempotent, that is, if a handle is
      -- already referenced calling this function again will have no effect.
      -- 
      -- @return Nothing.
      -- 
      -- See [Reference counting].
      -- 
      ref:function(Handle)

      --- ### `uv.unref(handle)`
      -- 
      -- > method form `handle:unref()`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- 
      -- Un-reference the given handle. References are idempotent, that is, if a handle
      -- is not referenced calling this function again will have no effect.
      -- 
      -- @return Nothing.
      -- 
      -- See [Reference counting].
      -- 
      unref:function(Handle)

      --- ### `uv.has_ref(handle)`
      -- 
      -- > method form `handle:has_ref()`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- 
      -- Returns `true` if the handle referenced, `false` if not.
      -- 
      -- @return `boolean` or `fail`
      -- 
      -- See [Reference counting].
      -- 
      has_ref:function(Handle):boolean, string

      --- ### `uv.send_buffer_size(handle, [size])`
      -- 
      -- > method form `handle:send_buffer_size([size])`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- @param `size`: `integer` or `nil` (default: `0`)
      -- 
      -- Gets or sets the size of the send buffer that the operating system uses for the
      -- socket.
      -- 
      -- If `size` is omitted (or `0`), this will return the current send buffer size; otherwise, this will use `size` to set the new send buffer size.
      -- 
      -- This function works for TCP, pipe and UDP handles on Unix and for TCP and UDP
      -- handles on Windows.
      -- 
      -- @return
      -- - `integer` or `fail` (if `size` is `nil` or `0`)
      -- - `0` or `fail` (if `size` is not `nil` and not `0`)
      -- 
      -- **Note**: Linux will set double the size and return double the size of the
      -- original set value.
      send_buffer_size:function(Handle, size:integer):integer, string

      --- ### `uv.recv_buffer_size(handle, [size])`
      -- 
      -- > method form `handle:recv_buffer_size([size])`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- @param `size`: `integer` or `nil` (default: `0`)
      -- 
      -- Gets or sets the size of the receive buffer that the operating system uses for
      -- the socket.
      -- 
      -- If `size` is omitted (or `0`), this will return the current send buffer size; otherwise, this will use `size` to set the new send buffer size.
      -- 
      -- This function works for TCP, pipe and UDP handles on Unix and for TCP and UDP
      -- handles on Windows.
      -- 
      -- @return
      -- - `integer` or `fail` (if `size` is `nil` or `0`)
      -- - `0` or `fail` (if `size` is not `nil` and not `0`)
      -- 
      -- **Note**: Linux will set double the size and return double the size of the
      -- original set value.
      -- 
      recv_buffer_size:function(Handle, size:integer):integer, string

      --- ### `uv.fileno(handle)`
      -- 
      -- > method form `handle:fileno()`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- 
      -- Gets the platform dependent file descriptor equivalent.
      -- 
      -- The following handles are supported: TCP, pipes, TTY, UDP and poll. Passing any
      -- other handle type will fail with `EINVAL`.
      -- 
      -- If a handle doesn't have an attached file descriptor yet or the handle itself
      -- has been closed, this function will return `EBADF`.
      -- 
      -- @return `integer` or `fail`
      -- 
      -- **Warning**: Be very careful when using this function. libuv assumes it's in
      -- control of the file descriptor so any change to it may lead to malfunction.
      -- 
      fileno:function(Handle):integer, string

      --- ### `uv.handle_get_type(handle)`
      -- 
      -- > method form `handle:get_type()`
      -- 
      -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
      -- 
      -- Returns the name of the struct for a given handle (e.g. `"pipe"` for `uv_pipe_t`)
      -- and the libuv enum integer for the handle's type (`uv_handle_type`).
      -- 
      -- @return `string, integer`
      -- 
      get_type:function(Handle):string, integer
   end

   --- Returns the libuv version packed into a single integer. 8 bits are used for each
   -- component, with the patch number stored in the 8 least significant bits. For
   -- example, this would be 0x010203 in libuv 1.2.3.
   -- 
   -- @return `integer`
   -- 
   version:function():integer

   --- Returns the libuv version number as a string. For example, this would be "1.2.3"
   -- in libuv 1.2.3. For non-release versions, the version suffix is included.
   -- 
   -- @return `string`
   version_string:function():string

   --- Closes all internal loop resources. In normal execution, the loop will
   -- automatically be closed when it is garbage collected by Lua, so it is not
   -- necessary to explicitly call `loop_close()`. Call this function only after the
   -- loop has finished executing and all open handles and requests have been closed,
   -- or it will return `EBUSY`.
   -- 
   -- @return `0` or `fail`
   loop_close:function():integer, string

   --- ### `uv.run([mode])`
   -- 
   -- @param: `mode`: `string` or `nil` (default: `"default"`)
   -- 
   -- This function runs the event loop. It will act differently depending on the
   -- specified mode:
   -- 
   --   - `"default"`: Runs the event loop until there are no more active and
   --   referenced handles or requests. Returns `true` if `uv.stop()` was called and
   --   there are still active handles or requests. Returns `false` in all other
   --   cases.
   -- 
   --   - `"once"`: Poll for I/O once. Note that this function blocks if there are no
   --   pending callbacks. Returns `false` when done (no active handles or requests
   --   left), or `true` if more callbacks are expected (meaning you should run the
   --   event loop again sometime in the future).
   -- 
   --   - `"nowait"`: Poll for I/O once but don't block if there are no pending
   --   callbacks. Returns `false` if done (no active handles or requests left),
   --   or `true` if more callbacks are expected (meaning you should run the event
   --   loop again sometime in the future).
   -- 
   -- @return `boolean` or `fail`
   -- 
   -- **Note:** Luvit will implicitly call `uv.run()` after loading user code, but if
   -- you use the luv bindings directly, you need to call this after registering
   -- your initial set of event callbacks to start the event loop.
   run:function(mode:RunModes):boolean, string


   --- ### `uv.loop_configure(option, ...)`
   -- 
   -- @param `option`: `string`
   -- @param `...`: depends on `option`, see below
   -- 
   -- Set additional loop options. You should normally call this before the first call
   -- to uv_run() unless mentioned otherwise.
   -- 
   -- Supported options:
   -- 
   --   - `"block_signal"`: Block a signal when polling for new events. The second argument
   --   to loop_configure() is the signal name (as a lowercase string) or the signal number.
   --   This operation is currently only implemented for `"sigprof"` signals, to suppress
   --   unnecessary wakeups when using a sampling profiler. Requesting other signals will
   --   fail with `EINVAL`.
   --   - `"metrics_idle_time"`: Accumulate the amount of idle time the event loop spends
   --   in the event provider. This option is necessary to use `metrics_idle_time()`.
   -- 
   -- An example of a valid call to this function is:
   -- 
   -- ```lua
   -- uv.loop_configure("block_signal", "sigprof")
   -- ```
   -- 
   -- @return `0` or `fail`
   -- 
   -- **Note:** Be prepared to handle the `ENOSYS` error; it means the loop option is
   -- not supported by the platform.
   -- 
   loop_configure:function(option:string, ...:any):integer, string

   --- ### `uv.loop_mode()`
   -- 
   -- If the loop is running, returns a string indicating the mode in use. If the loop
   -- is not running, `nil` is returned instead.
   -- 
   -- @return `string` or `nil`
   -- 
   loop_mode:function():string

   --- ### `uv.loop_alive()`
   -- 
   -- Returns `true` if there are referenced active handles, active requests, or
   -- closing handles in the loop; otherwise, `false`.
   -- 
   -- @return `boolean` or `fail`
   -- 
   loop_alive:function():boolean, string

   --- ### `uv.stop()`
   -- 
   -- Stop the event loop, causing `uv.run()` to end as soon as possible. This
   -- will happen not sooner than the next loop iteration. If this function was called
   -- before blocking for I/O, the loop won't block for I/O on this iteration.
   -- 
   -- @return Nothing.
   -- 
   stop:function()

   --- ### `uv.backend_fd()`
   -- 
   -- Get backend file descriptor. Only kqueue, epoll, and event ports are supported.
   -- 
   -- This can be used in conjunction with `uv.run("nowait")` to poll in one thread
   -- and run the event loop's callbacks in another
   -- 
   -- @return `integer` or `nil`
   -- 
   -- **Note**: Embedding a kqueue fd in another kqueue pollset doesn't work on all
   -- platforms. It's not an error to add the fd but it never generates events.
   -- 
   backend_fd:function():integer

   --- ### `uv.backend_timeout()`
   -- 
   -- Get the poll timeout. The return value is in milliseconds, or -1 for no timeout.
   -- 
   -- @return `integer`
   -- 
   backend_timeout:function():integer

   --- ### `uv.now()`
   -- 
   -- Returns the current timestamp in milliseconds. The timestamp is cached at the
   -- start of the event loop tick, see `uv.update_time()` for details and rationale.
   -- 
   -- The timestamp increases monotonically from some arbitrary point in time. Don't
   -- make assumptions about the starting point, you will only get disappointed.
   -- 
   -- @return `integer`
   -- 
   -- **Note**: Use `uv.hrtime()` if you need sub-millisecond granularity.
   -- 
   now:function():integer

   --- ### `uv.update_time()`
   -- 
   -- Update the event loop's concept of "now". Libuv caches the current time at the
   -- start of the event loop tick in order to reduce the number of time-related
   -- system calls.
   -- 
   -- You won't normally need to call this function unless you have callbacks that
   -- block the event loop for longer periods of time, where "longer" is somewhat
   -- subjective but probably on the order of a millisecond or more.
   -- 
   -- @return Nothing.
   -- 
   update_time:function()

   --- ### `uv.walk(callback)`
   -- 
   -- @param `callback`: `callable`
   -- @param `handle`: `userdata` for sub-type of `uv_handle_t`
   -- 
   -- Walk the list of handles: `callback` will be executed with each handle.
   -- 
   -- @return Nothing.
   -- 
   -- ```lua
   -- -- Example usage of uv.walk to close all handles that aren't already closing.
   -- uv.walk(function (handle)
   --   if not handle:is_closing() then
   --     handle:close()
   --   end
   -- end)
   -- ```
   walk:function(function(handle:Handle))

   --- ## `uv_timer_t` — Timer handle
   -- 
   -- [`uv_timer_t`]: #uv_timer_t--timer-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- Timer handles are used to schedule callbacks to be called in the future.
   interface Timer is Handle where (self as Handle):get_type() == "timer"
      --- ### `uv.timer_start(timer, timeout, repeat, callback)`
      -- 
      -- > method form `timer:start(timeout, repeat, callback)`
      -- 
      -- @param `timer`: `uv_timer_t userdata`
      -- @param `timeout`: `integer`
      -- @param `repeat`: `integer`
      -- @param `callback`: `callable`
      -- 
      -- Start the timer. `timeout` and `repeat` are in milliseconds.
      -- 
      -- If `timeout` is zero, the callback fires on the next event loop iteration. If
      -- `repeat` is non-zero, the callback fires first after `timeout` milliseconds and
      -- then repeatedly after `repeat` milliseconds.
      -- 
      -- @return `0` or `fail`
      -- 
      start:function(Timer, timeout:integer, rep:integer, callback:function()):integer, string

      --- ### `uv.timer_stop(timer)`
      -- 
      -- > method form `timer:stop()`
      -- 
      -- @param `timer`: `uv_timer_t userdata`
      -- 
      -- Stop the timer, the callback will not be called anymore.
      -- 
      -- @return `0` or `fail`
      -- 
      stop:function(Timer):integer, string

      --- ### `uv.timer_again(timer)`
      -- 
      -- > method form `timer:again()`
      -- 
      -- @param `timer`: `uv_timer_t userdata`
      -- 
      -- Stop the timer, and if it is repeating restart it using the repeat value as the
      -- timeout. If the timer has never been started before it raises `EINVAL`.
      -- 
      -- @return `0` or `fail`
      -- 
      again:function(Timer):integer, string

      --- ### `uv.timer_set_repeat(timer, repeat)`
      -- 
      -- > method form `timer:set_repeat(repeat)`
      -- 
      -- @param `timer`: `uv_timer_t userdata`
      -- @param `repeat`: `integer`
      -- 
      -- Set the repeat interval value in milliseconds. The timer will be scheduled to
      -- run on the given interval, regardless of the callback execution duration, and
      -- will follow normal timer semantics in the case of a time-slice overrun.
      -- 
      -- For example, if a 50 ms repeating timer first runs for 17 ms, it will be
      -- scheduled to run again 33 ms later. If other tasks consume more than the 33 ms
      -- following the first timer callback, then the callback will run as soon as
      -- possible.
      -- 
      -- @return Nothing.
      -- 
      set_repeat:function(Timer, rep:integer)

      --- ### `uv.timer_get_repeat(timer)`
      -- 
      -- > method form `timer:get_repeat()`
      -- 
      -- @param `timer`: `uv_timer_t userdata`
      -- 
      -- Get the timer repeat value.
      -- 
      -- @return `integer`
      -- 
      get_repeat:function(Timer):integer

      --- ### `uv.timer_get_due_in(timer)`
      -- 
      -- > method form `timer:get_due_in()`
      -- 
      -- @param `timer`: `uv_timer_t userdata`
      -- 
      -- Get the timer due value or 0 if it has expired. The time is relative to `uv.now()`.
      -- 
      -- @return `integer`
      get_due_in:function(Timer):integer
   end

   --- ### `uv.new_timer()`
   -- 
   -- Creates and initializes a new `uv_timer_t`. Returns the Lua userdata wrapping
   -- it.
   -- 
   -- @return `uv_timer_t userdata` or `fail`
   new_timer:function():Timer

   --- **Note**: New in libuv version 1.40.0.
   -- 
   -- ## `uv_prepare_t` — Prepare handle
   -- 
   -- [`uv_prepare_t`]: #uv_prepare_t--prepare-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- Prepare handles will run the given callback once per loop iteration, right
   -- before polling for I/O.
   -- 
   -- ```lua
   -- local prepare = uv.new_prepare()
   -- prepare:start(function()
   --   print("Before I/O polling")
   -- end)
   -- ```
   interface Prepare is Handle where (self as Handle):get_type() == "prepare"
      --- ### `uv.prepare_start(prepare, callback)`
      -- 
      -- > method form `prepare:start(callback)`
      -- 
      -- @param `prepare`: `uv_prepare_t userdata`
      -- @param `callback`: `callable`
      -- 
      -- Start the handle with the given callback.
      -- 
      -- @return `0` or `fail`
      -- 
      start:function(Prepare, callback:function()):integer, string

      --- ### `uv.prepare_stop(prepare)`
      -- 
      -- > method form `prepare:stop()`
      -- 
      -- @param `prepare`: `uv_prepare_t userdata`
      -- 
      -- Stop the handle, the callback will no longer be called.
      -- 
      -- @return `0` or `fail`
      -- 
      stop:function(Prepare):integer, string
   end

   --- ### `uv.new_prepare()`
   -- 
   -- Creates and initializes a new `uv_prepare_t`. Returns the Lua userdata wrapping
   -- it.
   -- 
   -- @return `uv_prepare_t userdata` or `fail`
   -- 
   new_prepare:function():Prepare, string

   --- ## `uv_check_t` — Check handle
   -- 
   -- [`uv_check_t`]: #uv_check_t--check-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- Check handles will run the given callback once per loop iteration, right after
   -- polling for I/O.
   -- 
   -- ```lua
   -- local check = uv.new_check()
   -- check:start(function()
   --   print("After I/O polling")
   -- end)
   -- ```
   -- 
   interface Check is Handle where (self as Handle):get_type() == "check"
      --- ### `uv.check_start(check, callback)`
      -- 
      -- > method form `check:start(callback)`
      -- 
      -- @param `check`: `uv_check_t userdata`
      -- @param `callback`: `callable`
      -- 
      -- Start the handle with the given callback.
      -- 
      -- @return `0` or `fail`
      -- 
      start:function(Check, callback:function()):integer, string

      --- ### `uv.check_stop(check)`
      -- 
      -- > method form `check:stop()`
      -- 
      -- @param `check`: `uv_check_t userdata`
      -- 
      -- Stop the handle, the callback will no longer be called.
      -- 
      -- @return `0` or `fail`
      -- 
      stop:function():integer, string
   end

   --- ### `uv.new_check()`
   -- 
   -- Creates and initializes a new `uv_check_t`. Returns the Lua userdata wrapping
   -- it.
   -- 
   -- @return `uv_check_t userdata` or `fail`
   -- 
   new_check:function():Check, string

   --- ## `uv_idle_t` — Idle handle
   -- 
   -- [`uv_idle_t`]: #uv_idle_t--idle-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- Idle handles will run the given callback once per loop iteration, right before
   -- the [`uv_prepare_t`] handles.
   -- 
   -- **Note**: The notable difference with prepare handles is that when there are
   -- active idle handles, the loop will perform a zero timeout poll instead of
   -- blocking for I/O.
   -- 
   -- **Warning**: Despite the name, idle handles will get their callbacks called on
   -- every loop iteration, not when the loop is actually "idle".
   -- 
   -- ```lua
   -- local idle = uv.new_idle()
   -- idle:start(function()
   --   print("Before I/O polling, no blocking")
   -- end)
   -- ```
   -- 
   interface Idle is Handle where (self as Handle):get_type() == "idle"
      --- ### `uv.idle_start(idle, callback)`
      -- 
      -- > method form `idle:start(callback)`
      -- 
      -- @param `idle`: `uv_idle_t userdata`
      -- @param `callback`: `callable`
      -- 
      -- Start the handle with the given callback.
      -- 
      -- @return `0` or `fail`
      -- 
      start:function(Idle, callback:function()):integer, string

      --- ### `uv.idle_stop(check)`
      -- 
      -- > method form `idle:stop()`
      -- 
      -- @param `idle`: `uv_idle_t userdata`
      -- 
      -- Stop the handle, the callback will no longer be called.
      -- 
      -- @return `0` or `fail`
      -- 
      stop:function():integer, string
   end

   --- ### `uv.new_idle()`
   -- 
   -- Creates and initializes a new `uv_idle_t`. Returns the Lua userdata wrapping
   -- it.
   -- 
   -- @return `uv_idle_t userdata` or `fail`
   -- 
   new_idle:function():Idle, string

   --- ## `uv_async_t` — Async handle
   -- 
   -- [`uv_async_t`]: #uv_async_t--async-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- Async handles allow the user to "wakeup" the event loop and get a callback
   -- called from another thread.
   -- 
   -- ```lua
   -- local async
   -- async = uv.new_async(function()
   --   print("async operation ran")
   --   async:close()
   -- end)
   -- 
   -- async:send()
   -- ```
   -- 
   interface Async is Handle where (self as Handle):get_type() == "async"
      --- ### `uv.async_send(async, ...)`
      -- 
      -- > method form `async:send(...)`
      -- 
      -- @param `async`: `uv_async_t userdata`
      -- @param `...`: `threadargs`
      -- 
      -- Wakeup the event loop and call the async handle's callback.
      -- 
      -- @return `0` or `fail`
      -- 
      -- **Note**: It's safe to call this function from any thread. The callback will be
      -- called on the loop thread.
      -- 
      -- **Warning**: libuv will coalesce calls to `uv.async_send(async)`, that is, not
      -- every call to it will yield an execution of the callback. For example: if
      -- `uv.async_send()` is called 5 times in a row before the callback is called, the
      -- callback will only be called once. If `uv.async_send()` is called again after
      -- the callback was called, it will be called again.
      -- 
      send:function(Async, ...:any):integer, string
   end

   --- ### `uv.new_async([callback])`
   -- 
   -- @param `callback`: `callable` or `nil`
   -- @param `...`: `threadargs` passed to/from `uv.async_send(async, ...)`
   -- 
   -- Creates and initializes a new `uv_async_t`. Returns the Lua userdata wrapping
   -- it. A `nil` callback is allowed.
   -- 
   -- @return `uv_async_t userdata` or `fail`
   -- 
   -- **Note**: Unlike other handle initialization functions, this immediately starts
   -- the handle.
   -- 
   new_async:function(callback:function()):Async, string

   --- ## `uv_poll_t` — Poll handle
   -- 
   -- [`uv_poll_t`]: #uv_poll_t--poll-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- Poll handles are used to watch file descriptors for readability and writability,
   -- similar to the purpose of [poll(2)](http://linux.die.net/man/2/poll).
   -- 
   -- The purpose of poll handles is to enable integrating external libraries that
   -- rely on the event loop to signal it about the socket status changes, like c-ares
   -- or libssh2. Using `uv_poll_t` for any other purpose is not recommended;
   -- `uv_tcp_t`, `uv_udp_t`, etc. provide an implementation that is faster and more
   -- scalable than what can be achieved with `uv_poll_t`, especially on Windows.
   -- 
   -- It is possible that poll handles occasionally signal that a file descriptor is
   -- readable or writable even when it isn't. The user should therefore always be
   -- prepared to handle EAGAIN or equivalent when it attempts to read from or write
   -- to the fd.
   -- 
   -- It is not okay to have multiple active poll handles for the same socket, this
   -- can cause libuv to busyloop or otherwise malfunction.
   -- 
   -- The user should not close a file descriptor while it is being polled by an
   -- active poll handle. This can cause the handle to report an error, but it might
   -- also start polling another socket. However the fd can be safely closed
   -- immediately after a call to `uv.poll_stop()` or `uv.close()`.
   -- 
   -- **Note**: On windows only sockets can be polled with poll handles. On Unix any
   -- file descriptor that would be accepted by poll(2) can be used.
   -- 
   interface Poll is Handle where (self as Handle):get_type() == "poll"
      --- ### `uv.poll_start(poll, events, callback)`
      -- 
      -- > method form `poll:start(events, callback)`
      -- 
      -- @param `poll`: `uv_poll_t userdata`
      -- @param `events`: `string` or `nil` (default: `"rw"`)
      -- @param `callback`: `callable`
      -- @param `err`: `nil` or `string`
      -- @param `events`: `string` or `nil`
      -- 
      -- Starts polling the file descriptor. `events` are: `"r"`, `"w"`, `"rw"`, `"d"`,
      -- `"rd"`, `"wd"`, `"rwd"`, `"p"`, `"rp"`, `"wp"`, `"rwp"`, `"dp"`, `"rdp"`,
      -- `"wdp"`, or `"rwdp"` where `r` is `READABLE`, `w` is `WRITABLE`, `d` is
      -- `DISCONNECT`, and `p` is `PRIORITIZED`. As soon as an event is detected
      -- the callback will be called with status set to 0, and the detected events set on
      -- the events field.
      -- 
      -- The user should not close the socket while the handle is active. If the user
      -- does that anyway, the callback may be called reporting an error status, but this
      -- is not guaranteed.
      -- 
      -- @return `0` or `fail`
      -- 
      -- **Note** Calling `uv.poll_start()` on a handle that is already active is fine.
      -- Doing so will update the events mask that is being watched for.
      -- 
      start:function(Poll, events:string, callback:function()):integer, string

      --- ### `uv.poll_stop(poll)`
      -- 
      -- > method form `poll:stop()`
      -- 
      -- @param `poll`: `uv_poll_t userdata`
      -- 
      -- Stop polling the file descriptor, the callback will no longer be called.
      -- 
      -- @return `0` or `fail`
      -- 
      stop:function(Poll):integer, string
   end

   --- ### `uv.new_poll(fd)`
   -- 
   -- @param `fd`: `integer`
   -- 
   -- Initialize the handle using a file descriptor.
   -- 
   -- The file descriptor is set to non-blocking mode.
   -- 
   -- @return `uv_poll_t userdata` or `fail`
   -- 
   new_poll:function(fd:integer):Poll, string

   --- ### `uv.new_socket_poll(fd)`
   -- 
   -- @param `fd`: `integer`
   -- 
   -- Initialize the handle using a socket descriptor. On Unix this is identical to
   -- `uv.new_poll()`. On windows it takes a SOCKET handle.
   -- 
   -- The socket is set to non-blocking mode.
   -- 
   -- @return `uv_poll_t userdata` or `fail`
   -- 
   new_socket_poll:function(fd:integer):Poll, string

   --- ## `uv_signal_t` — Signal handle
   -- 
   -- [`uv_signal_t`]: #uv_signal_t--signal-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- Signal handles implement Unix style signal handling on a per-event loop bases.
   -- 
   -- **Windows Notes:**
   -- 
   -- Reception of some signals is emulated on Windows:
   --   - SIGINT is normally delivered when the user presses CTRL+C. However, like on
   --   Unix, it is not generated when terminal raw mode is enabled.
   --   - SIGBREAK is delivered when the user pressed CTRL + BREAK.
   --   - SIGHUP is generated when the user closes the console window. On SIGHUP the
   --   program is given approximately 10 seconds to perform cleanup. After that
   --   Windows will unconditionally terminate it.
   --   - SIGWINCH is raised whenever libuv detects that the console has been resized.
   --   SIGWINCH is emulated by libuv when the program uses a uv_tty_t handle to write
   --   to the console. SIGWINCH may not always be delivered in a timely manner; libuv
   --   will only detect size changes when the cursor is being moved. When a readable
   --   [`uv_tty_t`] handle is used in raw mode, resizing the console buffer will
   --   also trigger a SIGWINCH signal.
   --   - Watchers for other signals can be successfully created, but these signals
   --   are never received. These signals are: SIGILL, SIGABRT, SIGFPE, SIGSEGV,
   --   SIGTERM and SIGKILL.
   --   - Calls to raise() or abort() to programmatically raise a signal are not
   --   detected by libuv; these will not trigger a signal watcher.
   -- 
   -- **Unix Notes:**
   -- 
   --   - SIGKILL and SIGSTOP are impossible to catch.
   --   - Handling SIGBUS, SIGFPE, SIGILL or SIGSEGV via libuv results into undefined
   --   behavior.
   --   - SIGABRT will not be caught by libuv if generated by abort(), e.g. through
   --   assert().
   --   - On Linux SIGRT0 and SIGRT1 (signals 32 and 33) are used by the NPTL pthreads
   --   library to manage threads. Installing watchers for those signals will lead to
   --   unpredictable behavior and is strongly discouraged. Future versions of libuv
   --   may simply reject them.
   -- 
   -- ```lua
   -- -- Create a new signal handler
   -- local signal = uv.new_signal()
   -- -- Define a handler function
   -- uv.signal_start(signal, "sigint", function(signal)
   --   print("got " .. signal .. ", shutting down")
   --   os.exit(1)
   -- end)
   -- ```
   -- 
   interface Signal is Handle where (self as Handle):get_type() == "signal"
      --- ### `uv.signal_start(signal, signum, callback)`
      -- 
      -- > method form `signal:start(signum, callback)`
      -- 
      -- @param `signal`: `uv_signal_t userdata`
      -- @param `signum`: `integer` or `string`
      -- @param `callback`: `callable`
      -- @param `signum`: `string`
      -- 
      -- Start the handle with the given callback, watching for the given signal.
      -- 
      -- @return `0` or `fail`
      -- 
      start:function(Signal, signum:integer, callback:function()):integer, string

      --- ### `uv.signal_start_oneshot(signal, signum, callback)`
      -- 
      -- > method form `signal:start_oneshot(signum, callback)`
      -- 
      -- @param `signal`: `uv_signal_t userdata`
      -- @param `signum`: `integer` or `string`
      -- @param `callback`: `callable`
      -- @param `signum`: `string`
      -- 
      -- Same functionality as `uv.signal_start()` but the signal handler is reset the moment the signal is received.
      -- 
      -- @return `0` or `fail`
      -- 
      start_oneshot:function(Signal, signum:integer, callback:function()):integer, string

      --- ### `uv.signal_stop(signal)`
      -- 
      -- > method form `signal:stop()`
      -- 
      -- @param `signal`: `uv_signal_t userdata`
      -- 
      -- Stop the handle, the callback will no longer be called.
      -- 
      -- @return `0` or `fail`
      -- 
      -- ## `uv_process_t` — Process handle
      -- 
      -- [`uv_process_t`]: #uv_process_t--process-handle
      -- 
      -- > [`uv_handle_t`] functions also apply.
      -- 
      -- Process handles will spawn a new process and allow the user to control it and
      -- establish communication channels with it using streams.
      -- 
      stop:function(Signal):integer, string
   end

   --- ### `uv.new_signal()`
   -- 
   -- Creates and initializes a new `uv_signal_t`. Returns the Lua userdata wrapping
   -- it.
   -- 
   -- @return `uv_signal_t userdata` or `fail`
   -- 
   new_signal:function():Signal, string

   interface Process is Handle where (self as Handle):get_type() == "process"
      --- ### `uv.process_kill(process, signum)`
      -- 
      -- > method form `process:kill(signum)`
      -- 
      -- @param `process`: `uv_process_t userdata`
      -- @param `signum`: `integer` or `string` or `nil` (default: `sigterm`)
      -- 
      -- Sends the specified signal to the given process handle. Check the documentation
      -- on `uv_signal_t` for signal support, specially on Windows.
      -- 
      -- @return `0` or `fail`
      -- 
      kill:function(signum:integer):integer, string

      --- ### `uv.process_get_pid(process)`
      -- 
      -- > method form `process:get_pid()`
      -- 
      -- @param `process`: `uv_process_t userdata`
      -- 
      -- Returns the handle's pid.
      -- 
      -- @return `integer`
      -- 
      get_pid:function():integer
   end

   --- ### `uv.kill(pid, signum)`
   -- 
   -- @param `pid`: `integer`
   -- @param `signum`: `integer` or `string` or `nil` (default: `sigterm`)
   -- 
   -- Sends the specified signal to the given PID. Check the documentation on
   -- `uv_signal_t` for signal support, specially on Windows.
   -- 
   -- @return `0` or `fail`
   kill:function(pid:integer, signum:integer|string):integer, string

   --- ### `uv.disable_stdio_inheritance()`
   -- 
   -- Disables inheritance for file descriptors / handles that this process inherited
   -- from its parent. The effect is that child processes spawned by this process
   -- don't accidentally inherit these handles.
   -- 
   -- It is recommended to call this function as early in your program as possible,
   -- before the inherited file descriptors can be closed or duplicated.
   -- 
   -- @return Nothing.
   -- 
   -- **Note:** This function works on a best-effort basis: there is no guarantee that
   -- libuv can discover all file descriptors that were inherited. In general it does
   -- a better job on Windows than it does on Unix.
   -- 
   disable_stdio_inheritance:function()

   record SpawnOptions
      -- Use of any here means type is unclear from docs
      args:{string}
      stdio:any
      env:any
      cwd:string
      uid:any
      gid:any
      verbatim:boolean
      detached:boolean
      hide:boolean
   end

   --- ### `uv.spawn(path, options, on_exit)`
   -- 
   -- @param `path`: `string`
   -- @param `options`: `table` (see below)
   -- @param `on_exit`: `callable`
   -- @param - `code`: `integer`
   -- @param - `signal`: `integer`
   -- 
   -- Initializes the process handle and starts the process. If the process is
   -- successfully spawned, this function will return the handle and pid of the child
   -- process.
   -- 
   -- Possible reasons for failing to spawn would include (but not be limited to) the
   -- file to execute not existing, not having permissions to use the setuid or setgid
   -- specified, or not having enough memory to allocate for the new process.
   -- 
   -- ```lua
   -- local stdin = uv.new_pipe()
   -- local stdout = uv.new_pipe()
   -- local stderr = uv.new_pipe()
   -- 
   -- print("stdin", stdin)
   -- print("stdout", stdout)
   -- print("stderr", stderr)
   -- 
   -- local handle, pid = uv.spawn("cat", {
   --   stdio = {stdin, stdout, stderr}
   -- }, function(code, signal) -- on exit
   --   print("exit code", code)
   --   print("exit signal", signal)
   -- end)
   -- 
   -- print("process opened", handle, pid)
   -- 
   -- uv.read_start(stdout, function(err, data)
   --   assert(not err, err)
   --   if data then
   --     print("stdout chunk", stdout, data)
   --   else
   --     print("stdout end", stdout)
   --   end
   -- end)
   -- 
   -- uv.read_start(stderr, function(err, data)
   --   assert(not err, err)
   --   if data then
   --     print("stderr chunk", stderr, data)
   --   else
   --     print("stderr end", stderr)
   --   end
   -- end)
   -- 
   -- uv.write(stdin, "Hello World")
   -- 
   -- uv.shutdown(stdin, function()
   --   print("stdin shutdown", stdin)
   --   uv.close(handle, function()
   --     print("process closed", handle, pid)
   --   end)
   -- end)
   -- ```
   -- 
   -- The `options` table accepts the following fields:
   -- 
   --   - `options.args` - Command line arguments as a list of strings. The first
   --   string should *not* be the path to the program, since that is already
   --   provided via `path`. On Windows, this uses CreateProcess which concatenates
   --   the arguments into a string. This can cause some strange errors
   --   (see `options.verbatim` below for Windows).
   --   - `options.stdio` - Set the file descriptors that will be made available to
   --   the child process. The convention is that the first entries are stdin, stdout,
   --   and stderr. (**Note**: On Windows, file descriptors after the third are
   --   available to the child process only if the child processes uses the MSVCRT
   --   runtime.)
   --   - `options.env` - Set environment variables for the new process.
   --   - `options.cwd` - Set the current working directory for the sub-process.
   --   - `options.uid` - Set the child process' user id.
   --   - `options.gid` - Set the child process' group id.
   --   - `options.verbatim` - If true, do not wrap any arguments in quotes, or
   --   perform any other escaping, when converting the argument list into a command
   --   line string. This option is only meaningful on Windows systems. On Unix it is
   --   silently ignored.
   --   - `options.detached` - If true, spawn the child process in a detached state -
   --   this will make it a process group leader, and will effectively enable the
   --   child to keep running after the parent exits. Note that the child process
   --   will still keep the parent's event loop alive unless the parent process calls
   --   `uv.unref()` on the child's process handle.
   --   - `options.hide` - If true, hide the subprocess console window that would
   --   normally be created. This option is only meaningful on Windows systems. On
   --   Unix it is silently ignored.
   -- 
   -- The `options.stdio` entries can take many shapes.
   -- 
   --   - If they are numbers, then the child process inherits that same zero-indexed
   --   fd from the parent process.
   --   - If `uv_stream_t` handles are passed in, those are used as a read-write pipe
   --   or inherited stream depending if the stream has a valid fd.
   --   - Including `nil` placeholders means to ignore that fd in the child process.
   -- 
   -- When the child process exits, `on_exit` is called with an exit code and signal.
   -- 
   -- @return `uv_process_t userdata`, `integer`
   -- 
   spawn:function(path:string, options:SpawnOptions, on_exit:function(exit_status: integer, term_signal: integer)):Process, integer

   --- ## `uv_stream_t` — Stream handle
   -- 
   -- [`uv_stream_t`]: #uv_stream_t--stream-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- Stream handles provide an abstraction of a duplex communication channel.
   -- [`uv_stream_t`] is an abstract type, libuv provides 3 stream implementations
   -- in the form of [`uv_tcp_t`], [`uv_pipe_t`] and [`uv_tty_t`].
   -- 
   interface Stream is Handle where (self as Handle):get_type() == "stream"
      --- ### `uv.shutdown(stream, [callback])`
      -- 
      -- > method form `stream:shutdown([callback])`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `callback`: `callable` or `nil`
      -- @param - `err`: `nil` or `string`
      -- 
      -- Shutdown the outgoing (write) side of a duplex stream. It waits for pending
      -- write requests to complete. The callback is called after shutdown is complete.
      -- 
      -- @return `uv_shutdown_t userdata` or `fail`
      -- 
      shutdown:function(Stream, callback:function())

      --- ### `uv.listen(stream, backlog, callback)`
      -- 
      -- > method form `stream:listen(backlog, callback)`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `backlog`: `integer`
      -- @param `callback`: `callable`
      -- @param - `err`: `nil` or `string`
      -- 
      -- Start listening for incoming connections. `backlog` indicates the number of
      -- connections the kernel might queue, same as `listen(2)`. When a new incoming
      -- connection is received the callback is called.
      -- 
      -- @return `0` or `fail`
      -- 
      listen:function(Stream, backlog:integer, callback:function()):integer, string

      --- ### `uv.accept(stream, client_stream)`
      -- 
      -- > method form `stream:accept(client_stream)`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `client_stream`: `userdata` for sub-type of `uv_stream_t`
      -- 
      -- This call is used in conjunction with `uv.listen()` to accept incoming
      -- connections. Call this function after receiving a callback to accept the
      -- connection.
      -- 
      -- When the connection callback is called it is guaranteed that this function
      -- will complete successfully the first time. If you attempt to use it more than
      -- once, it may fail. It is suggested to only call this function once per
      -- connection call.
      -- 
      -- @return `0` or `fail`
      -- 
      -- ```lua
      -- server:listen(128, function (err)
      --   local client = uv.new_tcp()
      --   server:accept(client)
      -- end)
      -- ```
      accept:function(Stream, client_stream:Stream):integer, string

      --- ### `uv.read_start(stream, callback)`
      -- 
      -- > method form `stream:read_start(callback)`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `callback`: `callable`
      -- @param - `err`: `nil` or `string`
      -- @param - `data`: `string` or `nil`
      -- 
      -- Read data from an incoming stream. The callback will be made several times until
      -- there is no more data to read or `uv.read_stop()` is called. When we've reached
      -- EOF, `data` will be `nil`.
      -- 
      -- @return `0` or `fail`
      -- 
      -- ```lua
      -- stream:read_start(function (err, chunk)
      --   if err then
      --     -- handle read error
      --   elseif chunk then
      --     -- handle data
      --   else
      --     -- handle disconnect
      --   end
      -- end)
      -- ```
      -- 
      read_start:function(Stream, callback:function(err:string, data:string))

      --- ### `uv.read_stop(stream)`
      -- 
      -- > method form `stream:read_stop()`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- 
      -- Stop reading data from the stream. The read callback will no longer be called.
      -- 
      -- This function is idempotent and may be safely called on a stopped stream.
      -- 
      -- @return `0` or `fail`
      -- 
      read_stop:function(Stream)

      --- ### `uv.write(stream, data, [callback])`
      -- 
      -- > method form `stream:write(data, [callback])`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `data`: `buffer`
      -- @param `callback`: `callable` or `nil`
      -- @param - `err`: `nil` or `string`
      -- 
      -- Write data to stream.
      -- 
      -- `data` can either be a Lua string or a table of strings. If a table is passed
      -- in, the C backend will use writev to send all strings in a single system call.
      -- 
      -- The optional `callback` is for knowing when the write is complete.
      -- 
      -- @return `uv_write_t userdata` or `fail`
      -- 
      write:function(Stream, data:any, callback:function()):any, string

      --- ### `uv.write2(stream, data, send_handle, [callback])`
      -- 
      -- > method form `stream:write2(data, send_handle, [callback])`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `data`: `buffer`
      -- @param `send_handle`: `userdata` for sub-type of `uv_stream_t`
      -- @param `callback`: `callable` or `nil`
      -- @param - `err`: `nil` or `string`
      -- 
      -- Extended write function for sending handles over a pipe. The pipe must be
      -- initialized with `ipc` option `true`.
      -- 
      -- @return `uv_write_t userdata` or `fail`
      -- 
      -- **Note:** `send_handle` must be a TCP socket or pipe, which is a server or a
      -- connection (listening or connected state). Bound sockets or pipes will be
      -- assumed to be servers.
      -- 
      write2:function(Stream, data:any, send_handle:Stream, callback:function())

      --- ### `uv.try_write(stream, data)`
      -- 
      -- > method form `stream:try_write(data)`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `data`: `buffer`
      -- 
      -- Same as `uv.write()`, but won't queue a write request if it can't be completed
      -- immediately.
      -- 
      -- Will return number of bytes written (can be less than the supplied buffer size).
      -- 
      -- @return `integer` or `fail`
      -- 
      try_write:function(Stream, data:any):integer, string

      --- ### `uv.try_write2(stream, data, send_handle)`
      -- 
      -- > method form `stream:try_write2(data, send_handle)`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `data`: `buffer`
      -- @param `send_handle`: `userdata` for sub-type of `uv_stream_t`
      -- 
      -- Like `uv.write2()`, but with the properties of `uv.try_write()`. Not supported on Windows, where it returns `UV_EAGAIN`.
      -- 
      -- Will return number of bytes written (can be less than the supplied buffer size).
      -- 
      -- @return `integer` or `fail`
      -- 
      try_write2:function(Stream, data:any, send_handle:Stream):integer, string

      --- ### `uv.is_readable(stream)`
      -- 
      -- > method form `stream:is_readable()`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- 
      -- Returns `true` if the stream is readable, `false` otherwise.
      -- 
      -- @return `boolean`
      -- 
      is_readable:function(Stream):boolean

      --- ### `uv.is_writable(stream)`
      -- 
      -- > method form `stream:is_writable()`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- 
      -- Returns `true` if the stream is writable, `false` otherwise.
      -- 
      -- @return `boolean`
      -- 
      is_writable:function(Stream):boolean

      --- ### `uv.stream_set_blocking(stream, blocking)`
      -- 
      -- > method form `stream:set_blocking(blocking)`
      -- 
      -- @param `stream`: `userdata` for sub-type of `uv_stream_t`
      -- @param `blocking`: `boolean`
      -- 
      -- Enable or disable blocking mode for a stream.
      -- 
      -- When blocking mode is enabled all writes complete synchronously. The interface
      -- remains unchanged otherwise, e.g. completion or failure of the operation will
      -- still be reported through a callback which is made asynchronously.
      -- 
      -- @return `0` or `fail`
      -- 
      -- **Warning**: Relying too much on this API is not recommended. It is likely to
      -- change significantly in the future. Currently this only works on Windows and
      -- only for `uv_pipe_t` handles. Also libuv currently makes no ordering guarantee
      -- when the blocking mode is changed after write requests have already been
      -- submitted. Therefore it is recommended to set the blocking mode immediately
      -- after opening or creating the stream.
      -- 
      set_blocking:function(Stream, blocking:boolean):integer, string

      --- ### `uv.stream_get_write_queue_size()`
      -- 
      -- > method form `stream:get_write_queue_size()`
      -- 
      -- Returns the stream's write queue size.
      -- 
      -- @return `integer`
      get_write_queue_size:function(Stream):integer
   end

   --- ## `uv_tcp_t` — TCP handle
   -- 
   -- [`uv_tcp_t`]: #uv_tcp_t--tcp-handle
   -- 
   -- > [`uv_handle_t`] and [`uv_stream_t`] functions also apply.
   -- 
   -- TCP handles are used to represent both TCP streams and servers.
   -- 
   interface Tcp is Stream where (self as Stream):get_type() == "tcp"
      --- ### `uv.tcp_open(tcp, sock)`
      -- 
      -- > method form `tcp:open(sock)`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- @param `sock`: `integer`
      -- 
      -- Open an existing file descriptor or SOCKET as a TCP handle.
      -- 
      -- @return `0` or `fail`
      -- 
      -- **Note:** The passed file descriptor or SOCKET is not checked for its type, but it's required that it represents a valid stream socket.
      -- 
      open:function(Tcp, sock:integer):integer, string

      --- ### `uv.tcp_nodelay(tcp, enable)`
      -- 
      -- > method form `tcp:nodelay(enable)`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- @param `enable`: `boolean`
      -- 
      -- Enable / disable Nagle's algorithm.
      -- 
      -- @return `0` or `fail`
      -- 
      nodelay:function(Tcp, enable:boolean):integer, string

      --- ### `uv.tcp_keepalive(tcp, enable, [delay])`
      -- 
      -- > method form `tcp:keepalive(enable, [delay])`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- @param `enable`: `boolean`
      -- @param `delay`: `integer` or `nil`
      -- 
      -- Enable / disable TCP keep-alive. `delay` is the initial delay in seconds,
      -- ignored when enable is `false`.
      -- 
      -- @return `0` or `fail`
      -- 
      keepalive:function(Tcp, enable:boolean, delay:integer):integer, string

      --- ### `uv.tcp_simultaneous_accepts(tcp, enable)`
      -- 
      -- > method form `tcp:simultaneous_accepts(enable)`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- @param `enable`: `boolean`
      -- 
      -- Enable / disable simultaneous asynchronous accept requests that are queued by
      -- the operating system when listening for new TCP connections.
      -- 
      -- This setting is used to tune a TCP server for the desired performance. Having
      -- simultaneous accepts can significantly improve the rate of accepting connections
      -- (which is why it is enabled by default) but may lead to uneven load distribution
      -- in multi-process setups.
      -- 
      -- @return `0` or `fail`
      -- 
      simultaneous_accepts:function(Tcp, enable:boolean):integer, string

      --- ### `uv.tcp_bind(tcp, host, port, [flags])`
      -- 
      -- > method form `tcp:bind(host, port, [flags])`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- @param `host`: `string`
      -- @param `port`: `integer`
      -- @param `flags`: `table` or `nil`
      -- @param - `ipv6only`: `boolean`
      -- 
      -- Bind the handle to an host and port. `host` should be an IP address and
      -- not a domain name. Any `flags` are set with a table with field `ipv6only`
      -- equal to `true` or `false`.
      -- 
      -- When the port is already taken, you can expect to see an `EADDRINUSE` error
      -- from either `uv.tcp_bind()`, `uv.listen()` or `uv.tcp_connect()`. That is, a
      -- successful call to this function does not guarantee that the call to `uv.listen()`
      -- or `uv.tcp_connect()` will succeed as well.
      -- 
      -- Use a port of `0` to let the OS assign an ephemeral port.  You can look it up
      -- later using `uv.tcp_getsockname()`.
      -- 
      -- @return `0` or `fail`
      -- 
      bind:function(Tcp, host:string, port:integer, flags:{string:any}):integer, string

      --- ### `uv.tcp_getpeername(tcp)`
      -- 
      -- > method form `tcp:getpeername()`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- 
      -- Get the address of the peer connected to the handle.
      -- 
      -- @return `table` or `fail`
      -- - `ip` : `string`
      -- - `family` : `string`
      -- - `port` : `integer`
      -- 
      getpeername:function(Tcp):{string:any}, string

      --- ### `uv.tcp_getsockname(tcp)`
      -- 
      -- > method form `tcp:getsockname()`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- 
      -- Get the current address to which the handle is bound.
      -- 
      -- @return `table` or `fail`
      -- - `ip` : `string`
      -- - `family` : `string`
      -- - `port` : `integer`
      -- 
      getsockname:function(Tcp):{string:any}, string

      --- ### `uv.tcp_connect(tcp, host, port, callback)`
      -- 
      -- > method form `tcp:connect(host, port, callback)`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- @param `host`: `string`
      -- @param `port`: `integer`
      -- @param `callback`: `callable`
      -- @param  - `err`: `nil` or `string`
      -- 
      -- Establish an IPv4 or IPv6 TCP connection.
      -- 
      -- @return `uv_connect_t userdata` or `fail`
      -- 
      -- ```lua
      -- local client = uv.new_tcp()
      -- client:connect("127.0.0.1", 8080, function (err)
      --   -- check error and carry on.
      -- end)
      -- ```
      -- 
      connect:function(Tcp, host:string, port:integer, callback:function()):any, string

      --- ### `uv.tcp_write_queue_size(tcp)`
      -- 
      -- > method form `tcp:write_queue_size()`
      -- 
      -- **Deprecated:** Please use `uv.stream_get_write_queue_size()` instead.
      -- 
      write_queue_size:function()

      --- ### `uv.tcp_close_reset([callback])`
      -- 
      -- > method form `tcp:close_reset([callback])`
      -- 
      -- @param `tcp`: `uv_tcp_t userdata`
      -- @param `callback`: `callable` or `nil`
      -- 
      -- Resets a TCP connection by sending a RST packet. This is accomplished by setting
      -- the SO_LINGER socket option with a linger interval of zero and then calling
      -- `uv.close()`. Due to some platform inconsistencies, mixing of `uv.shutdown()`
      -- and `uv.tcp_close_reset()` calls is not allowed.
      -- 
      -- @return `0` or `fail`
      -- 
      close_reset:function(callback:function())
   end

   --- ### `uv.new_tcp([flags])`
   -- 
   -- @param `flags`: `string` or `nil`
   -- 
   -- Creates and initializes a new `uv_tcp_t`. Returns the Lua userdata wrapping it.
   -- Flags may be a family string: `"unix"`, `"inet"`, `"inet6"`, `"ipx"`,
   -- `"netlink"`, `"x25"`, `"ax25"`, `"atmpvc"`, `"appletalk"`, or `"packet"`.
   -- 
   -- @return `uv_tcp_t userdata` or `fail`
   -- 
   new_tcp:function(flags:string):Tcp

   --- ### `uv.socketpair([socktype], [protocol], [flags1], [flags2])`
   -- 
   -- @param `socktype`: `string`, `integer` or `nil` (default: `stream`)
   -- @param `protocol`: `string`, `integer` or `nil` (default: 0)
   -- @param `flags1`: `table` or `nil`
   -- @param - `nonblock`: `boolean` (default: `false`)
   -- @param `flags2`: `table` or `nil`
   -- @param - `nonblock`: `boolean` (default: `false`)
   -- 
   -- Create a pair of connected sockets with the specified properties. The resulting handles can be passed to `uv.tcp_open`, used with `uv.spawn`, or for any other purpose.
   -- 
   -- When specified as a string, `socktype` must be one of `"stream"`, `"dgram"`, `"raw"`,
   -- `"rdm"`, or `"seqpacket"`.
   -- 
   -- When `protocol` is set to 0 or nil, it will be automatically chosen based on the socket's domain and type. When `protocol` is specified as a string, it will be looked up using the `getprotobyname(3)` function (examples: `"ip"`, `"icmp"`, `"tcp"`, `"udp"`, etc).
   -- 
   -- Flags:
   --  - `nonblock`: Opens the specified socket handle for `OVERLAPPED` or `FIONBIO`/`O_NONBLOCK` I/O usage. This is recommended for handles that will be used by libuv, and not usually recommended otherwise.
   -- 
   -- Equivalent to `socketpair(2)` with a domain of `AF_UNIX`.
   -- 
   -- @return `table` or `fail`
   -- - `[1, 2]` : `integer` (file descriptor)
   -- 
   -- ```lua
   -- -- Simple read/write with tcp
   -- local fds = uv.socketpair(nil, nil, {nonblock=true}, {nonblock=true})
   -- 
   -- local sock1 = uv.new_tcp()
   -- sock1:open(fds[1])
   -- 
   -- local sock2 = uv.new_tcp()
   -- sock2:open(fds[2])
   -- 
   -- sock1:write("hello")
   -- sock2:read_start(function(err, chunk)
   --   assert(not err, err)
   --   print(chunk)
   -- end)
   -- ```
   -- 
   socketpair:function(socktype:string|integer, protocol:string|integer, flags1:{string:any}, flags2:{string:any}):{string:any}, string

   --- ## `uv_pipe_t` — Pipe handle
   -- 
   -- [`uv_pipe_t`]: #uv_pipe_t--pipe-handle
   -- 
   -- > [`uv_handle_t`] and [`uv_stream_t`] functions also apply.
   -- 
   -- Pipe handles provide an abstraction over local domain sockets on Unix and named pipes on Windows.
   -- 
   -- ```lua
   -- local pipe = uv.new_pipe(false)
   -- 
   -- pipe:bind('/tmp/sock.test')
   -- 
   -- pipe:listen(128, function()
   --   local client = uv.new_pipe(false)
   --   pipe:accept(client)
   --   client:write("hello!\n")
   --   client:close()
   -- end)
   -- ```
   -- 
   interface Pipe is Stream where (self as Stream):get_type() == "pipe"
      --- ### `uv.pipe_open(pipe, fd)`
      -- 
      -- > method form `pipe:open(fd)`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- @param `fd`: `integer`
      -- 
      -- Open an existing file descriptor or [`uv_handle_t`] as a pipe.
      -- 
      -- @return `0` or `fail`
      -- 
      -- **Note**: The file descriptor is set to non-blocking mode.
      -- 
      open:function(Pipe, fd:integer):integer, string

      --- ### `uv.pipe_bind(pipe, name)`
      -- 
      -- > method form `pipe:bind(name)`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- @param `name`: `string`
      -- 
      -- Bind the pipe to a file path (Unix) or a name (Windows).
      -- 
      -- @return `0` or `fail`
      -- 
      -- **Note**: Paths on Unix get truncated to sizeof(sockaddr_un.sun_path) bytes,
      -- typically between 92 and 108 bytes.
      -- 
      bind:function(Pipe, name:string):integer, string

      --- ### `uv.pipe_connect(pipe, name, [callback])`
      -- 
      -- > method form `pipe:connect(name, [callback])`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- @param `name`: `string`
      -- @param `callback`: `callable` or `nil`
      -- @param - `err`: `nil` or `string`
      -- 
      -- Connect to the Unix domain socket or the named pipe.
      -- 
      -- @return `uv_connect_t userdata` or `fail`
      -- 
      -- **Note**: Paths on Unix get truncated to sizeof(sockaddr_un.sun_path) bytes,
      -- typically between 92 and 108 bytes.
      -- 
      connect:function(Pipe, name:string, callback:function()):any, string

      --- ### `uv.pipe_getsockname(pipe)`
      -- 
      -- > method form `pipe:getsockname()`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- 
      -- Get the name of the Unix domain socket or the named pipe.
      -- 
      -- @return `string` or `fail`
      -- 
      getsockname:function(Pipe):string, string

      --- ### `uv.pipe_getpeername(pipe)`
      -- 
      -- > method form `pipe:getpeername()`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- 
      -- Get the name of the Unix domain socket or the named pipe to which the handle is
      -- connected.
      -- 
      -- @return `string` or `fail`
      -- 
      getpeername:function(Pipe):string, string

      --- ### `uv.pipe_pending_instances(pipe, count)`
      -- 
      -- > method form `pipe:pending_instances(count)`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- @param `count`: `integer`
      -- 
      -- Set the number of pending pipe instance handles when the pipe server is waiting
      -- for connections.
      -- 
      -- @return Nothing.
      -- 
      -- **Note**: This setting applies to Windows only.
      -- 
      pending_instances:function(Pipe, count:integer)

      --- ### `uv.pipe_pending_count(pipe)`
      -- 
      -- > method form `pipe:pending_count()`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- 
      -- Returns the pending pipe count for the named pipe.
      -- 
      -- @return `integer`
      -- 
      pending_count:function(Pipe):integer

      --- ### `uv.pipe_pending_type(pipe)`
      -- 
      -- > method form `pipe:pending_type()`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- 
      -- Used to receive handles over IPC pipes.
      -- 
      -- First - call `uv.pipe_pending_count()`, if it's > 0 then initialize a handle of
      -- the given type, returned by `uv.pipe_pending_type()` and call
      -- `uv.accept(pipe, handle)`.
      -- 
      -- @return `string`
      -- 
      pending_type:function(Pipe):string

      --- ### `uv.pipe_chmod(pipe, flags)`
      -- 
      -- > method form `pipe:chmod(flags)`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- @param `flags`: `string`
      -- 
      -- Alters pipe permissions, allowing it to be accessed from processes run by different users.
      -- Makes the pipe writable or readable by all users. `flags` are: `"r"`, `"w"`, `"rw"`, or `"wr"`
      -- where `r` is `READABLE` and `w` is `WRITABLE`. This function is blocking.
      -- 
      -- @return `0` or `fail`
      -- 
      chmod:function(Pipe, flags:string):integer, string

      --- ### `uv.pipe_bind2(pipe, name, [flags])`
      -- 
      -- > method form `pipe:bind2(name, [flags])`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- @param `name`: `string`
      -- @param `flags`: `integer` or `table` or `nil`(default: 0)
      -- 
      -- Bind the pipe to a file path (Unix) or a name (Windows).
      -- 
      -- `Flags`:
      -- 
      -- - If `type(flags)` is `number`, it must be `0` or `uv.constants.PIPE_NO_TRUNCATE`.
      -- - If `type(flags)` is `table`, it must be `{}` or `{ no_trunate = true|false }`.
      -- - If `type(flags)` is `nil`, it use default value `0`.
      -- - Returns `EINVAL` for unsupported flags without performing the bind operation.
      -- 
      -- Supports Linux abstract namespace sockets. namelen must include the leading '\0' byte but not the trailing nul byte.
      -- 
      -- @return `0` or `fail`
      -- 
      -- **Note**:
      -- 
      -- 1. Paths on Unix get truncated to sizeof(sockaddr_un.sun_path) bytes,
      -- typically between 92 and 108 bytes.
      -- 2. New in version 1.46.0.
      -- 
      bind2:function(Pipe, name:string, flags:any):integer, string

      --- ### `uv.pipe_connect2(pipe, name, [flags], [callback])`
      -- 
      -- > method form `pipe:connect2(name, [flags], [callback])`
      -- 
      -- @param `pipe`: `uv_pipe_t userdata`
      -- @param `name`: `string`
      -- @param `flags`: `integer` or `table` or `nil`(default: 0)
      -- @param `callback`: `callable` or `nil`
      -- @param - `err`: `nil` or `string`
      -- 
      -- Connect to the Unix domain socket or the named pipe.
      -- 
      -- `Flags`:
      -- 
      -- - If `type(flags)` is `number`, it must be `0` or `uv.constants.PIPE_NO_TRUNCATE`.
      -- - If `type(flags)` is `table`, it must be `{}` or `{ no_trunate = true|false }`.
      -- - If `type(flags)` is `nil`, it use default value `0`.
      -- - Returns `EINVAL` for unsupported flags without performing the bind operation.
      -- 
      -- Supports Linux abstract namespace sockets. namelen must include the leading nul byte but not the trailing nul byte.
      -- 
      -- @return `uv_connect_t userdata` or `fail`
      -- 
      -- **Note**:
      -- 
      -- 1. Paths on Unix get truncated to sizeof(sockaddr_un.sun_path) bytes,
      -- typically between 92 and 108 bytes.
      -- 2. New in version 1.46.0.
      -- 
      connect2:function(Pipe, name:string, flags:any, callback:function()):any, string
   end

   --- ### `uv.new_pipe([ipc])`
   -- 
   -- @param `ipc`: `boolean` or `nil` (default: `false`)
   -- 
   -- Creates and initializes a new `uv_pipe_t`. Returns the Lua userdata wrapping
   -- it. The `ipc` argument is a boolean to indicate if this pipe will be used for
   -- handle passing between processes.
   -- 
   -- @return `uv_pipe_t userdata` or `fail`
   -- 
   new_pipe:function(ipc:boolean):Pipe

   --- ### `uv.pipe(read_flags, write_flags)`
   -- 
   -- @param `read_flags`: `table` or `nil`
   -- @param - `nonblock`: `boolean` (default: `false`)
   -- @param `write_flags`: `table` or `nil`
   -- @param - `nonblock`: `boolean` (default: `false`)
   -- 
   -- Create a pair of connected pipe handles. Data may be written to the `write` fd and read from the `read` fd. The resulting handles can be passed to `pipe_open`, used with `spawn`, or for any other purpose.
   -- 
   -- Flags:
   --  - `nonblock`: Opens the specified socket handle for `OVERLAPPED` or `FIONBIO`/`O_NONBLOCK` I/O usage. This is recommended for handles that will be used by libuv, and not usually recommended otherwise.
   -- 
   -- Equivalent to `pipe(2)` with the `O_CLOEXEC` flag set.
   -- 
   -- @return `table` or `fail`
   -- - `read` : `integer` (file descriptor)
   -- - `write` : `integer` (file descriptor)
   -- 
   -- ```lua
   -- -- Simple read/write with pipe_open
   -- local fds = uv.pipe({nonblock=true}, {nonblock=true})
   -- 
   -- local read_pipe = uv.new_pipe()
   -- read_pipe:open(fds.read)
   -- 
   -- local write_pipe = uv.new_pipe()
   -- write_pipe:open(fds.write)
   -- 
   -- write_pipe:write("hello")
   -- read_pipe:read_start(function(err, chunk)
   --   assert(not err, err)
   --   print(chunk)
   -- end)
   -- ```
   -- 
   pipe:function(read_flags:any, write_flags:any):any

   --- ## `uv_tty_t` — TTY handle
   -- 
   -- [`uv_tty_t`]: #uv_tty_t--tty-handle
   -- 
   -- > [`uv_handle_t`] and [`uv_stream_t`] functions also apply.
   -- 
   -- TTY handles represent a stream for the console.
   -- 
   -- ```lua
   -- -- Simple echo program
   -- local stdin = uv.new_tty(0, true)
   -- local stdout = uv.new_tty(1, false)
   -- 
   -- stdin:read_start(function (err, data)
   --   assert(not err, err)
   --   if data then
   --     stdout:write(data)
   --   else
   --     stdin:close()
   --     stdout:close()
   --   end
   -- end)
   -- ```
   -- 
   interface Tty is Stream where (self as Stream):get_type() == "tty"
      --- ### `uv.tty_set_mode(tty, mode)`
      -- 
      -- > method form `tty:set_mode(mode)`
      -- 
      -- @param `tty`: `uv_tty_t userdata`
      -- @param `mode`: `integer`
      -- 
      -- Set the TTY using the specified terminal mode.
      -- 
      -- Parameter `mode` is a C enum with the following values:
      -- 
      --   - 0 - UV_TTY_MODE_NORMAL: Initial/normal terminal mode
      --   - 1 - UV_TTY_MODE_RAW: Raw input mode (On Windows, ENABLE_WINDOW_INPUT is
      --   also enabled)
      --   - 2 - UV_TTY_MODE_IO: Binary-safe I/O mode for IPC (Unix-only)
      -- 
      -- @return `0` or `fail`
      -- 
      set_mode:function(Tty, mode:integer)

      --- ### `uv.tty_get_winsize(tty)`
      -- 
      -- > method form `tty:get_winsize()`
      -- 
      -- @param `tty`: `uv_tty_t userdata`
      -- 
      -- Gets the current Window width and height.
      -- 
      -- @return `integer, integer` or `fail`
      -- 
      get_winsize:function(Tty):integer, integer | string
   end

   --- ### `uv.new_tty(fd, readable)`
   -- 
   -- @param `fd`: `integer`
   -- @param `readable`: `boolean`
   -- 
   -- Initialize a new TTY stream with the given file descriptor. Usually the file
   -- descriptor will be:
   -- 
   --  - 0 - stdin
   --  - 1 - stdout
   --  - 2 - stderr
   -- 
   -- On Unix this function will determine the path of the fd of the terminal using
   -- ttyname_r(3), open it, and use it if the passed file descriptor refers to a TTY.
   -- This lets libuv put the tty in non-blocking mode without affecting other
   -- processes that share the tty.
   -- 
   -- This function is not thread safe on systems that don’t support ioctl TIOCGPTN or TIOCPTYGNAME, for instance OpenBSD and Solaris.
   -- 
   -- @return `uv_tty_t userdata` or `fail`
   -- 
   -- **Note:** If reopening the TTY fails, libuv falls back to blocking writes.
   -- 
   new_tty:function(fd:integer, readable:boolean):Tty, string

   --- ### `uv.tty_reset_mode()`
   -- 
   -- To be called when the program exits. Resets TTY settings to default values for
   -- the next process to take over.
   -- 
   -- This function is async signal-safe on Unix platforms but can fail with error
   -- code `EBUSY` if you call it when execution is inside `uv.tty_set_mode()`.
   -- 
   -- @return `0` or `fail`
   -- 
   tty_reset_mode:function():integer, string

   --- ### `uv.tty_set_vterm_state(state)`
   -- 
   -- @param `state`: `string`
   -- 
   -- Controls whether console virtual terminal sequences are processed by libuv or
   -- console. Useful in particular for enabling ConEmu support of ANSI X3.64 and
   -- Xterm 256 colors. Otherwise Windows10 consoles are usually detected
   -- automatically. State should be one of: `"supported"` or `"unsupported"`.
   -- 
   -- This function is only meaningful on Windows systems. On Unix it is silently
   -- ignored.
   -- 
   -- @return none
   -- 
   tty_set_vterm_state:function(state:string)

   --- ### `uv.tty_get_vterm_state()`
   -- 
   -- Get the current state of whether console virtual terminal sequences are handled
   -- by libuv or the console. The return value is `"supported"` or `"unsupported"`.
   -- 
   -- This function is not implemented on Unix, where it returns `ENOTSUP`.
   -- 
   -- @return `string` or `fail`
   -- 
   tty_get_vterm_state:function():string, string

   --- ## `uv_udp_t` — UDP handle
   -- 
   -- [`uv_udp_t`]: #uv_udp_t--udp-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- UDP handles encapsulate UDP communication for both clients and servers.
   -- 
   interface Udp is Handle where (self as Handle):get_type() == "udp"
      --- ### `uv.udp_get_send_queue_size()`
      -- 
      -- > method form `udp:get_send_queue_size()`
      -- 
      -- Returns the handle's send queue size.
      -- 
      -- @return `integer`
      -- 
      get_send_queue_size:function(Udp):integer

      --- ### `uv.udp_get_send_queue_count()`
      -- 
      -- > method form `udp:get_send_queue_count()`
      -- 
      -- Returns the handle's send queue count.
      -- 
      -- @return `integer`
      -- 
      get_send_queue_count:function(Udp):integer

      --- ### `uv.udp_open(udp, fd)`
      -- 
      -- > method form `udp:open(fd)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `fd`: `integer`
      -- 
      -- Opens an existing file descriptor or Windows SOCKET as a UDP handle.
      -- 
      -- Unix only: The only requirement of the sock argument is that it follows the
      -- datagram contract (works in unconnected mode, supports sendmsg()/recvmsg(),
      -- etc). In other words, other datagram-type sockets like raw sockets or netlink
      -- sockets can also be passed to this function.
      -- 
      -- The file descriptor is set to non-blocking mode.
      -- 
      -- Note: The passed file descriptor or SOCKET is not checked for its type, but
      -- it's required that it represents a valid datagram socket.
      -- 
      -- @return `0` or `fail`
      -- 
      open:function(Udp, fd:integer):integer, string

      --- ### `uv.udp_bind(udp, host, port, [flags])`
      -- 
      -- > method form `udp:bind(host, port, [flags])`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `host`: `string`
      -- @param `port`: `number`
      -- @param `flags`: `table` or `nil`
      -- @param - `ipv6only`: `boolean`
      -- @param - `reuseaddr`: `boolean`
      -- 
      -- Bind the UDP handle to an IP address and port. Any `flags` are set with a table
      -- with fields `reuseaddr` or `ipv6only` equal to `true` or `false`.
      -- 
      -- @return `0` or `fail`
      -- 
      bind:function(Udp, host:string, port:integer, flags:any):integer, string

      --- ### `uv.udp_getsockname(udp)`
      -- 
      -- > method form `udp:getsockname()`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- 
      -- Get the local IP and port of the UDP handle.
      -- 
      -- @return `table` or `fail`
      -- - `ip` : `string`
      -- - `family` : `string`
      -- - `port` : `integer`
      -- 
      getsockname:function(Udp):any

      --- ### `uv.udp_getpeername(udp)`
      -- 
      -- > method form `udp:getpeername()`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- 
      -- Get the remote IP and port of the UDP handle on connected UDP handles.
      -- 
      -- @return `table` or `fail`
      -- - `ip` : `string`
      -- - `family` : `string`
      -- - `port` : `integer`
      -- 
      getpeername:function(Udp):any

      --- ### `uv.udp_set_membership(udp, multicast_addr, interface_addr, membership)`
      -- 
      -- > method form `udp:set_membership(multicast_addr, interface_addr, membership)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `multicast_addr`: `string`
      -- @param `interface_addr`: `string` or `nil`
      -- @param `membership`: `string`
      -- 
      -- Set membership for a multicast address. `multicast_addr` is multicast address to
      -- set membership for. `interface_addr` is interface address. `membership` can be
      -- the string `"leave"` or `"join"`.
      -- 
      -- @return `0` or `fail`
      -- 
      set_membership:function(Udp, multicast_addr:string, interface_addr:string, membership:string):integer, string

      --- ### `uv.udp_set_source_membership(udp, multicast_addr, interface_addr, source_addr, membership)`
      -- 
      -- > method form `udp:set_source_membership(multicast_addr, interface_addr, source_addr, membership)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `multicast_addr`: `string`
      -- @param `interface_addr`: `string` or `nil`
      -- @param `source_addr`: `string`
      -- @param `membership`: `string`
      -- 
      -- Set membership for a source-specific multicast group. `multicast_addr` is multicast
      -- address to set membership for. `interface_addr` is interface address. `source_addr`
      -- is source address. `membership` can be the string `"leave"` or `"join"`.
      -- 
      -- @return `0` or `fail`
      -- 
      set_source_membership:function(Udp, multicast_addr:string, interface_addr:string, source_addr:string, membership:string):integer, string

      --- ### `uv.udp_set_multicast_loop(udp, on)`
      -- 
      -- > method form `udp:set_multicast_loop(on)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `on`: `boolean`
      -- 
      -- Set IP multicast loop flag. Makes multicast packets loop back to local
      -- sockets.
      -- 
      -- @return `0` or `fail`
      -- 
      set_multicast_loop:function(Udp, on:boolean):integer, string

      --- ### `uv.udp_set_multicast_ttl(udp, ttl)`
      -- 
      -- > method form `udp:set_multicast_ttl(ttl)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `ttl`: `integer`
      -- 
      -- Set the multicast ttl.
      -- 
      -- `ttl` is an integer 1 through 255.
      -- 
      -- @return `0` or `fail`
      -- 
      set_multicast_ttl:function(Udp, ttl:integer):integer, string

      --- ### `uv.udp_set_multicast_interface(udp, interface_addr)`
      -- 
      -- > method form `udp:set_multicast_interface(interface_addr)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `interface_addr`: `string`
      -- 
      -- Set the multicast interface to send or receive data on.
      -- 
      -- @return `0` or `fail`
      -- 
      set_multicast_interface:function(Udp, interface_addr:string):integer, string

      --- ### `uv.udp_set_broadcast(udp, on)`
      -- 
      -- > method form `udp:set_broadcast(on)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `on`: `boolean`
      -- 
      -- Set broadcast on or off.
      -- 
      -- @return `0` or `fail`
      -- 
      set_broadcast:function(Udp, on:boolean):integer, string

      --- ### `uv.udp_set_ttl(udp, ttl)`
      -- 
      -- > method form `udp:set_ttl(ttl)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `ttl`: `integer`
      -- 
      -- Set the time to live.
      -- 
      -- `ttl` is an integer 1 through 255.
      -- 
      -- @return `0` or `fail`
      -- 
      set_ttl:function(Udp, ttl:integer):integer, string

      --- ### `uv.udp_send(udp, data, host, port, callback)`
      -- 
      -- > method form `udp:send(data, host, port, callback)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `data`: `buffer`
      -- @param `host`: `string`
      -- @param `port`: `integer`
      -- @param `callback`: `callable`
      -- @param - `err`: `nil` or `string`
      -- 
      -- Send data over the UDP socket. If the socket has not previously been bound
      -- with `uv.udp_bind()` it will be bound to `0.0.0.0` (the "all interfaces" IPv4
      -- address) and a random port number.
      -- 
      -- @return `uv_udp_send_t userdata` or `fail`
      -- 
      send:function(Udp, data:any, host:string, port:integer, callback:function()):any, string

      --- ### `uv.udp_try_send(udp, data, host, port)`
      -- 
      -- > method form `udp:try_send(data, host, port)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `data`: `buffer`
      -- @param `host`: `string`
      -- @param `port`: `integer`
      -- 
      -- Same as `uv.udp_send()`, but won't queue a send request if it can't be
      -- completed immediately.
      -- 
      -- @return `integer` or `fail`
      -- 
      try_send:function(Udp, data:any, host:string, port:integer):integer, string

      --- ### `uv.udp_recv_start(udp, callback)`
      -- 
      -- > method form `udp:recv_start(callback)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `callback`: `callable`
      -- @param - `err`: `nil` or `string`
      -- @param - `data`: `string` or `nil`
      -- @param - `addr`: `table` or `nil`
      -- @param   - `ip`: `string`
      -- @param   - `port`: `integer`
      -- @param   - `family`: `string`
      -- @param - `flags`: `table`
      -- @param   - `partial`: `boolean` or `nil`
      -- @param   - `mmsg_chunk`: `boolean` or `nil`
      -- 
      -- Prepare for receiving data. If the socket has not previously been bound with
      -- `uv.udp_bind()` it is bound to `0.0.0.0` (the "all interfaces" IPv4 address)
      -- and a random port number.
      -- 
      -- @return `0` or `fail`
      -- 
      recv_start:function(Udp, callback:function()):integer, string

      --- ### `uv.udp_recv_stop(udp)`
      -- 
      -- > method form `udp:recv_stop()`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- 
      -- Stop listening for incoming datagrams.
      -- 
      -- @return `0` or `fail`
      -- 
      recv_stop:function(Udp):integer, string

      --- ### `uv.udp_connect(udp, host, port)`
      -- 
      -- > method form `udp:connect(host, port)`
      -- 
      -- @param `udp`: `uv_udp_t userdata`
      -- @param `host`: `string`
      -- @param `port`: `integer`
      -- 
      -- Associate the UDP handle to a remote address and port, so every message sent by
      -- this handle is automatically sent to that destination. Calling this function
      -- with a NULL addr disconnects the handle. Trying to call `uv.udp_connect()` on an
      -- already connected handle will result in an `EISCONN` error. Trying to disconnect
      -- a handle that is not connected will return an `ENOTCONN` error.
      -- 
      -- @return `0` or `fail`
      -- 
      connect:function(Udp, host:string, port:integer):integer, string
   end

   --- ### `uv.new_udp([flags])`
   -- 
   -- @param `flags`: `table` or `nil`
   -- @param - `family`: `string` or `nil`
   -- @param - `mmsgs`: `integer` or `nil` (default: `1`)
   -- 
   -- Creates and initializes a new `uv_udp_t`. Returns the Lua userdata wrapping
   -- it. The actual socket is created lazily.
   -- 
   -- When specified, `family` must be one of `"unix"`, `"inet"`, `"inet6"`,
   -- `"ipx"`, `"netlink"`, `"x25"`, `"ax25"`, `"atmpvc"`, `"appletalk"`, or
   -- `"packet"`.
   -- 
   -- When specified, `mmsgs` determines the number of messages able to be received
   -- at one time via `recvmmsg(2)` (the allocated buffer will be sized to be able
   -- to fit the specified number of max size dgrams). Only has an effect on
   -- platforms that support `recvmmsg(2)`.
   -- 
   -- **Note:** For backwards compatibility reasons, `flags` can also be a string or
   -- integer. When it is a string, it will be treated like the `family` key above.
   -- When it is an integer, it will be used directly as the `flags` parameter when
   -- calling `uv_udp_init_ex`.
   -- 
   -- @return `uv_udp_t userdata` or `fail`
   -- 
   new_udp:function(flags:any):Udp

   -- ## `uv_fs_event_t` — FS Event handle
   -- 
   -- [`uv_fs_event_t`]: #uv_fs_event_t--fs-event-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- FS Event handles allow the user to monitor a given path for changes, for
   -- example, if the file was renamed or there was a generic change in it. This
   -- handle uses the best backend for the job on each platform.
   -- 
   interface FsEvent is Handle where (self as Handle):get_type() == "fs_event"
      --- ### `uv.fs_event_start(fs_event, path, flags, callback)`
      -- 
      -- > method form `fs_event:start(path, flags, callback)`
      -- 
      -- @param `fs_event`: `uv_fs_event_t userdata`
      -- @param `path`: `string`
      -- @param `flags`: `table`
      -- @param - `watch_entry`: `boolean` or `nil` (default: `false`)
      -- @param - `stat`: `boolean` or `nil` (default: `false`)
      -- @param - `recursive`: `boolean` or `nil` (default: `false`)
      -- @param `callback`: `callable`
      -- @param - `err`: `nil` or `string`
      -- @param - `filename`: `string`
      -- @param - `events`: `table`
      -- @param   - `change`: `boolean` or `nil`
      -- @param   - `rename`: `boolean` or `nil`
      -- 
      -- Start the handle with the given callback, which will watch the specified path
      -- for changes.
      -- 
      -- @return `0` or `fail`
      -- 
      start:function(FsEvent, path:string, flags:any, callback:function()):integer, string

      --- ### `uv.fs_event_stop()`
      -- 
      -- > method form `fs_event:stop()`
      -- 
      -- Stop the handle, the callback will no longer be called.
      -- 
      -- @return `0` or `fail`
      -- 
      stop:function(FsEvent):integer, string

      --- ### `uv.fs_event_getpath()`
      -- 
      -- > method form `fs_event:getpath()`
      -- 
      -- Get the path being monitored by the handle.
      -- 
      -- @return `string` or `fail`
      -- 
      getpath:function(FsEvent):string, string
   end

   --- ### `uv.new_fs_event()`
   -- 
   -- Creates and initializes a new `uv_fs_event_t`. Returns the Lua userdata wrapping
   -- it.
   -- 
   -- @return `uv_fs_event_t userdata` or `fail`
   -- 
   new_fs_event:function():FsEvent

   --- ## `uv_fs_poll_t` — FS Poll handle
   -- 
   -- [`uv_fs_poll_t`]: #uv_fs_poll_t--fs-poll-handle
   -- 
   -- > [`uv_handle_t`] functions also apply.
   -- 
   -- FS Poll handles allow the user to monitor a given path for changes. Unlike
   -- `uv_fs_event_t`, fs poll handles use `stat` to detect when a file has changed so
   -- they can work on file systems where fs event handles can't.
   -- 
   interface FsPoll is Handle where (self as Handle):get_type() == "fs_poll"
      -- Handle functions
      is_active:function(FsPoll):boolean, string
      is_closing:function(FsPoll):boolean, string
      close:function(FsPoll, callback:function())
      ref:function(FsPoll)
      unref:function(FsPoll)
      has_ref:function(FsPoll):boolean, string
      send_buffer_size:function(FsPoll, size:integer):integer, string
      recv_buffer_size:function(FsPoll, size:integer):integer, string
      fileno:function(FsPoll):integer, string
      get_type:function(FsPoll):string, integer

      --- ### `uv.fs_poll_start(fs_poll, path, interval, callback)`
      -- 
      -- > method form `fs_poll:start(path, interval, callback)`
      -- 
      -- @param `fs_poll`: `uv_fs_poll_t userdata`
      -- @param `path`: `string`
      -- @param `interval`: `integer`
      -- @param `callback`: `callable`
      -- @param - `err`: `nil` or `string`
      -- @param - `prev`: `table` or `nil` (see `uv.fs_stat`)
      -- @param - `curr`: `table` or `nil` (see `uv.fs_stat`)
      -- 
      -- Check the file at `path` for changes every `interval` milliseconds.
      -- 
      -- **Note:** For maximum portability, use multi-second intervals. Sub-second
      -- intervals will not detect all changes on many file systems.
      -- 
      -- @return `0` or `fail`
      -- 
      start:function(FsPoll, path:string, interval:integer, callback:function()):integer, string

      --- ### `uv.fs_poll_stop()`
      -- 
      -- > method form `fs_poll:stop()`
      -- 
      -- Stop the handle, the callback will no longer be called.
      -- 
      -- @return `0` or `fail`
      -- 
      stop:function(FsPoll):integer, string

      --- ### `uv.fs_poll_getpath()`
      -- 
      -- > method form `fs_poll:getpath()`
      -- 
      -- Get the path being monitored by the handle.
      -- 
      -- @return `string` or `fail`
      -- 
      getpath:function(FsPoll):string, string
   end

   --- ### `uv.new_fs_poll()`
   -- 
   -- Creates and initializes a new `uv_fs_poll_t`. Returns the Lua userdata wrapping
   -- it.
   -- 
   -- @return `uv_fs_poll_t userdata` or `fail`
   -- 
   new_fs_poll:function():FsPoll, string

   record FsStats
      record TimeInfo
         sec:integer
         nsec:integer
      end

      dev:integer
      mode:integer
      nlink:integer
      uid:integer
      gid:integer
      rdev:integer
      ino:integer
      size:integer
      blksize:integer
      blocks:integer
      flags:integer
      gen:integer
      atime:TimeInfo
      mtime:TimeInfo
      ctime:TimeInfo
      birthtime:TimeInfo
      type:string
   end

   --- ## File system operations
   -- 
   -- [File system operations]: #file-system-operations
   -- 
   -- Most file system functions can operate synchronously or asynchronously. When a synchronous version is called (by omitting a callback), the function will
   -- immediately return the results of the FS call. When an asynchronous version is
   -- called (by providing a callback), the function will immediately return a
   -- `uv_fs_t userdata` and asynchronously execute its callback; if an error is encountered, the first and only argument passed to the callback will be the `err` error string; if the operation completes successfully, the first argument will be `nil` and the remaining arguments will be the results of the FS call.
   -- 
   -- Synchronous and asynchronous versions of `readFile` (with naive error handling)
   -- are implemented below as an example:
   -- 
   -- ```lua
   -- local function readFileSync(path)
   --   local fd = assert(uv.fs_open(path, "r", 438))
   --   local stat = assert(uv.fs_fstat(fd))
   --   local data = assert(uv.fs_read(fd, stat.size, 0))
   --   assert(uv.fs_close(fd))
   --   return data
   -- end
   -- 
   -- local data = readFileSync("main.lua")
   -- print("synchronous read", data)
   -- ```
   -- 
   -- ```lua
   -- local function readFile(path, callback)
   --   uv.fs_open(path, "r", 438, function(err, fd)
   --     assert(not err, err)
   --     uv.fs_fstat(fd, function(err, stat)
   --       assert(not err, err)
   --       uv.fs_read(fd, stat.size, 0, function(err, data)
   --         assert(not err, err)
   --         uv.fs_close(fd, function(err)
   --           assert(not err, err)
   --           return callback(data)
   --         end)
   --       end)
   --     end)
   --   end)
   -- end
   -- 
   -- readFile("main.lua", function(data)
   --   print("asynchronous read", data)
   -- end)
   -- ```
   -- 
   interface Fs is Req where (self as Req):get_type() == "fs"
   end

   --- ### `uv.fs_close(fd, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `close(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_close:function(fd:integer):boolean, string
   fs_close:function(fd:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_open(path, flags, mode, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `flags`: `string` or `integer`
   -- @param `mode`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `fd`: `integer` or `nil`
   -- 
   -- Equivalent to `open(2)`. Access `flags` may be an integer or one of: `"r"`,
   -- `"rs"`, `"sr"`, `"r+"`, `"rs+"`, `"sr+"`, `"w"`, `"wx"`, `"xw"`, `"w+"`,
   -- `"wx+"`, `"xw+"`, `"a"`, `"ax"`, `"xa"`, `"a+"`, `"ax+"`, or "`xa+`".
   -- 
   -- **Returns (sync version):** `integer` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   -- **Note:** On Windows, libuv uses `CreateFileW` and thus the file is always
   -- opened in binary mode. Because of this, the `O_BINARY` and `O_TEXT` flags are
   -- not supported.
   -- 
   fs_open:function(path:string, flags:string|integer, mode:integer):integer, string
   fs_open:function(path:string, flags:string|integer, mode:integer, callback:function(string, integer)):Fs

   --- ### `uv.fs_read(fd, size, [offset], [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `size`: `integer`
   -- @param `offset`: `integer` or `nil`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `data`: `string` or `nil`
   -- 
   -- Equivalent to `preadv(2)`. Returns any data. An empty string indicates EOF.
   -- 
   -- If `offset` is nil or omitted, it will default to `-1`, which indicates 'use and update the current file offset.'
   -- 
   -- **Note:** When `offset` is >= 0, the current file offset will not be updated by the read.
   -- 
   -- **Returns (sync version):** `string` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_read:function(fd:integer, size:integer, offset:integer):string, string
   fs_read:function(fd:integer, size:integer, offset:integer, callback:function(string, string)):Fs

   --- ### `uv.fs_unlink(path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `unlink(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_unlink:function(path:string):boolean, string
   fs_unlink:function(path:string, callback:function(string, boolean)):Fs

   --- ### `uv.fs_write(fd, data, [offset], [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `data`: `buffer`
   -- @param `offset`: `integer` or `nil`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `bytes`: `integer` or `nil`
   -- 
   -- Equivalent to `pwritev(2)`. Returns the number of bytes written.
   -- 
   -- If `offset` is nil or omitted, it will default to `-1`, which indicates 'use and update the current file offset.'
   -- 
   -- **Note:** When `offset` is >= 0, the current file offset will not be updated by the write.
   -- 
   -- **Returns (sync version):** `integer` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_write:function(fd:integer, data:any, offset:integer):integer, string
   fs_write:function(fd:integer, data:any, offset:integer, callback:function(string, integer)):Fs

   --- ### `uv.fs_mkdir(path, mode, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `mode`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `mkdir(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_mkdir:function(path:string, mode:integer):boolean, string
   fs_mkdir:function(path:string, mode:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_mkdtemp(template, [callback])`
   -- 
   -- @param `template`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `path`: `string` or `nil`
   -- 
   -- Equivalent to `mkdtemp(3)`.
   -- 
   -- **Returns (sync version):** `string` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_mkdtemp:function(template:string):string, string
   fs_mkdtemp:function(template:string, callback:function(string, string)):Fs

   --- ### `uv.fs_mkstemp(template, [callback])`
   -- 
   -- @param `template`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `fd`: `integer` or `nil`
   -- @param - `path`: `string` or `nil`
   -- 
   -- Equivalent to `mkstemp(3)`. Returns a temporary file handle and filename.
   -- 
   -- **Returns (sync version):** `integer, string` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_mkstemp:function(template:string):integer | string, string
   fs_mkstemp:function(template:string, callback:function(string, integer | string)):Fs

   --- ### `uv.fs_rmdir(path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `rmdir(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_rmdir:function(path:string):boolean, string
   fs_rmdir:function(path:string, callback:function(string, boolean)):Fs

   --- ### `uv.fs_scandir(path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable`
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `uv_fs_t userdata` or `nil`
   -- 
   -- Equivalent to `scandir(3)`, with a slightly different API. Returns a handle that
   -- the user can pass to `uv.fs_scandir_next()`.
   -- 
   -- **Note:** This function can be used synchronously or asynchronously. The request
   -- userdata is always synchronously returned regardless of whether a callback is
   -- provided and the same userdata is passed to the callback if it is provided.
   -- 
   -- @return `uv_fs_t userdata` or `fail`
   -- 
   fs_scandir:function(path:string, callback:function(string, Fs)):Fs, string

   --- ### `uv.fs_scandir_next(fs)`
   -- 
   -- @param `fs`: `uv_fs_t userdata`
   -- 
   -- Called on a `uv_fs_t` returned by `uv.fs_scandir()` to get the next directory
   -- entry data as a `name, type` pair. When there are no more entries, `nil` is
   -- returned.
   -- 
   -- **Note:** This function only has a synchronous version. See `uv.fs_opendir` and
   -- its related functions for an asynchronous version.
   -- 
   -- @return `string, string` or `nil` or `fail`
   -- 
   fs_scandir_next:function(fs:Fs):string, string

   --- ### `uv.fs_stat(path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `stat`: `table` or `nil` (see below)
   -- 
   -- Equivalent to `stat(2)`.
   -- 
   -- **Returns (sync version):** `table` or `fail`
   -- - `dev` : `integer`
   -- - `mode` : `integer`
   -- - `nlink` : `integer`
   -- - `uid` : `integer`
   -- - `gid` : `integer`
   -- - `rdev` : `integer`
   -- - `ino` : `integer`
   -- - `size` : `integer`
   -- - `blksize` : `integer`
   -- - `blocks` : `integer`
   -- - `flags` : `integer`
   -- - `gen` : `integer`
   -- - `atime` : `table`
   --   - `sec` : `integer`
   --   - `nsec` : `integer`
   -- - `mtime` : `table`
   --   - `sec` : `integer`
   --   - `nsec` : `integer`
   -- - `ctime` : `table`
   --   - `sec` : `integer`
   --   - `nsec` : `integer`
   -- - `birthtime` : `table`
   --   - `sec` : `integer`
   --   - `nsec` : `integer`
   -- - `type` : `string`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_stat:function(path:string):FsStats
   fs_stat:function(path:string, callback:function(string, FsStats)):Fs

   --- ### `uv.fs_fstat(fd, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `stat`: `table` or `nil` (see `uv.fs_stat`)
   -- 
   -- Equivalent to `fstat(2)`.
   -- 
   -- **Returns (sync version):** `table` or `fail` (see `uv.fs_stat`)
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_fstat:function(fd:integer):FsStats, string
   fs_fstat:function(fd:integer, callback:function(string, FsStats)):Fs

   --- ### `uv.fs_lstat(path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `stat`: `table` or `nil` (see `uv.fs_stat`)
   -- 
   -- Equivalent to `lstat(2)`.
   -- 
   -- **Returns (sync version):** `table` or `fail` (see `uv.fs_stat`)
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_lstat:function(path:string):FsStats, string
   fs_lstat:function(path:string, callback:function(string, FsStats)):Fs

   --- ### `uv.fs_rename(path, new_path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `new_path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `rename(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_rename:function(path:string, new_path:string):boolean, string
   fs_rename:function(path:string, new_path:string, callback:function(string, boolean)):Fs

   --- ### `uv.fs_fsync(fd, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `fsync(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_fsync:function(fd:integer):boolean, string
   fs_fsync:function(fd:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_fdatasync(fd, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `fdatasync(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_fdatasync:function(fd:integer):boolean, string
   fs_fdatasync:function(fd:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_ftruncate(fd, offset, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `offset`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `ftruncate(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_ftruncate:function(fd:integer, offset:integer):boolean, string
   fs_ftruncate:function(fd:integer, offset:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_sendfile(out_fd, in_fd, in_offset, size, [callback])`
   -- 
   -- @param `out_fd`: `integer`
   -- @param `in_fd`: `integer`
   -- @param `in_offset`: `integer`
   -- @param `size`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `bytes`: `integer` or `nil`
   -- 
   -- Limited equivalent to `sendfile(2)`. Returns the number of bytes written.
   -- 
   -- **Returns (sync version):** `integer` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_sendfile:function(out_fd:integer, in_fd:integer, in_offset:integer, size:integer):integer, string
   fs_sendfile:function(out_fd:integer, in_fd:integer, in_offset:integer, size:integer, callback:function(string, integer)):Fs

   --- ### `uv.fs_access(path, mode, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `mode`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `permission`: `boolean` or `nil`
   -- 
   -- Equivalent to `access(2)` on Unix. Windows uses `GetFileAttributesW()`. Access
   -- `mode` can be an integer or a string containing `"R"` or `"W"` or `"X"`.
   -- Returns `true` or `false` indicating access permission.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_access:function(path:string, mode:integer):boolean, string
   fs_access:function(path:string, mode:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_chmod(path, mode, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `mode`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `chmod(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_chmod:function(path:string, mode:integer):boolean, string
   fs_chmod:function(path:string, mode:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_fchmod(fd, mode, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `mode`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `fchmod(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_fchmod:function(fd:integer, mode:integer):boolean, string
   fs_fchmod:function(fd:integer, mode:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_utime(path, atime, mtime, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `atime`: `number`
   -- @param `mtime`: `number`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `utime(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_utime:function(path:string, atime:number, mtime:number):boolean, string
   fs_utime:function(path:string, atime:number, mtime:number, callback:function(string, boolean)):Fs

   --- ### `uv.fs_futime(fd, atime, mtime, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `atime`: `number`
   -- @param `mtime`: `number`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `futime(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_futime:function(fd:integer, atime:number, mtime:number):boolean, string
   fs_futime:function(fd:integer, atime:number, mtime:number, callback:function(string, boolean)):Fs

   --- ### `uv.fs_lutime(path, atime, mtime, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `atime`: `number`
   -- @param `mtime`: `number`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `lutime(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_lutime:function(path:string, atime:number, mtime:number):boolean, string
   fs_lutime:function(path:string, atime:number, mtime:number, callback:function(string, boolean)):Fs

   --- ### `uv.fs_link(path, new_path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `new_path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `link(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_link:function(path:string, new_path:string):boolean, string
   fs_link:function(path:string, new_path:string, callback:function(string, boolean)):Fs

   --- ### `uv.fs_symlink(path, new_path, [flags], [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `new_path`: `string`
   -- @param `flags`: `table`, `integer`, or `nil`
   -- @param - `dir`: `boolean`
   -- @param - `junction`: `boolean`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `symlink(2)`. If the `flags` parameter is omitted, then the 3rd parameter will be treated as the `callback`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_symlink:function(path:string, new_path:string, flags:any):boolean, string
   fs_symlink:function(path:string, new_path:string, flags:any, callback:function(string, boolean)):Fs

   --- ### `uv.fs_readlink(path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `path`: `string` or `nil`
   -- 
   -- Equivalent to `readlink(2)`.
   -- 
   -- **Returns (sync version):** `string` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_readlink:function(path:string):string, string
   fs_readlink:function(path:string, callback:function(string, string)):Fs

   --- ### `uv.fs_realpath(path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `path`: `string` or `nil`
   -- 
   -- Equivalent to `realpath(3)`.
   -- 
   -- **Returns (sync version):** `string` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_realpath:function(path:string):string, string
   fs_realpath:function(path:string, callback:function(string, string)):Fs

   --- ### `uv.fs_chown(path, uid, gid, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `uid`: `integer`
   -- @param `gid`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `chown(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_chown:function(path:string, uid:integer, gid:integer):boolean, string
   fs_chown:function(path:string, uid:integer, gid:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_fchown(fd, uid, gid, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `uid`: `integer`
   -- @param `gid`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `fchown(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_fchown:function(fd:integer, uid:integer, gid:integer):boolean, string
   fs_fchown:function(fd:integer, uid:integer, gid:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_lchown(fd, uid, gid, [callback])`
   -- 
   -- @param `fd`: `integer`
   -- @param `uid`: `integer`
   -- @param `gid`: `integer`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Equivalent to `lchown(2)`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_lchown:function(fd:integer, uid:integer, gid:integer):boolean, string
   fs_lchown:function(fd:integer, uid:integer, gid:integer, callback:function(string, boolean)):Fs

   --- ### `uv.fs_copyfile(path, new_path, [flags], [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `new_path`: `string`
   -- @param `flags`: `table`, `integer`, or `nil`
   -- @param - `excl`: `boolean`
   -- @param - `ficlone`: `boolean`
   -- @param - `ficlone_force`: `boolean`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `success`: `boolean` or `nil`
   -- 
   -- Copies a file from path to new_path. If the `flags` parameter is omitted, then the 3rd parameter will be treated as the `callback`.
   -- 
   -- **Returns (sync version):** `boolean` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_copyfile:function(path:string, new_path:string, flags:any):boolean, string
   fs_copyfile:function(path:string, new_path:string, flags:any, callback:function(string, boolean)):Fs

   record Ldir
      --- ### `uv.fs_readdir(dir, [callback])`
      -- 
      -- > method form `dir:readdir([callback])`
      -- 
      -- @param `dir`: `luv_dir_t userdata`
      -- @param `callback`: `callable` (async version) or `nil` (sync version)
      -- @param - `err`: `nil` or `string`
      -- @param - `entries`: `table` or `nil` (see below)
      -- 
      -- Iterates over the directory stream `luv_dir_t` returned by a successful
      -- `uv.fs_opendir()` call. A table of data tables is returned where the number
      -- of entries `n` is equal to or less than the `entries` parameter used in
      -- the associated `uv.fs_opendir()` call.
      -- 
      -- **Returns (sync version):** `table` or `fail`
      -- - `[1, 2, 3, ..., n]` : `table`
      --   - `name` : `string`
      --   - `type` : `string`
      -- 
      -- **Returns (async version):** `uv_fs_t userdata`
      -- 
      readdir:function(Ldir):any, string
      readdir:function(Ldir, callback:function(string, any)):Fs

      --- ### `uv.fs_closedir(dir, [callback])`
      -- 
      -- > method form `dir:closedir([callback])`
      -- 
      -- @param `dir`: `luv_dir_t userdata`
      -- @param `callback`: `callable` (async version) or `nil` (sync version)
      -- @param - `err`: `nil` or `string`
      -- @param - `success`: `boolean` or `nil`
      -- 
      -- Closes a directory stream returned by a successful `uv.fs_opendir()` call.
      -- 
      -- **Returns (sync version):** `boolean` or `fail`
      -- 
      -- **Returns (async version):** `uv_fs_t userdata`
      -- 
      closedir:function(Ldir):any, string
      closedir:function(Ldir, callback:function(string, any)):Fs
   end

   --- ### `uv.fs_opendir(path, [callback, [entries]])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `dir`: `luv_dir_t userdata` or `nil`
   -- @param `entries`: `integer` or `nil`
   -- 
   -- Opens path as a directory stream. Returns a handle that the user can pass to
   -- `uv.fs_readdir()`. The `entries` parameter defines the maximum number of entries
   -- that should be returned by each call to `uv.fs_readdir()`.
   -- 
   -- **Returns (sync version):** `luv_dir_t userdata` or `fail`
   -- 
   -- **Returns (async version):** `uv_fs_t userdata`
   -- 
   fs_opendir:function(path:string, entries:integer):Ldir, string
   fs_opendir:function(path:string, callback:function(string, Ldir), entries:integer):Fs

   --- ### `uv.fs_statfs(path, [callback])`
   -- 
   -- @param `path`: `string`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `table` or `nil` (see below)
   -- 
   -- Equivalent to `statfs(2)`.
   -- 
   -- **Returns** `table` or `nil`
   -- - `type` : `integer`
   -- - `bsize` : `integer`
   -- - `blocks` : `integer`
   -- - `bfree` : `integer`
   -- - `bavail` : `integer`
   -- - `files` : `integer`
   -- - `ffree` : `integer`
   -- 
   fs_statfs:function(path:string, callback:function(string, any)):any

   --- ## Thread pool work scheduling
   -- 
   -- [Thread pool work scheduling]: #thread-pool-work-scheduling
   -- 
   -- Libuv provides a threadpool which can be used to run user code and get notified
   -- in the loop thread. This threadpool is internally used to run all file system
   -- operations, as well as `getaddrinfo` and `getnameinfo` requests.
   -- 
   -- ```lua
   -- local function work_callback(a, b)
   --   return a + b
   -- end
   -- 
   -- local function after_work_callback(c)
   --   print("The result is: " .. c)
   -- end
   -- 
   -- local work = uv.new_work(work_callback, after_work_callback)
   -- 
   -- work:queue(1, 2)
   -- 
   -- -- output: "The result is: 3"
   -- ```
   -- 
   record LworkCtx
      queue:function(LworkCtx, ...:any):boolean, string
   end

   --- ### `uv.new_work(work_callback, after_work_callback)`
   -- 
   -- @param `work_callback`: `function` or `string`
   -- @param - `...`: `threadargs` passed to/from `uv.queue_work(work_ctx, ...)`
   -- @param `after_work_callback`: `function`
   -- @param - `...`: `threadargs` returned from `work_callback`
   -- 
   -- Creates and initializes a new `luv_work_ctx_t` (not `uv_work_t`).
   -- `work_callback` is a Lua function or a string containing Lua code or bytecode dumped from a function.
   -- Returns the Lua userdata wrapping it.
   -- 
   -- @return `luv_work_ctx_t userdata`
   -- 
   new_work:function(work_callback:function(), after_work_callback:function()):LworkCtx

   --- ### `uv.queue_work(work_ctx, ...)`
   -- 
   -- > method form `work_ctx:queue(...)`
   -- 
   -- @param `work_ctx`: `luv_work_ctx_t userdata`
   -- @param `...`: `threadargs`
   -- 
   -- Queues a work request which will run `work_callback` in a new Lua state in a
   -- thread from the threadpool with any additional arguments from `...`. Values
   -- returned from `work_callback` are passed to `after_work_callback`, which is
   -- called in the main loop thread.
   -- 
   -- @return `boolean` or `fail`
   -- 
   -- ## DNS utility functions
   -- 
   -- [DNS utility functions]: #dns-utility-functions
   -- 
   queue_work:function():boolean, string

   -- dns utility functions

   --- ### `uv.getaddrinfo(host, service, [hints, [callback]])`
   -- 
   -- @param `host`: `string` or `nil`
   -- @param `service`: `string` or `nil`
   -- @param `hints`: `table` or `nil`
   -- @param - `family`: `string` or `integer` or `nil`
   -- @param - `socktype`: `string` or `integer` or `nil`
   -- @param - `protocol`: `string` or `integer` or `nil`
   -- @param - `addrconfig`: `boolean` or `nil`
   -- @param - `v4mapped`: `boolean` or `nil`
   -- @param - `all`: `boolean` or `nil`
   -- @param - `numerichost`: `boolean` or `nil`
   -- @param - `passive`: `boolean` or `nil`
   -- @param - `numericserv`: `boolean` or `nil`
   -- @param - `canonname`: `boolean` or `nil`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `addresses`: `table` or `nil` (see below)
   -- 
   -- Equivalent to `getaddrinfo(3)`. Either `node` or `service` may be `nil` but not
   -- both.
   -- 
   -- Valid hint strings for the keys that take a string:
   -- - `family`: `"unix"`, `"inet"`, `"inet6"`, `"ipx"`,
   -- `"netlink"`, `"x25"`, `"ax25"`, `"atmpvc"`, `"appletalk"`, or `"packet"`
   -- - `socktype`: `"stream"`, `"dgram"`, `"raw"`,
   -- `"rdm"`, or `"seqpacket"`
   -- - `protocol`: will be looked up using the `getprotobyname(3)` function (examples: `"ip"`, `"icmp"`, `"tcp"`, `"udp"`, etc)
   -- 
   -- **Returns (sync version):** `table` or `fail`
   -- - `[1, 2, 3, ..., n]` : `table`
   --   - `addr` : `string`
   --   - `family` : `string`
   --   - `port` : `integer` or `nil`
   --   - `socktype` : `string`
   --   - `protocol` : `string`
   --   - `canonname` : `string` or `nil`
   -- 
   -- **Returns (async version):** `uv_getaddrinfo_t userdata` or `fail`
   -- 
   getaddrinfo:function(host:string, service:string, hints:any, callback:function(string, any))

   --- ### `uv.getnameinfo(address, [callback])`
   -- 
   -- @param `address`: `table`
   -- @param - `ip`: `string` or `nil`
   -- @param - `port`: `integer` or `nil`
   -- @param - `family`: `string` or `integer` or `nil`
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `sring`
   -- @param - `host`: `string` or `nil`
   -- @param - `service`: `string` or `nil`
   -- 
   -- Equivalent to `getnameinfo(3)`.
   -- 
   -- When specified, `family` must be one of `"unix"`, `"inet"`, `"inet6"`, `"ipx"`,
   -- `"netlink"`, `"x25"`, `"ax25"`, `"atmpvc"`, `"appletalk"`, or `"packet"`.
   -- 
   -- **Returns (sync version):** `string, string` or `fail`
   -- 
   -- **Returns (async version):** `uv_getnameinfo_t userdata` or `fail`
   -- 
   -- ## Threading and synchronization utilities
   -- 
   -- [Threading and synchronization utilities]: #threading-and-synchronization-utilities
   -- 
   -- Libuv provides cross-platform implementations for multiple threading an
   --  synchronization primitives. The API largely follows the pthreads API.
   -- 
   getnameinfo:function(address:any, callback:function(err:string, host:string, service:string))

   record Lthread
      userdata

      --- ### `uv.thread_equal(thread, other_thread)`
      -- 
      -- > method form `thread:equal(other_thread)`
      -- 
      -- @param `thread`: `luv_thread_t userdata`
      -- @param `other_thread`: `luv_thread_t userdata`
      -- 
      -- Returns a boolean indicating whether two threads are the same. This function is
      -- equivalent to the `__eq` metamethod.
      -- 
      -- @return `boolean`
      -- 
      equal:function(Lthread, other:Lthread):boolean

      --- ### `uv.thread_setaffinity(thread, affinity, [get_old_affinity])`
      -- 
      -- > method form `thread:setaffinity(affinity, [get_old_affinity])`
      -- 
      -- @param `thread`: `luv_thread_t userdata`
      -- @param `affinity`: `table`
      -- @param - `[1, 2, 3, ..., n]` : `boolean`
      -- @param `get_old_affinity`: `boolean`
      -- 
      -- Sets the specified thread's affinity setting.
      -- 
      -- `affinity` must be a table where each of the keys are a CPU number and the
      -- values are booleans that represent whether the `thread` should be eligible to
      -- run on that CPU. If the length of the `affinity` table is not greater than or
      -- equal to `uv.cpumask_size()`, any CPU numbers missing from the table will have
      -- their affinity set to `false`. If setting the affinity of more than
      -- `uv.cpumask_size()` CPUs is desired, `affinity` must be an array-like table
      -- with no gaps, since `#affinity` will be used as the `cpumask_size` if it is
      -- greater than `uv.cpumask_size()`.
      -- 
      -- If `get_old_affinity` is `true`, the previous affinity settings for the `thread`
      -- will be returned. Otherwise, `true` is returned after a successful call.
      -- 
      -- **Note:** Thread affinity setting is not atomic on Windows. Unsupported on macOS.
      -- 
      -- @return `table` or `boolean` or `fail`
      -- - `[1, 2, 3, ..., n]` : `boolean`
      -- 
      setaffinity:function(Lthread, affinity:any, get_old_affinity:boolean)

      --- ### `uv.thread_getaffinity(thread, [mask_size])`
      -- 
      -- > method form `thread:getaffinity([mask_size])`
      -- 
      -- @param `thread`: `luv_thread_t userdata`
      -- @param `mask_size`: `integer`
      -- 
      -- Gets the specified thread's affinity setting.
      -- 
      -- If `mask_size` is provided, it must be greater than or equal to
      -- `uv.cpumask_size()`. If the `mask_size` parameter is omitted, then the return
      -- of `uv.cpumask_size()` will be used. Returns an array-like table where each of
      -- the keys correspond to a CPU number and the values are booleans that represent
      -- whether the `thread` is eligible to run on that CPU.
      -- 
      -- **Note:** Thread affinity getting is not atomic on Windows. Unsupported on macOS.
      -- 
      -- @return `table` or `fail`
      -- - `[1, 2, 3, ..., n]` : `boolean`
      -- 
      getaffinity:function(Lthread, mask_size:integer)

      --- ### `uv.thread_join(thread)`
      -- 
      -- > method form `thread:join()`
      -- 
      -- @param `thread`: `luv_thread_t userdata`
      -- 
      -- Waits for the `thread` to finish executing its entry function.
      -- 
      -- @return `boolean` or `fail`
      -- 
      join:function(Lthread)
   end

   --- ### `uv.new_thread([options], entry, ...)`
   -- 
   -- @param `options`: `table` or `nil`
   -- @param - `stack_size`: `integer` or `nil`
   -- @param `entry`: `function` or `string`
   -- @param `...`: `threadargs` passed to `entry`
   -- 
   -- Creates and initializes a `luv_thread_t` (not `uv_thread_t`). Returns the Lua
   -- userdata wrapping it and asynchronously executes `entry`, which can be either
   -- a Lua function or a string containing Lua code or bytecode dumped from a function. Additional arguments `...`
   -- are passed to the `entry` function and an optional `options` table may be
   -- provided. Currently accepted `option` fields are `stack_size`.
   -- 
   -- @return `luv_thread_t userdata` or `fail`
   -- 
   -- **Note:** unsafe, please make sure the thread end of life before Lua state close.
   -- 
   new_thread:function(options:any, entry:function() | string, ...:any):Lthread, string

   --- ### `uv.thread_getcpu()`
   -- 
   -- Gets the CPU number on which the calling thread is running.
   -- 
   -- **Note:** The first CPU will be returned as the number 1, not 0. This allows for
   -- the number to correspond with the table keys used in `uv.thread_getaffinity` and
   -- `uv.thread_setaffinity`.
   -- 
   -- @return `integer` or `fail`
   thread_getcpu:function():integer, string

   --- ### `uv.thread_self()`
   -- 
   -- Returns the handle for the thread in which this is called.
   -- 
   -- @return `luv_thread_t`
   -- 
   thread_self:function():Lthread

   --- ### `uv.sleep(msec)`
   -- 
   -- @param `msec`: `integer`
   -- 
   -- Pauses the thread in which this is called for a number of milliseconds.
   -- 
   -- @return Nothing.
   sleep:function(msec:integer)

   --- ### `uv.exepath()`
   -- 
   -- Returns the executable path.
   -- 
   -- @return `string` or `fail`
   -- 
   exepath:function():string

   --- ### `uv.cwd()`
   -- 
   -- Returns the current working directory.
   -- 
   -- @return `string` or `fail`
   -- 
   cwd:function():string, string

   --- ### `uv.chdir(cwd)`
   -- 
   -- @param `cwd`: `string`
   -- 
   -- Sets the current working directory with the string `cwd`.
   -- 
   -- @return `0` or `fail`
   -- 
   chdir:function(cwd:string):integer, string

   --- ### `uv.get_process_title()`
   -- 
   -- Returns the title of the current process.
   -- 
   -- @return `string` or `fail`
   -- 
   get_process_title:function():string, string

   --- ### `uv.set_process_title(title)`
   -- 
   -- @param `title`: `string`
   -- 
   -- Sets the title of the current process with the string `title`.
   -- 
   -- @return `0` or `fail`
   -- 
   set_process_title:function(string):integer, string

   --- ### `uv.get_total_memory()`
   -- 
   -- Returns the current total system memory in bytes.
   -- 
   -- @return `number`
   -- 
   get_total_memory:function():number

   --- ### `uv.get_free_memory()`
   -- 
   -- Returns the current free system memory in bytes.
   -- 
   -- @return `number`
   -- 
   get_free_memory:function():number

   --- ### `uv.get_constrained_memory()`
   -- 
   -- Gets the amount of memory available to the process in bytes based on limits
   -- imposed by the OS. If there is no such constraint, or the constraint is unknown,
   -- 0 is returned. Note that it is not unusual for this value to be less than or
   -- greater than the total system memory.
   -- 
   -- @return `number`
   -- 
   get_constrained_memory:function():number

   --- ### `uv.get_available_memory()`
   -- 
   -- Gets the amount of free memory that is still available to the process (in
   -- bytes). This differs from `uv.get_free_memory()` in that it takes into account
   -- any limits imposed by the OS. If there is no such constraint, or the constraint
   -- is unknown, the amount returned will be identical to `uv.get_free_memory()`.
   -- 
   -- @return `number`
   -- 
   get_available_memory:function():number

   --- ### `uv.resident_set_memory()`
   -- 
   -- Returns the resident set size (RSS) for the current process.
   -- 
   -- @return `integer` or `fail`
   -- 
   resident_set_memory:function():integer, string

   --- ### `uv.getrusage()`
   -- 
   -- Returns the resource usage.
   -- 
   -- @return `table` or `fail`
   -- - `utime` : `table` (user CPU time used)
   --   - `sec` : `integer`
   --   - `usec` : `integer`
   -- - `stime` : `table` (system CPU time used)
   --   - `sec` : `integer`
   --   - `usec` : `integer`
   -- - `maxrss` : `integer` (maximum resident set size)
   -- - `ixrss` : `integer` (integral shared memory size)
   -- - `idrss` : `integer` (integral unshared data size)
   -- - `isrss` : `integer` (integral unshared stack size)
   -- - `minflt` : `integer` (page reclaims (soft page faults))
   -- - `majflt` : `integer` (page faults (hard page faults))
   -- - `nswap` : `integer` (swaps)
   -- - `inblock` : `integer` (block input operations)
   -- - `oublock` : `integer` (block output operations)
   -- - `msgsnd` : `integer` (IPC messages sent)
   -- - `msgrcv` : `integer` (IPC messages received)
   -- - `nsignals` : `integer` (signals received)
   -- - `nvcsw` : `integer` (voluntary context switches)
   -- - `nivcsw` : `integer` (involuntary context switches)
   -- 
   getrusage:function():any

   --- ### `uv.available_parallelism()`
   -- 
   -- Returns an estimate of the default amount of parallelism a program should use. Always returns a non-zero value.
   -- 
   -- On Linux, inspects the calling thread’s CPU affinity mask to determine if it has been pinned to specific CPUs.
   -- 
   -- On Windows, the available parallelism may be underreported on systems with more than 64 logical CPUs.
   -- 
   -- On other platforms, reports the number of CPUs that the operating system considers to be online.
   -- 
   -- @return `integer`
   -- 
   available_parallelism:function():integer

   --- ### `uv.cpu_info()`
   -- 
   -- Returns information about the CPU(s) on the system as a table of tables for each
   -- CPU found.
   -- 
   -- @return `table` or `fail`
   -- - `[1, 2, 3, ..., n]` : `table`
   --   - `model` : `string`
   --   - `speed` : `number`
   --   - `times` : `table`
   --     - `user` : `number`
   --     - `nice` : `number`
   --     - `sys` : `number`
   --     - `idle` : `number`
   --     - `irq` : `number`
   -- 
   cpu_info:function():any

   --- ### `uv.cpumask_size()`
   -- 
   -- Returns the maximum size of the mask used for process/thread affinities, or
   -- `ENOTSUP` if affinities are not supported on the current platform.
   -- 
   -- @return `integer` or `fail`
   -- 
   cpumask_size:function():integer, string

   --- ### `uv.getuid()`
   -- 
   -- Returns the user ID of the process.
   -- 
   -- @return `integer`
   -- 
   -- **Note:** This is not a libuv function and is not supported on Windows.
   -- 
   getuid:function():integer

   --- ### `uv.getgid()`
   -- 
   -- Returns the group ID of the process.
   -- 
   -- @return `integer`
   -- 
   -- **Note:** This is not a libuv function and is not supported on Windows.
   -- 
   getgid:function():integer

   --- ### `uv.setuid(id)`
   -- 
   -- @param `id`: `integer`
   -- 
   -- Sets the user ID of the process with the integer `id`.
   -- 
   -- @return Nothing.
   -- 
   -- **Note:** This is not a libuv function and is not supported on Windows.
   -- 
   setuid:function(integer)

   --- ### `uv.setgid(id)`
   -- 
   -- @param `id`: `integer`
   -- 
   -- Sets the group ID of the process with the integer `id`.
   -- 
   -- @return Nothing.
   -- 
   -- **Note:** This is not a libuv function and is not supported on Windows.
   -- 
   setgid:function(integer)

   --- ### `uv.hrtime()`
   -- 
   -- Returns a current high-resolution time in nanoseconds as a number. This is
   -- relative to an arbitrary time in the past. It is not related to the time of day
   -- and therefore not subject to clock drift. The primary use is for measuring
   -- time between intervals.
   -- 
   -- @return `number`
   -- 
   hrtime:function():number

   record ClockTime
      sec:integer
      nsec:integer
   end

   --- ### `uv.clock_gettime(clock_id)`
   -- 
   -- @param `clock_id`: `string`
   -- 
   -- Obtain the current system time from a high-resolution real-time or monotonic
   -- clock source. `clock_id` can be the string `"monotonic"` or `"realtime"`.
   -- 
   -- The real-time clock counts from the UNIX epoch (1970-01-01) and is subject
   -- to time adjustments; it can jump back in time.
   -- 
   -- The monotonic clock counts from an arbitrary point in the past and never
   -- jumps back in time.
   -- 
   -- @return `table` or `fail`
   -- - `sec`: `integer`
   -- - `nsec`: `integer`
   -- 
   clock_gettime:function(clock_id:string):ClockTime

   --- ### `uv.uptime()`
   -- 
   -- Returns the current system uptime in seconds.
   -- 
   -- @return `number` or `fail`
   -- 
   uptime:function():number, string

   --- ### `uv.print_all_handles()`
   -- 
   -- Prints all handles associated with the main loop to stderr. The format is
   -- `[flags] handle-type handle-address`. Flags are `R` for referenced, `A` for
   -- active and `I` for internal.
   -- 
   -- @return Nothing.
   -- 
   -- **Note:** This is not available on Windows.
   -- 
   -- **Warning:** This function is meant for ad hoc debugging, there are no API/ABI
   -- stability guarantees.
   -- 
   print_all_handles:function()

   --- ### `uv.print_active_handles()`
   -- 
   -- The same as `uv.print_all_handles()` except only active handles are printed.
   -- 
   -- @return Nothing.
   -- 
   -- **Note:** This is not available on Windows.
   -- 
   -- **Warning:** This function is meant for ad hoc debugging, there are no API/ABI
   -- stability guarantees.
   -- 
   print_active_handles:function()

   --- ### `uv.guess_handle(fd)`
   -- 
   -- @param `fd`: `integer`
   -- 
   -- Used to detect what type of stream should be used with a given file
   -- descriptor `fd`. Usually this will be used during initialization to guess the
   -- type of the stdio streams.
   -- 
   -- @return `string`
   -- 
   guess_handle:function(fd:integer):string

   --- ### `uv.gettimeofday()`
   -- 
   -- Cross-platform implementation of `gettimeofday(2)`. Returns the seconds and
   -- microseconds of a unix time as a pair.
   -- 
   -- @return `integer, integer` or `fail`
   -- 
   gettimeofday:function():integer, (integer | string)

   --- ### `uv.interface_addresses()`
   -- 
   -- Returns address information about the network interfaces on the system in a
   -- table. Each table key is the name of the interface while each associated value
   -- is an array of address information where fields are `ip`, `family`, `netmask`,
   -- `internal`, and `mac`.
   -- 
   -- @return `table`
   -- - `[name(s)]` : `table`
   --   - `ip` : `string`
   --   - `family` : `string`
   --   - `netmask` : `string`
   --   - `internal` : `boolean`
   --   - `mac` : `string`
   -- 
   interface_addresses:function():any

   --- ### `uv.if_indextoname(ifindex)`
   -- 
   -- @param `ifindex`: `integer`
   -- 
   -- IPv6-capable implementation of `if_indextoname(3)`.
   -- 
   -- @return `string` or `fail`
   -- 
   if_indextoname:function(ifindex:integer):string, string

   --- ### `uv.if_indextoiid(ifindex)`
   -- 
   -- @param `ifindex`: `integer`
   -- 
   -- Retrieves a network interface identifier suitable for use in an IPv6 scoped
   -- address. On Windows, returns the numeric `ifindex` as a string. On all other
   -- platforms, `uv.if_indextoname()` is used.
   -- 
   -- @return `string` or `fail`
   -- 
   if_indextoiid:function(ifindex:integer):string, string

   --- ### `uv.loadavg()`
   -- 
   -- Returns the load average as a triad. Not supported on Windows.
   -- 
   -- @return `number, number, number`
   -- 
   loadavg:function():number, number, number

   record UnameInfo
      sysname:string
      release:string
      version:string
      machine:string
   end

   --- ### `uv.os_uname()`
   -- 
   -- Returns system information.
   -- 
   -- @return `table`
   -- - `sysname` : `string`
   -- - `release` : `string`
   -- - `version` : `string`
   -- - `machine` : `string`
   -- 
   os_uname:function():UnameInfo

   --- ### `uv.os_gethostname()`
   -- 
   -- Returns the hostname.
   -- 
   -- @return `string`
   -- 
   os_gethostname:function():string

   --- ### `uv.os_getenv(name, [size])`
   -- 
   -- @param `name`: `string`
   -- @param `size`: `integer` (default = `LUAL_BUFFERSIZE`)
   -- 
   -- Returns the environment variable specified by `name` as string. The internal
   -- buffer size can be set by defining `size`. If omitted, `LUAL_BUFFERSIZE` is
   -- used. If the environment variable exceeds the storage available in the internal
   -- buffer, `ENOBUFS` is returned. If no matching environment variable exists,
   -- `ENOENT` is returned.
   -- 
   -- @return `string` or `fail`
   -- 
   -- **Warning:** This function is not thread safe.
   -- 
   os_getenv:function(name:string, size:integer):string, string

   --- ### `uv.os_setenv(name, value)`
   -- 
   -- @param `name`: `string`
   -- @param `value`: `string`
   -- 
   -- Sets the environmental variable specified by `name` with the string `value`.
   -- 
   -- @return `boolean` or `fail`
   -- 
   -- **Warning:** This function is not thread safe.
   -- 
   os_setenv:function(name:string, value:string):boolean, string

   --- ### `uv.os_unsetenv(name)`
   -- 
   -- @param `name`: `string`
   -- 
   -- Unsets the environmental variable specified by `name`.
   -- 
   -- @return `boolean` or `fail`
   -- 
   -- **Warning:** This function is not thread safe.
   -- 
   os_unsetenv:function():boolean, string

   --- ### `uv.os_environ()`
   -- 
   -- Returns all environmental variables as a dynamic table of names associated with
   -- their corresponding values.
   -- 
   -- @return `table`
   -- 
   -- **Warning:** This function is not thread safe.
   -- 
   os_environ:function():{any}

   --- ### `uv.os_homedir()`
   -- 
   -- @return `string` or `fail`
   -- 
   -- **Warning:** This function is not thread safe.
   -- 
   os_homedir:function():string, string

   --- ### `uv.os_tmpdir()`
   -- 
   -- @return `string` or `fail`
   -- 
   -- **Warning:** This function is not thread safe.
   -- 
   os_tmpdir:function():string, string

   --- ### `uv.os_get_passwd()`
   -- 
   -- Returns password file information.
   -- 
   -- @return `table`
   -- - `username` : `string`
   -- - `uid` : `integer`
   -- - `gid` : `integer`
   -- - `shell` : `string`
   -- - `homedir` : `string`
   -- 
   os_get_passwd:function():any

   --- ### `uv.os_getpid()`
   -- 
   -- Returns the current process ID.
   -- 
   -- @return `number`
   -- 
   os_getpid:function():integer

   --- ### `uv.os_getppid()`
   -- 
   -- Returns the parent process ID.
   -- 
   -- @return `number`
   -- 
   os_getppid:function():integer

   --- ### `uv.os_getpriority(pid)`
   -- 
   -- @param `pid`: `integer`
   -- 
   -- Returns the scheduling priority of the process specified by `pid`.
   -- 
   -- @return `number` or `fail`
   -- 
   os_getpriority:function(pid:integer):integer, string

   --- ### `uv.os_setpriority(pid, priority)`
   -- 
   -- @param `pid`: `integer`
   -- @param `priority`: `integer`
   -- 
   -- Sets the scheduling priority of the process specified by `pid`. The `priority`
   -- range is between -20 (high priority) and 19 (low priority).
   -- 
   -- @return `boolean` or `fail`
   -- 
   os_setpriority:function(pid:integer, priority:integer):boolean, string

   --- ### `uv.random(len, flags, [callback])`
   -- 
   -- @param `len`: `integer`
   -- @param `flags`: `nil` (see below)
   -- @param `callback`: `callable` (async version) or `nil` (sync version)
   -- @param - `err`: `nil` or `string`
   -- @param - `bytes`: `string` or `nil`
   -- 
   -- Fills a string of length `len` with cryptographically strong random bytes
   -- acquired from the system CSPRNG. `flags` is reserved for future extension
   -- and must currently be `nil` or `0` or `{}`.
   -- 
   -- Short reads are not possible. When less than `len` random bytes are available,
   -- a non-zero error value is returned or passed to the callback. If the callback
   -- is omitted, this function is completed synchronously.
   -- 
   -- The synchronous version may block indefinitely when not enough entropy is
   -- available. The asynchronous version may not ever finish when the system is
   -- low on entropy.
   -- 
   -- **Returns (sync version):** `string` or `fail`
   -- 
   -- **Returns (async version):** `0` or `fail`
   -- 
   random:function(len:integer, flags:any, callback:function(string, string)):string | integer, string

   --- ### `uv.translate_sys_error(errcode)`
   -- 
   -- @param `errcode`: `integer`
   -- 
   -- Returns the libuv error message and error name (both in string form, see [`err` and `name` in Error Handling](#error-handling)) equivalent to the given platform dependent error code: POSIX error codes on Unix (the ones stored in errno), and Win32 error codes on Windows (those returned by GetLastError() or WSAGetLastError()).
   -- 
   -- @return `string, string` or `nil`
   -- 
   -- ## Metrics operations
   -- 
   -- [Metrics operations]: #metrics-operations
   -- 
   translate_sys_error:function(errcode:integer):string, string

   --- ### `uv.metrics_idle_time()`
   -- 
   -- Retrieve the amount of time the event loop has been idle in the kernel’s event
   -- provider (e.g. `epoll_wait`). The call is thread safe.
   -- 
   -- The return value is the accumulated time spent idle in the kernel’s event
   -- provider starting from when the [`uv_loop_t`] was configured to collect the idle time.
   -- 
   -- **Note:** The event loop will not begin accumulating the event provider’s idle
   -- time until calling `loop_configure` with `"metrics_idle_time"`.
   -- 
   -- @return `number`
   -- 
   metrics_idle_time:function():number

   --- ### `uv.metrics_info()`
   -- 
   -- Get the metrics table from current set of event loop metrics. It is recommended
   -- to retrieve these metrics in a `prepare` callback (see `uv.new_prepare`,
   -- `uv.prepare_start`) in order to make sure there are no inconsistencies with the
   -- metrics counters.
   -- 
   -- @return `table`
   -- - `loop_count` : `integer`
   -- - `events` : `integer`
   -- - `events_waiting` : `integer`
   -- 
   -- ---
   metrics_info:function():any
end

return uv
