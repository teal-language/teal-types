local Parser = record
	Argument = record
		args: function(self: Argument, args: string | number)
		choices: function(self: Argument, choices: {string})

		convert: function(self: Argument, convert: function | {function})
		convert: function(self: Argument, convert: {string:string})
	end

	Option = record
		name: function(self: Option, name: string): Option
		description: function(self: Option, description: string): Option

		argname: function(self: Option, argname: string): Option

		count: function(self: Option, count: number | string): Option
	end

	Command = record
		summary: function(self: Command, summary: string): Command
		description: function(self: Command, description: string): Command

		argument: function(self: Command, name: string, description: string): Argument
	end

	-- FIXME: the config can also be set by calling the parser as a function
	name: function(self: Parser, name: string): Parser
	description: function(self: Parser, description: string): Parser
	epilog: function(self: Parser, epilog: string): Parser

	flag: function(self: Parser, flag: string): Option
	flag: function(self: Parser, shortalias: string, longalias: string): Option

	parse: function(self: Parser, argv: {string})
	pparse: function(self: Parser, argv: {string}): boolean, string

	error: function(self: Parser, error: string)

	argument: function(self: Parser, name: string, description: string)

	option: function(self: Parser, name: string, description: string, default: string, convert: function | {function}, args: {string}, count: number | string): Option
	option: function(self: Parser, name: string, description: string, default: string, convert: {string:string}, args: {string}, count: number | string): Option

	require_command: function(self: Parser, require_command: boolean): Parser
	command_target: function(self: Parser, command_target: string): Parser

	command: function(self: Parser, name: string, description: string, epilog: string): Command
end

local argparse: function(name: string, description: string, epilog: string): Parser

return argparse
