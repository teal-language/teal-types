-- Depends on love definition from https://github.com/MikuAuahDark/love2d-tl

local record baton
	record Configuration
		controls: {string:{string}}
		pairs: {string:{string, string, string, string}}
		joystick: love.joystick.Joystick
		deadzone: number
		squareDeadzone: boolean
	end
	
	enum ActiveDevice
		"kbm"
		"joy"
		"none"
	end
	
	record Player
		config: Configuration
		
		update: function(self: Player)
		getRaw: function(self: Player, name: string): number
		get: function(self: Player, name: string): number
		get: function(self: Player, name: string): number, number
		down: function(self: Player, name: string): boolean
		pressed: function(self: Player, name: string): boolean
		released: function(self: Player, name: string): boolean
		
		getActiveDevice: function(self: Player): ActiveDevice
		_activeDevice: ActiveDevice
	end
	
	new: function(config: Configuration): Player
end

return baton
