-- Copy .d.tl files from here to the luarocks tree
--
-- Copies files that have a matching .lua or .dll or similar in the tree.

local ltn12 = require'vendored.ltn12'

-- prefer an installed version if available.
local simplelfs = require'vendored.lfs'
local lfs: simplelfs = simplelfs
do
   local worked, reallfs = pcall(require, 'lfs')
   if worked then
      lfs = reallfs as simplelfs
   end
end

local REPO_DIR <const> = '..'

local function luarocks(subc: string): FILE
   return assert(io.popen('luarocks ' .. subc))
end

local function excluded(name: string): boolean
   local result =
      name:match '%.core$'
   or name:match '^compat53'

   return not not result
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

-- first scan the local directories.
local module_to_localfpth = {}

local function istoplevel(name: string): boolean
   return not name:match '%.'
end

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

local deploy_dir = assert(luarocks 'config deploy_lua_dir --local':read(), 'this script requires luarocks in your path')

local function name_to_dtlfile(name: string): string
   return deploy_dir .. '/' .. name:gsub('%.', '/') .. '.d.tl'
end

-- now scan the luarocks tree
local function scan_deploy_dir(path: string, modname ?: string)
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
            -- also get rid of .init on the end
            if name:sub(-5) == '.init' then
               name = name:sub(1, -6)
            end

            local typath = module_to_localfpth[name]
            if typath then
               local newpath = name_to_dtlfile(name)
               -- print(newpath, typath)
               assert(ltn12.pump.all(
                  ltn12.source.file(io.open(typath, 'rb')),
                  ltn12.sink.file(write_and_make_dir(newpath))
               ))
            else
               -- check if there is already a d.tl or .tl file
               if ext == '.lua' then
                  if lfs.attributes(npath:sub(1, -5) .. '.tl', 'mode') then
                     -- .tl exists: nothing to do here
                  elseif lfs.attributes(npath:sub(1, -5) .. '.d.tl', 'mode') then
                     -- .d.tl exists but not here
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
scan_deploy_dir((assert(luarocks 'config deploy_lib_dir --local':read(), 'this script requires luarocks in your path')))
