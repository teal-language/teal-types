local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local assert = _tl_compat and _tl_compat.assert or assert; local io = _tl_compat and _tl_compat.io or io; local pcall = _tl_compat and _tl_compat.pcall or pcall; local string = _tl_compat and _tl_compat.string or string






local ltn12 = require('vendored.ltn12')


local simplelfs = require('vendored.lfs')
local lfs = simplelfs
do
   local worked, reallfs = pcall(require, 'lfs')
   if worked then
      lfs = reallfs
   end
end

local REPO_DIR = '..'

local function luarocks(subc)
   return assert(io.popen('luarocks ' .. subc))
end

local deploy_dir = luarocks('config deploy_lua_dir --local'):read()
if not deploy_dir then
   error('this script requires luarocks in your path')
end


local module_to_localfpth = {}

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


local function scan_deploy_dir(path, modname)
   for item in lfs.dir(path) do
      if item ~= '.' and item ~= '..' then
         local npath = path .. '/' .. item
         local name = (modname and (modname .. '.') or '') .. item
         if lfs.attributes(npath, 'mode') == 'directory' then
            scan_deploy_dir(npath, name)
         elseif name:sub(-5):lower() == '.d.tl' then
            name = name:sub(1, -6)

            if name:sub(-5) == '.init' then
               name = name:sub(1, -6)
            end

            local typath = module_to_localfpth[name]
            if typath then
               assert(ltn12.pump.all(
               ltn12.source.file(io.open(npath, 'rb')),
               ltn12.sink.file(io.open(typath, 'wb'))))

            else

               local result = luarocks('which "' .. name .. '"'):read('a')

               if result == '' then
                  print('file not copied: ' .. name .. '\t(' .. npath .. ')')
               else
                  local module = result:match('%(provided by ([^ ]+) [^ ]+%)')
                  print(module)

                  local newloc = REPO_DIR .. '/types/' .. module .. npath:sub(#deploy_dir + 1)
                  print(newloc)

                  assert(ltn12.pump.all(
                  ltn12.source.file(io.open(npath, 'rb')),
                  ltn12.sink.file(write_and_make_dir(newloc))))

               end


            end
         end
      end
   end
end

scan_deploy_dir(deploy_dir)
