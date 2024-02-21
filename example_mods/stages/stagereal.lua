-- Using Lulu's optimizations to avoid game lagging.

-- TODO: Add in sprites that events add to the stage. (If there are any)

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createHoaxes() -- Create hoaxes.
end

function createStage()
	local stages = {
		{ name = 'background', image = 'BGs/hoaxing', posX = 450, posY = -300, scrollX = 1.2, scrollY = 1.2, scaleX = 1.2, scaleY = 1.2, add = false },
		{ name = 'table', image = 'BGs/hoaxtable', posX = 0, posY = 600, scrollX = 1, scrollY = 1, scaleX = 0.7, scaleY = 0.7, add = false },
	}

	for _, stage in ipairs(stages) do
		precacheImage(stage.image)

		if stage.name == 'background' then
			makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
			addAnimationByPrefix('background', 'anim', 'idle', 24, true)
			playAnim(stage.name, 'anim', true)
		else
			makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		end

		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', true)
	end

	setObjectOrder('background', 0)
	setObjectOrder('table', 2)
end

function createHoaxes()
	local hoaxes = {
		{ name = 'phtfreddy', image = 'Chars/phtfreddy', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = 2500, posY = 20, scrollX = 1, scrollY = 1, scaleX = 1.1, scaleY = 1.1, add = false },
		{ name = 'phtchica', image = 'Chars/phtchica', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = 2500, posY = 20, scrollX = 1, scrollY = 1, scaleX = 1.1, scaleY = 1.1, add = false },
		{ name = 'phtbonnie', image = 'Chars/phtbonnie', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = 2500, posY = 20, scrollX = 1, scrollY = 1, scaleX = 1.1, scaleY = 1.1, add = false },
		{ name = 'chromefreddy', image = 'Chars/chromefreddy', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = true, posX = -200, posY = 20, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = false },
		{ name = 'shadowbb', image = 'Chars/shadowbb', animation = 'anim', xmlPrefix = 'idle', fps = 24, loop = false, posX = 0, posY = 0, scrollX = 1, scrollY = 1, scaleX = 1, scaleY = 1, add = true },
	}

	for _, hoax in ipairs(hoaxes) do
		precacheImage(hoax.image)
		makeAnimatedLuaSprite(hoax.name, hoax.image, hoax.posX, hoax.posY)
		setScrollFactor(hoax.name, hoax.scrollX, hoax.scrollY)
		addAnimationByPrefix(hoax.name, hoax.animation, hoax.xmlPrefix, hoax.fps, hoax.loop)
		scaleObject(hoax.name, hoax.scaleX, hoax.scaleY)
		addLuaSprite(hoax.name, hoax.add)
		setProperty(hoax.name .. '.visible', false)

		if hoax.name == 'shadowbb' then
			setObjectCamera(hoax.name, 'camJump')
		end
	end
end

function onStepHit()
	if curStep == 250 then
		-- Toggle visibility of the next hoax.
		setProperty('phtfreddy.visible', true)

		-- Modify object order.
		setObjectOrder('phtfreddy', 1)

		-- Tween the hoax to make it look like it moves.
		doTweenX('hoax1', 'phtfreddy', -400, 15, 'linear')

	elseif curStep == 294 then
		-- Toggle visibility of the next hoax.
		setProperty('phtchica.visible', true)

		-- Modify object order.
		setObjectOrder('phtchica', 1)

		-- Tween the hoax to make it look like it moves.
		doTweenX('hoax2', 'phtchica', -400, 12, 'linear')

	elseif curStep == 330 then
		-- Toggle visibility of the next hoax.
		setProperty('phtbonnie.visible', true)

		-- Modify object order.
		setObjectOrder('phtbonnie', 1)

		-- Tween the hoax to make it look like it moves.
		doTweenX('hoax3', 'phtbonnie', -400, 14, 'linear')

	elseif curStep == 512 then
		-- Toggle visibility of the next hoax.
		setProperty('shadowbb.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('shadowbb', 'anim', true)

	elseif curStep == 560 then
		-- Remove BB.
		removeLuaSprite('shadowbb', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

	elseif curStep == 848 then
		-- Toggle visibility of the next hoax.
		setProperty('chromefreddy.visible', true)
		
		-- Modify object order.
		setObjectOrder('chromefreddy', 1)

		-- Tween the hoax to make it look like it moves.
		doTweenX('hoax4', 'chromefreddy', 3500, 20, 'linear')
	end
end

function onTweenCompleted(tag)
	-- Remove previous hoax.
	local validTags = {
		'hoax1',
		'hoax2',
		'hoax3',
		'hoax4'
	}

	if validTags[tag] then
		removeLuaSprite(tag, true)
	end

	-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
	runHaxeCode([[
		Paths.clearUnusedMemory();
	]])
end