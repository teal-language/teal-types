local record flux
	enum Easing
		"linear"
		"quadin"
		"quadout"
		"quadinout"
		"cubicin"
		"cubicout"
		"cubicinout"
		"quartin"
		"quartout"
		"quartinout"
		"quintin"
		"quintout"
		"quintinout"
		"expoin"
		"expoout"
		"expoinout"
		"sinein"
		"sineout"
		"sineinout"
		"circin"
		"circout"
		"circinout"
		"backin"
		"backout"
		"backinout"
		"elasticin"
		"elasticout"
		"elasticinout"
	end
	
	record Tween<T>
		ease: function(self: Tween<T>, type: Easing): Tween<T>
		delay: function(self: Tween<T>, time: number): Tween<T>
		onstart: function(self: Tween<T>, function()): Tween<T>
		onupdate: function(self: Tween<T>, function()): Tween<T>
		oncomplete: function(self: Tween<T>, function()): Tween<T>
		after: function<U>(self: Tween<U>, time: number, vars: U): Tween<U>
		after: function<U>(self: Tween<T>, obj: U, time: number, vars: U): Tween<T>
		stop: function(self: Tween<T>)
	end
	
	record Group
		update: function(self: Group, deltatime: number)
		to: function<K, V>(self: Group, obj: {K:V}, time: number, vars: {K:V}): Tween<{K:V}>
		to: function<T>(self: Group, obj: T, time: number, vars: T): Tween<T>
		-- group: function(self: Group): Group
	end
	
	update: function(deltatime: number)
	to: function<K, V>(obj: {K:V}, time: number, vars: {K:V}): Tween<{K:V}>
	to: function<T>(obj: T, time: number, vars: T): Tween<T>
	group: function(): Group
end

return flux