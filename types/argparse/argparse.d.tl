global ArgparseParser = record
	Argument = record
		choices: function(self: Argument, choices: {string}): Argument

		convert: function(self: Argument, convert: function | {function}): Argument
		convert: function(self: Argument, convert: {string:string}): Argument

		args: function(self: Argument, args: string | number): Argument
	end

	Option = record
		name: function(self: Option, name: string): Option
		description: function(self: Option, description: string): Option

		argname: function(self: Option, argname: string): Option

		count: function(self: Option, count: number | string): Option

		target: function(self: Option, target: string): Option

		args: function(self: Option, args: string|number): Option
	end

	Command = record
		summary: function(self: Command, summary: string): Command
		description: function(self: Command, description: string): Command

		argument: function(self: Command, name: string, description: string): Argument
	end

	-- FIXME: the config can also be set by calling the parser as a function
	name: function(self: ArgparseParser, name: string): ArgparseParser
	description: function(self: ArgparseParser, description: string): ArgparseParser
	epilog: function(self: ArgparseParser, epilog: string): ArgparseParser

	flag: function(self: ArgparseParser, flag: string): Option
	flag: function(self: ArgparseParser, shortalias: string, longalias: string): Option

	parse: function(self: ArgparseParser, argv: {string}): {string:{string}|string|boolean}
	pparse: function(self: ArgparseParser, argv: {string}): boolean, {string:{string}|string|boolean} | string

	error: function(self: ArgparseParser, error: string)

	argument: function(self: ArgparseParser, name: string, description: string)

	option: function(self: ArgparseParser, name: string, description: string, default: string, convert: function | {function}, args: {string}, count: number | string): Option
	option: function(self: ArgparseParser, name: string, description: string, default: string, convert: {string:string}, args: {string}, count: number | string): Option

	require_command: function(self: ArgparseParser, require_command: boolean): ArgparseParser
	command_target: function(self: ArgparseParser, command_target: string): ArgparseParser

	command: function(self: ArgparseParser, name: string, description: string, epilog: string): Command
end

local argparse: function(name: string, description: string, epilog: string): ArgparseParser

return argparse
