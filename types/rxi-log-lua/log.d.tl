local record log
	enum Level
		"trace"
		"debug"
		"info"
		"warn"
		"error"
		"fatal"
	end
	type LogFunction = function(...: any)
	
	usecolor: boolean
	outfile: string
	level: Level
	
	trace: LogFunction
	debug: LogFunction
	info: LogFunction
	warn: LogFunction
	error: LogFunction
	fatal: LogFunction
end

return log