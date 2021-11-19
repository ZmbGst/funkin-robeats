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
		local currentBeat = (songPos / 1000)*(bpm/200)
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 12 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 12 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
	end


	--note teleportation
	if curStep == 300 then

		for i=0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] - 30, i)
		end
	end

	if curStep == 302 then
		for i=0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] + 40, i)
		end
	end

	if curStep == 320 then
		for i=0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] +10, i)
			setActorX(_G['defaultStrum'..i..'X'] +10, i)
		end
	end

	if curStep == 332  or curStep == 334 or curStep == 336 then 
		strumXLocat = strumXLocat - 5
		strumYLocat = strumYLocat - 3
		for i= 0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] - strumYLocat, i)
			setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
		end
	end

	if curStep == 340 then
		strumXLocat = 0
		strumYLocat = 0
		for i = 0,7 do
			setActorY(_G['defaultStrum'..i..'Y'], i)
			setActorX(_G['defaultStrum'..i..'X'], i)
		end
	end

	if curStep == 360 or curStep == 364 or curStep == 368 then
		strumYLocat = strumYLocat - 3
		for i = 0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] - strumYLocat, i)
		end
	end

	
	--beat pattern find a way to make this into a function since this pattern happens 3 times in a row. 
	if curStep == 448 or curStep == 456 or curStep == 464 or curStep == 480 or curStep == 488 or curStep == 496 or curStep == 512 or curStep == 520 or curStep == 528 or curStep == 544 or curStep == 552 or curStep == 560 then
		strumXLocat = strumXLocat - 10
		for i = 0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
		end
	end

	if curStep == 472 or curStep == 476 or curStep == 504 or curStep == 508 or curStep == 536 or curStep == 540 then
		strumXLocat = strumXLocat + 15
		for i = 0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
		end
	end

	if (curStep >= 568 and curStep < 576) then
		strumXLocat = strumXLocat + 30 / (8)
		for i = 0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
		end
	end


	--swoozynotes
	if (curStep >= 576 and curStep < 640) or (curStep >=704 and curStep < 768) then
		swoozyNotes()
	end


	--fever mode
	if curStep >= 576 and curStep < 768 then
		showOnlyStrums = true;
	end

	if curStep == 832 then
		showOnlyStrums = false;
	end


	--cam zooms
	if curStep == 384 then
		tweenHudZoom(1.1, 5.2)
	end
	
	if curStep == 646 or curStep == 678 then
		tweenHudZoom(1.1, 0.2)
	end
	
	if curStep == 800 then
		tweenHudZoom(1.04, 0.2)
	end

	if curStep == 808 then
		tweenHudZoom(1.08, 0.2)
	end

	if curStep == 816 then 
		tweenHudZoom(1.1, 1.4)
	end

	if curStep == 1328 then
		strumLine1Visible = false; 
		tweenHudZoom(0.0001, 0.5)
	end


	--let player see spotco notes
	if curStep == 1728 then
		strumLine1Visible = true;
	end
	
	--ending disappear FIX NOTES NOT FULLY DISAPPEARING 
	if curStep >= 2718 and curStep < 2784 then
		showOnlyStrums = true;
		strumLineAlpha = strumLineAlpha - (1/780)
		if curStep == 2783 then
			strumLineAlpha = 0
		end
	end
	
	--reset note rotation 
	if curStep == 288 then
		for i=0,7 do
			setActorAngle(getActorAngle(i) * 0, i) 
    	end
	end

	--reset zoom out
	if curStep == 576 or curStep == 1342 then	
		setHudZoom = 1.03;
	end

	--reset note placements
	if curStep == 288 or curStep == 384 or curStep == 768 or curStep == 640 then
		strumXLocat = 0
		strumYLocat = 0
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