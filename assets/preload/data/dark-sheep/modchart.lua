local toTheLeft = true
local toTheRight = false
local strumXLocat = 0
local strumYLocat = 0


--START
function start(song) 
	setCamZoom(1.7)

	showOnlyStrums = true
	strumLineAlpha = 0 --dont forget that updates happen every 1/2 frames and since this is 24 fps most of the time, updates will run 12 times for each step
end


--UPDATE 
function update(elapsed) 

	--intro effects
	if curStep >= 12 and curStep < 32 then 
		strumLineAlpha = strumLineAlpha + .00333333333
	end

	if curStep >= 32  and curStep < 288 then
		showOnlyStrums = false
		strumLineAlpha = 1
		local currentBeat = (songPos / 1000)*(bpm/60)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 12 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 12 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
	end

	--swoozynotes
	if (curStep >= 576 and curStep < 640) or (curStep >=707 and curStep < 768) then
		swoozyNotes()
	end

	--cam zoom out
	if curStep == 1328 then
		tweenHudZoom(0.0001, 0.5)
	end
	
	
	
	
	--reset zoom out
	if curStep == 1342 then	
		setHudZoom = 1.03;
	end

	--reset note placements
	if curStep == 288 or curStep == 768 or curStep == 640 then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'], i)
			setActorY(_G['defaultStrum'..i..'Y'], i)
		end
	end


end


--BEAT
function beatHit(beat) 

end


--STEP
stepHitCount = 0; --this function is useful for finding out what section starts at what step of a song (1/4 of a beat) as it prints the result in powershell
function stepHit (beat) 
	print(stepHitCount);	
	stepHitCount = stepHitCount + 1;
end


--SWAP LEFT AND RIGHT
swaps = 0
function swapTime(void)
	if toTheLeft == true then
		toTheRight = true 
		toTheLeft = false
	elseif toTheRight == true then
		toTheRight = false 
		toTheLeft = true
	end
	print('swapped')
	swaps = swaps + 1
end


--SWOOZE
function swoozyNotes(void)

	local currentBeat = (songPos / 1000)*(bpm/60)
		
		for i=0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 62 * math.cos((currentBeat + i*0.3) * math.pi), i)
		end


		if toTheLeft == true then --
			strumXLocat = strumXLocat - 2.08333333
			for i=0,7 do
				setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
			end
			if strumXLocat <= -50 then
				swapTime()
			end
			print(strumXLocat)
		elseif toTheRight == true then
			strumXLocat = strumXLocat + 2.08333333
			for i=0,7 do
				setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
			end
			if strumXLocat >= 50 then
				swapTime()
			end
			print(strumXLocat)
		end
end