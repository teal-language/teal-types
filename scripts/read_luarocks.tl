-- Copy .d.tl files from the luarocks tree to this repository
--
-- Files that match a module from luarocks are copied into the matching
-- directory here, creating it if it does not exist.
--
-- Files that don't have a corresponding rock are listed and not copied.

local ltn12 = require'ltn12'
local lfs = require'lfs'

local REPO_DIR <const> = '..'

local function luarocks(subc: string): FILE
   return assert(io.popen('luarocks ' .. subc))
end

local deploy_dir = luarocks 'config deploy_lua_dir':read 'l'
if not deploy_dir then
   error 'this script requires luarocks in your path'
end

-- first scan the local directories.
local module_to_localfpth = {}

local function scan_lib_dir(path: string, modname ?: string)
   for item in lfs.dir(path) do
      if item ~= '.' and item ~= '..' then
         local npath = path .. '/' .. item
         local name = (modname and (modname .. '.') or '') .. item
         if lfs.attributes(npath, 'mode') == 'directory' then
            scan_lib_dir(npath, name)
         elseif name:sub(-5):lower() == '.d.tl' then
            name = name:sub(1, -6)
            -- also get rid of .init on the end
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

local function write_and_make_dir(path: string): FILE, string
   local sf, e = io.open(path, 'wb')
   if not sf then
      -- go through the directories from the start
      local pathm: string
      for item in path:gmatch('[^\\/]*[\\/]') do
         pathm = (pathm or '') .. item
         lfs.mkdir(pathm)
      end
      sf, e = io.open(path, 'wb')
   end
   return sf, e
end

-- now scan the luarocks tree
local function scan_deploy_dir(path: string, modname ?: string)
   for item in lfs.dir(path) do
      if item ~= '.' and item ~= '..' then
         local npath = path .. '/' .. item
         local name = (modname and (modname .. '.') or '') .. item
         if lfs.attributes(npath, 'mode') == 'directory' then
            scan_deploy_dir(npath, name)
         elseif name:sub(-5):lower() == '.d.tl' then
            name = name:sub(1, -6)
            -- also get rid of .init on the end
            if name:sub(-5) == '.init' then
               name = name:sub(1, -6)
            end

            local typath = module_to_localfpth[name]
            if typath then
               assert(ltn12.pump.all(
                  ltn12.source.file(io.open(npath, 'rb')),
                  ltn12.sink.file(io.open(typath, 'wb'))
               ))
            else
               -- find out what library it comes from with luarocks
               local result = luarocks('which "' .. name .. '"'):read 'a'

               if result == '' then -- not found
                  print('file not copied: ' .. name .. '\t(' .. npath .. ')')
               else
                  local module = result:match('%(provided by ([^ ]+) [^ ]+%)')
                  print(module)

                  local newloc = REPO_DIR .. '/types/' .. module .. npath:sub(#deploy_dir + 1)
                  print(newloc)

                  assert(ltn12.pump.all(
                     ltn12.source.file(io.open(npath, 'rb')),
                     ltn12.sink.file(write_and_make_dir(newloc))
                  ))
               end

               -- os.execute('luarocks which ' .. name)
            end
         end
      end
   end
end

scan_deploy_dir(deploy_dir)
