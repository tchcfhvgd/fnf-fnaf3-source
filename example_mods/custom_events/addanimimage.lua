function onEvent(name, value1, value2)
	makeAnimatedLuaSprite(value1, value1, 0, 0)
	setObjectCamera(value1, 'camHUD')
	addLuaSprite(value1, true)
	addAnimationByPrefix(value1, value1, 'idle', 24, true)
end