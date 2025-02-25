local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local assert = _tl_compat and _tl_compat.assert or assert; local io = _tl_compat and _tl_compat.io or io; local string = _tl_compat and _tl_compat.string or string



local ltn12 = require('vendored.ltn12')
local lfs = require('lfs')

local REPO_DIR = '..'

local function luarocks(subc)
   return assert(io.popen('luarocks ' .. subc))
end

local function excluded(name)
   local result =
   name:match('%.core$') or
   name:match('^compat53')

   return not not result
end

local function write_and_make_dir(path)
   local sf, e = io.open(path, 'wb')
   if not sf then

      local pathm
      for item in path:gmatch('[^\\/]*[\\/]') do
         pathm = (pathm or '') .. item
         lfs.mkdir(pathm)
      end
      sf, e = io.open(path, 'wb')
   end
   return sf, e
end


local module_to_localfpth = {}

local function istoplevel(name)
   return not name:match('%.')
end

local function scan_lib_dir(path, modname)
   for item in lfs.dir(path) do
      if item ~= '.' and item ~= '..' then
         local npath = path .. '/' .. item
         local name = (modname and (modname .. '.') or '') .. item
         if lfs.attributes(npath, 'mode') == 'directory' then
            scan_lib_dir(npath, name)
         elseif name:sub(-5):lower() == '.d.tl' then
            name = name:sub(1, -6)

            if name:sub(-5) == '.init' then
               name = name:sub(1, -6)
            end

            if module_to_localfpth[name] then
               print('collision', name)
            end
            module_to_localfpth[name] = npath
         end
      end
   end
end

for library in lfs.dir(REPO_DIR .. '/types') do
   if library ~= '.' and library ~= '..' then
      scan_lib_dir(REPO_DIR .. '/types/' .. library)
   end
end

local deploy_dir = assert(luarocks('config deploy_lua_dir'):read('l'), 'this script requires luarocks in your path')

local function name_to_dtlfile(name)
   return deploy_dir .. '/' .. name:gsub('%.', '/') .. '.d.tl'
end


local function scan_deploy_dir(path, modname)
   for item in lfs.dir(path) do
      if item ~= '.' and item ~= '..' then
         local npath = path .. '/' .. item
         local name = (modname and (modname .. '.') or '') .. item
         local ext = item:match('%.[^%.]+$')
         if ext then ext = ext:lower() end
         if lfs.attributes(npath, 'mode') == 'directory' then
            scan_deploy_dir(npath, name)
         elseif ext == '.lua' or ext == '.dll' or ext == '.so' then
            name = name:sub(1, -#ext - 1)

            if name:sub(-5) == '.init' then
               name = name:sub(1, -6)
            end

            local typath = module_to_localfpth[name]
            if typath then
               local newpath = name_to_dtlfile(name)

               assert(ltn12.pump.all(
               ltn12.source.file(io.open(typath, 'rb')),
               ltn12.sink.file(write_and_make_dir(newpath))))

            else

               if ext == '.lua' then
                  if lfs.attributes(npath:sub(1, -5) .. '.tl') then

                  elseif lfs.attributes(npath:sub(1, -5) .. '.d.tl') then

                     print('.d.tl exists but not in teal-types: ' .. name .. '\t(' .. npath:sub(1, -5) .. '.d.tl)')
                  elseif not excluded(name) and istoplevel(name) then
                     print('no .d.tl file: ' .. name .. '\t(' .. npath .. ')')
                  end
               elseif not excluded(name) and istoplevel(name) then
                  print('no .d.tl file: ' .. name .. '\t(' .. npath .. ')')
               end
            end
         end
      end
   end
end

scan_deploy_dir(deploy_dir)
scan_deploy_dir((assert(luarocks('config deploy_lib_dir'):read('l'), 'this script requires luarocks in your path')))
