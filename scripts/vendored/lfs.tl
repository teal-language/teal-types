-- This is a stripped down subset of the luafilesystem API that is implemented
-- purely in Teal

local record lfs
   enum FileMode
      "file"
      "directory"
      "link"
      "socket"
      "named pipe"
      "char device"
      "block device"
      "other"
   end

   enum AttributeSelFM
      "mode"
   end

   record DirObj
      next: function(self): string
      close: function(self)
   end

   dir: function(string): function(DirObj): (string), DirObj, nil, DirObj

   mkdir: function(string): boolean, string, integer
   rmdir: function(string): boolean, string, integer

   -- currentdir: function(): string, string

   attributes: function(string, AttributeSelFM): FileMode
end

-- fallback to unix
local is_windows = (os.getenv('OS') or ''):match('[Ww]indows')

local function escapepath(path: string): string
   if is_windows then
      -- windows paths can't include "
      return '"' .. path .. '"'
   else
      -- escape for unix
      return "'" .. path:gsub("'", [['\'']]) .. "'"
   end
end

local dirobjmeta = {
   __close = function(self: lfs.DirObj)
      self:close()
   end,
}

function lfs.dir(path: string): function(lfs.DirObj): (string), lfs.DirObj, nil, lfs.DirObj
   local cmdbase = is_windows and 'dir /A /B ' or 'ls -a '
   local fullcmd = cmdbase .. escapepath(path)
   local coro = coroutine.create(function()
      for subitem in io.popen(fullcmd):lines() do
         coroutine.yield(subitem)
      end
   end)

   local obj = setmetatable({
      next = function(_: lfs.DirObj): string
         if not coro then return nil end

         local worked, nex = coroutine.resume(coro)
         if not worked or not nex then
            if coroutine.close then coroutine.close(coro) end
            coro = nil
            return nil
         else
            return nex as string
         end
      end,
      close = function(_: lfs.DirObj)
         if coro then
            if coroutine.close then coroutine.close(coro) end
            coro = nil
         end
      end,
   }, dirobjmeta)

   return obj.next, obj, nil, obj
end

function lfs.mkdir(path: string): boolean, string, integer
   local worked, why, num = os.execute('mkdir ' .. escapepath(path))
   if worked then
      return true, nil, nil
   elseif why == 'signal' then
      return false, why, num
   else
      return false, 'unknown error', num
   end
end

function lfs.rmdir(path: string): boolean, string, integer
   local worked, why, num = os.execute('rmdir ' .. escapepath(path))
   if worked then
      return true, nil, nil
   elseif why == 'signal' then
      return false, why, num
   else
      return false, 'unknown error', num
   end
end

function lfs.attributes(path: string, sel: lfs.AttributeSelFM): lfs.FileMode
   assert(sel == 'mode', 'basic lfs only supports lfs.attributes(..., "mode")')
   -- simplified: only work out whether it is a file or directory.
   --
   -- we can work this out by just doing an io.open

   -- on windows:
   --
   -- file mode r
   --
   --          |        with /         | without /
   -- file     | Invalid argument, 22  | works
   -- dir      | Permission denied, 13 | Permission denied, 13
   -- notexist |        No such file or directory, 2
   --
   -- on unix:
   --
   -- file mode r
   --
   --          |        with /       | without /
   -- file     | Not a directory, 20 | works
   -- dir      |       works         | works
   -- notexist |        No such file or directory, 2

   local f, e, n = io.open(path .. '/', 'r')
   if f then
      -- we seem to be on unix => this must be a directory
      f:close()
      return 'directory'
   elseif n == 13 then
      return 'directory'
   elseif n == 22 or n == 20 then -- file
      return 'file'
   else
      return nil
   end
end

return lfs
