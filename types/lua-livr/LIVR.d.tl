--
-- https://luarocks.org/modules/fperrad/lua-livr
--

local record LIVR
   type Data = {string:any}
   type Error = string|table
   type ValidatorFn = function(value: any, all: Data): any, Error
   type Builder = function(builders: {string:Builder}, ...: any): ValidatorFn
   type Rule = string|table

   record Alias
      name: string
      rules: Rule
      error: string
   end

   record Validator
      prepare: function(self: Validator): Validator
      validate: function(self: Validator, data: Data): Data, string|{string:Error}
      register_rules: function(self: Validator, rules: {string:Builder}): Validator
      register_aliased_rule: function(self: Validator, alias: Alias): Validator
      get_rules: function(self: Validator): {string:Builder}
   end

   new: function(rules: {string:Rule}, is_auto_trim: boolean): Validator
   register_default_rules: function(rules: {string:Builder})
   register_aliased_default_rule: function(alias: Alias)

   default_rules: {string:Builder}
   default_auto_trim: boolean
   _NAME: string
   _VERSION: string
   _DESCRIPTION: string
   _COPYRIGHT: string
end

return LIVR
