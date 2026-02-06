local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local io = _tl_compat and _tl_compat.io or io; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local os = _tl_compat and _tl_compat.os or os; local pairs = _tl_compat and _tl_compat.pairs or pairs; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table; local lfs = require("lfs")

local ROCKSPEC_TEMPLATE
do
   local template_file = io.open("./scripts/rockspec-types-template.rockspec", "r")
   ROCKSPEC_TEMPLATE = template_file:read("*all")
   template_file:close()
end


local function exec(command)
   local handle = io.popen(command)
   local result = handle:read("*a")
   handle:close()
   return result
end

local function trim(s)
   return s:match("^%s*(.-)%s*$")
end

local function get_previous_sha()
   local previous_sha_file = io.open("./scripts/previous-sha", "r")

   if previous_sha_file == nil then return "5cf694b54a5cf9038d22e44c78508dc7a88ae0b4" end
   local previous_sha = previous_sha_file:read("*all")
   previous_sha_file:close()
   return trim(previous_sha)
end

local function get_changed_files(previous_sha)
   return exec(string.format("git diff --name-only %s HEAD ./types", previous_sha))
end

local function filter_changed_modules(changed_files)
   local output = {}

   for str in string.gmatch(changed_files, "([^\n]+)") do
      local module, filepath = string.match(str, "^types/(.-)/(.-%.d%.tl)$")
      if module and filepath then
         output[module] = true
      end
   end

   return output
end






local function get_rockspecs()
   local output = {}
   for file in lfs.dir("./rockspecs") do
      if file ~= "." and file ~= ".." then
         local f = './rockspecs/' .. file

         if lfs.attributes(f, "mode") == "file" then
            local module, version = string.match(file, "^(.-)%-tl%-type%-(.-)%-1%.rockspec$")
            if module and version then output[module] = { version = version, filename = f } end
         end
      end
   end
   return output
end

local function split_filepath(filepath)
   local output = {}
   for str in string.gmatch(filepath, "([^/]+)") do
      table.insert(output, str)
   end
   return output
end

local function format_files(files_in_module)
   local output = {}
   for i, file in ipairs(files_in_module) do
      local file_parts = split_filepath(file)
      if #file_parts < 4 then
         error("Something has gone awry! Maybe a rogue file has shown up in types? Perhaps this code here has a bug in it?")
      elseif #file_parts == 4 then
         output[i] = '         "' .. table.concat(file_parts, "/", 2) .. '",'
      else

         output[i] = '         ["' .. table.concat(file_parts, ".", 4):sub(1, -6) .. '"] = ' .. '"' .. table.concat(file_parts, "/", 2) .. '",'
      end

   end

   return table.concat(output, "\n")

end

local function get_files_in_module(module_path, all_files)
   all_files = all_files or {}
   for file in lfs.dir(module_path) do
      if file ~= "." and file ~= ".." then
         local f = module_path .. '/' .. file

         local file_or_dir = lfs.attributes(f, "mode")
         if file_or_dir == "file" then
            if string.match(file, "^.-%.d%.tl$") then
               table.insert(all_files, f)
            end
         elseif file_or_dir == "directory" then
            get_files_in_module(f, all_files)
         end
      end
   end
   return all_files
end

local function write_new_rockspec(module_name, version)
   version = version or "0.0.1"
   local rockspec_module = string.lower(module_name)
   local files_in_module = get_files_in_module("./types/" .. module_name)
   local files_string = format_files(files_in_module)
   local rockspec = string.format(ROCKSPEC_TEMPLATE, rockspec_module, version, module_name, files_string)
   local filepath = "./rockspecs/" .. rockspec_module .. "-tl-type-" .. version .. "-1.rockspec"

   local output_file = io.open(filepath, "w")
   output_file:write(rockspec)
   output_file:close()

   return filepath
end

local function update_rockspec(module_name, old_info)
   local major_minor, patch = string.match(old_info.version, "(%d%.%d%.)(%d)")
   patch = tostring(tonumber(patch) + 1)
   local new_version = major_minor .. patch
   os.remove(old_info.filename)
   return write_new_rockspec(module_name, new_version)
end

local function get_current_sha()
   return exec("git rev-parse --verify HEAD")
end

local function write_current_sha()
   local current_sha = get_current_sha()
   local previous_sha_file = io.open("./scripts/previous-sha", "w")
   previous_sha_file:write(current_sha)
   previous_sha_file:close()
end

local function write_rockspecs(rockspecs)
   local updated_rockspecs = io.open("./scripts/updated-rockspecs.txt", "w")
   updated_rockspecs:write(table.concat(rockspecs, "\n"))
   updated_rockspecs:close()
end

local function main()
   local previous_sha = get_previous_sha()
   local changed_files = get_changed_files(previous_sha)
   local output = filter_changed_modules(changed_files)
   local rockspecs = get_rockspecs()

   local rockspec
   local new_or_updated_rockspecs = {}
   for module_to_update, _ in pairs(output) do



      if rockspecs[string.lower(module_to_update)] then
         rockspec = update_rockspec(module_to_update, rockspecs[module_to_update])
      else
         rockspec = write_new_rockspec(module_to_update)
      end
      table.insert(new_or_updated_rockspecs, rockspec)
   end

   if #new_or_updated_rockspecs > 0 then
      print(table.concat(new_or_updated_rockspecs, "\n"))
      write_current_sha()
      write_rockspecs(new_or_updated_rockspecs)
   end
end

main()
