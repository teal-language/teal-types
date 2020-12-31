
local record argparse
	record Parser
		name: function(self: Parser, name: string): Parser
		description: function(self: Parser, description: string): Parser
		epilog: function(self: Parser, epilog: string): Parser

		flag: function(self: Parser, flag: string): Option
		flag: function(self: Parser, shortalias: string, longalias: string): Option

		parse: function(self: Parser, argv: {string}): {string:{string}|string|boolean}
		pparse: function(self: Parser, argv: {string}): boolean, {string:{string}|string|boolean} | string

		error: function(self: Parser, error: string)

		argument: function(self: Parser, name: string, description: string)

		get_usage: function(self: Parser): string

		option: function(self: Parser, name: string, description: string, default: string, convert: function | {function}, args: {string}, count: number | string): Option
		option: function(self: Parser, name: string, description: string, default: string, convert: {string:string}, args: {string}, count: number | string): Option

		require_command: function(self: Parser, require_command: boolean): Parser
		command_target: function(self: Parser, command_target: string): Parser

		command: function(self: Parser, name: string, description: string, epilog: string): Command

		record Opts
			name: string
			description: string
			epilog: string
		end
		metamethod __call: function(Parser, Opts): Parser
		metamethod __call: function(Parser, string, string, string): Parser
	end

	record Argument
		choices: function(self: Argument, choices: {string}): Argument

		convert: function(self: Argument, convert: function | {function}): Argument
		convert: function(self: Argument, convert: {string:string}): Argument

		args: function(self: Argument, args: string | number): Argument
	end

	record Option
		name: function(self: Option, name: string): Option
		description: function(self: Option, description: string): Option

		argname: function(self: Option, argname: string): Option

		count: function(self: Option, count: number | string): Option

		target: function(self: Option, target: string): Option

		args: function(self: Option, args: string|number): Option
	end

	record Command
		summary: function(self: Command, summary: string): Command
		description: function(self: Command, description: string): Command

		argument: function(self: Command, name: string, description: string): Argument

		option: function(self: Command, name: string, description: string): Option
	end

	metamethod __call: function(self: argparse, name: string, description: string, epilog: string): Parser
end

return argparse
