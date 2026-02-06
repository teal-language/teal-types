local lfs = require("lfs")

local ROCKSPEC_TEMPLATE: string
do
   local template_file = io.open("./scripts/rockspec-types-template.rockspec", "r")
   ROCKSPEC_TEMPLATE = template_file:read("*all")
   template_file:close()
end

-- super quick exec.
local function exec(command: string): string
   local handle = io.popen(command)
   local result = handle:read("*a")
   handle:close()
   return result
end

local function trim(s: string): string
   return s:match "^%s*(.-)%s*$"
end

local function get_previous_sha(): string
   local previous_sha_file = io.open("./scripts/previous-sha", "r")
   -- default to the first commit
   if previous_sha_file == nil then return "5cf694b54a5cf9038d22e44c78508dc7a88ae0b4" end
   local previous_sha = previous_sha_file:read("*all")
   previous_sha_file:close()
   return trim(previous_sha)
end

local function get_changed_files(previous_sha: string): string
   return exec(string.format("git diff --name-only %s HEAD ./types", previous_sha))
end

local function filter_changed_modules(changed_files: string): {string: boolean}
   local output: {string: boolean} = {}
   
   for str in string.gmatch(changed_files, "([^\n]+)") do
      local module, filepath = string.match(str, "^types/(.-)/(.-%.d%.tl)$")
      if module and filepath then
         output[module] = true
      end
   end
   
   return output
end

local interface rockspec_info
   version: string
   filename: string
end

local function get_rockspecs(): {string: rockspec_info}
   local output: {string: rockspec_info} = {}
   for file in lfs.dir("./rockspecs") do
      if file ~= "." and file ~= ".." then
         local f = './rockspecs/'..file

         if lfs.attributes(f, "mode") == "file" then
            local module, version = string.match(file, "^(.-)%-tl%-type%-(.-)%-1%.rockspec$")
            if module and version then output[module] = {version=version, filename=f} end
         end
      end
   end
   return output
end

local function split_filepath(filepath: string): {string}
   local output: {string} = {}
   for str in string.gmatch(filepath, "([^/]+)") do
      table.insert(output, str)
   end
   return output
end

local function format_files(files_in_module: {string}): string
   local output: {string} = {}
   for i, file in ipairs(files_in_module) do
      local file_parts = split_filepath(file)
      if #file_parts < 4 then
         error("Something has gone awry! Maybe a rogue file has shown up in types? Perhaps this code here has a bug in it?")
      elseif #file_parts == 4 then
         output[i] = '         "' .. table.concat(file_parts, "/", 2) .. '",'
      else
         -- the sub -6 removes the .d.tl at the end of the filename
         output[i] = '         ["' .. table.concat(file_parts, ".", 4):sub(1, -6) .. '"] = ' .. '"' .. table.concat(file_parts, "/", 2) .. '",'
      end

   end

   return table.concat(output, "\n")

end

local function get_files_in_module(module_path: string, all_files?: {string}): {string}
   all_files = all_files or {}
   for file in lfs.dir(module_path) do
      if file ~= "." and file ~= ".." then
         local f = module_path .. '/'.. file

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

local function write_new_rockspec(module_name: string, version?: string): string
   version = version or "0.0.1"
   local rockspec_module: string = string.lower(module_name)
   local files_in_module: {string} = get_files_in_module("./types/" .. module_name)
   local files_string = format_files(files_in_module)
   local rockspec = string.format(ROCKSPEC_TEMPLATE, rockspec_module, version, module_name, files_string)
   local filepath = "./rockspecs/" .. rockspec_module .. "-tl-type-" .. version .. "-1.rockspec"

   local output_file = io.open(filepath, "w")
   output_file:write(rockspec)
   output_file:close()

   return filepath
end

local function update_rockspec(module_name: string, old_info: rockspec_info): string
   local major_minor, patch = string.match(old_info.version, "(%d%.%d%.)(%d)")
   patch = tostring(tonumber(patch) + 1)
   local new_version = major_minor .. patch
   os.remove(old_info.filename)
   return write_new_rockspec(module_name, new_version)
end

local function get_current_sha(): string
   return exec("git rev-parse --verify HEAD")
end

local function write_current_sha()
   local current_sha = get_current_sha()
   local previous_sha_file = io.open("./scripts/previous-sha", "w")
   previous_sha_file:write(current_sha)
   previous_sha_file:close()
end

local function write_rockspecs(rockspecs: {string})
   local updated_rockspecs = io.open("./scripts/updated-rockspecs.txt", "w")
   updated_rockspecs:write(table.concat(rockspecs, "\n"))
   updated_rockspecs:close()
end

local function main()
   local previous_sha = get_previous_sha()
   local changed_files = get_changed_files(previous_sha)
   local output = filter_changed_modules(changed_files)
   local rockspecs = get_rockspecs()
   
   local rockspec: string
   local new_or_updated_rockspecs: {string} = {} 
   for module_to_update, _ in pairs(output) do
      -- rockspec files are always lowercase, but modules in ./types might not be,
      -- so do the compare in lowercase and then correctly handle lowercasing
      -- the rockspec filename in the write_new_rockspec
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
