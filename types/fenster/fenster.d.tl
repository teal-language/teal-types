--[[

Type definitions for lua-fenster
https://github.com/jonasgeiler/lua-fenster
https://luarocks.org/modules/jonasgeiler/fenster

--]]

local record fenster

	record Window
		userdata

		close: function(self: Window)
		loop: function(self: Window): boolean
		set: function(self: Window, x: integer, y: integer, color: integer)
		get: function(self: Window, x: integer, y: integer): integer
		clear: function(self: Window, color: integer)

		metamethod __index: function(self: Window, key: string): any
		metamethod __gc: function(self: Window)
		metamethod __close: function(self: Window)
		metamethod __tostring: function(self: Window): string

		-- properties using __index
		keys: {boolean}
		delta: number
		mousex: integer
		mousey: integer
		mousedown: boolean
		modcontrol: boolean
		modshift: boolean
		modalt: boolean
		modgui: boolean
		width: integer
		height: integer
		title: string
		scale: integer
		targetfps: number
	end

	open: function(width: integer, height: integer, title: string, scale: integer, targetfps: number): Window
	sleep: function(milliseconds: integer)
	time: function(): integer
	rgb: function(redorcolor: integer, green: integer, blue: integer): integer, integer, integer

	-- methods used as functions
	close: function(window: Window)
	loop: function(window: Window): boolean
	set: function(window: Window, x: integer, y: integer, color: integer)
	get: function(window: Window, x: integer, y: integer): integer
	clear: function(window: Window, color: integer)

end

return fenster