local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local assert = _tl_compat and _tl_compat.assert or assert; local coroutine = _tl_compat and _tl_compat.coroutine or coroutine; local io = _tl_compat and _tl_compat.io or io; local os = _tl_compat and _tl_compat.os or os; local string = _tl_compat and _tl_compat.string or string


local lfs = { DirObj = {} }































local is_windows = (os.getenv('OS') or ''):match('[Ww]indows')

local function escapepath(path)
   if is_windows then

      return '"' .. path .. '"'
   else

      return "'" .. path:gsub("'", [['\'']]) .. "'"
   end
end

local dirobjmeta = {
   __close = function(self)
      self:close()
   end,
}

function lfs.dir(path)
   local cmdbase = is_windows and 'dir /A /B ' or 'ls -a '
   local fullcmd = cmdbase .. escapepath(path)
   local coro = coroutine.create(function()
      for subitem in io.popen(fullcmd):lines() do
         coroutine.yield(subitem)
      end
   end)

   local obj = setmetatable({
      next = function(_)
         if not coro then return nil end

         local worked, nex = coroutine.resume(coro)
         if not worked or not nex then
            if coroutine.close then coroutine.close(coro) end
            coro = nil
            return nil
         else
            return nex
         end
      end,
      close = function(_)
         if coro then
            if coroutine.close then coroutine.close(coro) end
            coro = nil
         end
      end,
   }, dirobjmeta)

   return obj.next, obj, nil, obj
end

function lfs.mkdir(path)
   local worked, why, num = os.execute('mkdir ' .. escapepath(path))
   if worked then
      return true, nil, nil
   elseif why == 'signal' then
      return false, why, num
   else
      return false, 'unknown error', num
   end
end

function lfs.rmdir(path)
   local worked, why, num = os.execute('rmdir ' .. escapepath(path))
   if worked then
      return true, nil, nil
   elseif why == 'signal' then
      return false, why, num
   else
      return false, 'unknown error', num
   end
end

function lfs.attributes(path, sel)
   assert(sel == 'mode', 'basic lfs only supports lfs.attributes(..., "mode")')






















   local f, e, n = io.open(path .. '/', 'r')
   if f then

      f:close()
      return 'directory'
   elseif n == 13 then
      return 'directory'
   elseif n == 22 or n == 20 then
      return 'file'
   else
      return nil
   end
end

return lfs
