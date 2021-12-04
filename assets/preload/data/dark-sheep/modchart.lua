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
	if curStep == 300 or curStep == 2508 then

		for i=0,7 do
			if downscroll then
				setActorY(_G['defaultStrum'..i..'Y'] - 30, i)
			else
				setActorY(_G['defaultStrum'..i..'Y'] + 30, i)
			end
		
		end
	end

	if curStep == 302 or curStep == 2510 then
		for i=0,7 do
			if downscroll then
				setActorY(_G['defaultStrum'..i..'Y'] + 40, i)
			else 
				setActorY(_G['defaultStrum'..i..'Y'] - 40, i)
			end
		end
	end

	if curStep == 320 or curStep == 2528 then
		for i=0,7 do
			if downscroll then
				setActorY(_G['defaultStrum'..i..'Y'] +10, i)
			else
				setActorY(_G['defaultStrum'..i..'Y'] -10, i)
			end

			setActorX(_G['defaultStrum'..i..'X'] +10, i)
		end
	end

	if curStep == 332  or curStep == 334 or curStep == 336 or curStep == 2540 or curStep == 2542 or curStep == 2544 then 
		strumXLocat = strumXLocat - 5
		if downscroll then
			strumYLocat = strumYLocat - 1
		else
			strumYLocat = strumYLocat + 1
		end
		for i= 0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] - strumYLocat, i)
			setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
		end
	end

	if curStep == 340 or curStep == 2548 then
		strumXLocat = 0
		strumYLocat = 0
		for i = 0,7 do
			setActorY(_G['defaultStrum'..i..'Y'], i)
			setActorX(_G['defaultStrum'..i..'X'], i)
		end
	end

	if curStep == 360 or curStep == 364 or curStep == 368 or curStep == 2568 or curStep == 2572 or curStep == 2576 then
		if downscroll then
			strumYLocat = strumYLocat - 3
		else
			strumYLocat = strumYLocat + 3
		end
	
		for i = 0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] - strumYLocat, i)
		end
	end

	if (curStep >= 568 and curStep < 576) or (curStep >= 2232 and curStep < 2240) then
		strumXLocat = strumXLocat + 18 / (8)
		for i = 0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
		end
	end


	--swoozynotes
	if (curStep >= 576 and curStep < 640) or (curStep >=704 and curStep < 768) or (curStep >= 2240 and curStep < 2304) or (curStep >= 2368 and curStep < 2432) then
		swoozyNotes()
	end


	--fever mode
	if (curStep >= 576 and curStep < 768) or (curStep >= 2240 and curStep < 2432) then
		showOnlyStrums = true;
	end

	if curStep == 832 or curStep == 2496 then
		showOnlyStrums = false;
	end


	--cam zooms
	if curStep == 384 or curStep == 2592 then
		tweenHudZoom(1.1, 5.2)
	end
	
	if curStep == 644 or curStep == 678 or curStep == 2308 or curStep == 2342 then
		tweenHudZoom(1.1, 0.2)
	end
	
	if curStep == 800 or curStep == 2464 then
		tweenHudZoom(1.04, 0.2)
	end

	if curStep == 808 or curStep == 2472 then
		tweenHudZoom(1.08, 0.2)
	end

	if curStep == 816 or curStep == 2480 then 
		tweenHudZoom(1.1, 1.35)
	end

	if curStep >= 960 and curStep < 1088 then
		woahCamZoomEpic()
	end

	if curStep == 1920 then
		tweenHudZoom(1.1, 4.8)
	end

	if curStep == 2664 or curStep == 2686 then
		tweenHudZoom(1.1, 0.75)
	end
	
	if (curStep >= 1136 and curStep < 1152) or (curStep >= 1198 and curStep < 1216) then
		for i=0,7 do
			setActorAngle(getActorAngle(i) + 43, i) 
    	end
	end

	if curStep >= 1280 and curStep <1328 then
		leftRightBoogie()
	end

	if curStep == 1328 then
		strumLine1Visible = false; 
		tweenHudZoom(0.0001, 0.5)
	end


	--let player see spotco notes
	if curStep == 1728 then
		strumLine1Visible = true;
	end
	
	--1728 through 1968
	
	--ending disappear FIX NOTES NOT FULLY DISAPPEARING 
	if curStep >= 2720 and curStep < 2784 then
		showOnlyStrums = true;
		strumLineAlpha = strumLineAlpha - (1/780)
		tweenHudZoom(1.1, 5.5)
		if curStep == 2783 then
			strumLineAlpha = 0
		end
	end
	
	--reset note rotation 
	if curStep == 288 or curStep == 1152 or curStep == 1216 then
		for i=0,7 do
			setActorAngle(getActorAngle(i) * 0, i) 
    	end
	end

	--reset zoom out
	if curStep == 576 or curStep == 1088 or curStep == 1342 then	
		setHudZoom = 1.03;
	end

	--reset note placements
	if curStep == 288 or curStep == 384 or curStep == 768 or curStep == 640 or curStep == 1328 or curStep == 2304 or curStep == 2432 or curStep == 2594 then
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

	if (curStep >= 447 and curStep <= 560) or (curStep >= 1984 and curStep <= 2232) then
		bangMove()
	end
end



--SWAP LEFT AND RIGHT
function swapTime(void)
	if toTheLeft == true then
		toTheRight = true 
		toTheLeft = false
	elseif toTheRight == true then
		toTheRight = false 
		toTheLeft = true
	end
	print('swapped')
end


--SWOOZE
function swoozyNotes(void)

	local currentBeat = (songPos / 1000)*(bpm/60)
		if difficulty == 2 then
			for i=0,7 do
				setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.3) * math.pi), i)
			end
		else if difficulty == 1 then
				for i=0,7 do
					setActorY(_G['defaultStrum'..i..'Y'] + 36 * math.cos((currentBeat + i*0.3) * math.pi), i)
				end
			else if difficulty == 0 then
					for i=0,7 do
						setActorY(_G['defaultStrum'..i..'Y'] + 40 * math.cos((currentBeat + i*0.3) * math.pi), i)
					end
				end
			end
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

--Hit to the left three times then right two times really fast
function bangMove (void)
	if toTheLeft == true then
		if curStep % 8 == 0 then
			strumXLocat = strumXLocat - 66.6666667
			for i = 0,7 do
				setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
			end
			print(strumXLocat)
			if strumXLocat <= -140 then
				swapTime()
			end
		end	
	elseif toTheRight == true then
		if curStep % 16 == 8 or curStep % 16 == 12 then
			strumXLocat = strumXLocat + 100
			for i = 0,7 do
				setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
			end
			print(strumXLocat)
			if strumXLocat >= -90 then
				swapTime()
			end
		end
	end
end

--zooming camera + hud on beat
function woahCamZoomEpic(void)
	if curStep % 4 == 0 then
		tweenHudZoom(1.08, 0.05)
		tweenCameraZoom(1.2, 0.05)
	end
end

function leftRightBoogie(void)
	if toTheLeft == true then 
		if curStep %  4 == 0 then
			strumXLocat = strumXLocat - 50
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
		end
		if strumXLocat <= -50 then
			swapTime()
		end
		print(strumXLocat)
		end
		
	elseif toTheRight == true then
		if curStep % 4 == 2 then
			strumXLocat = strumXLocat + 50
			for i=0,7 do
				setActorX(_G['defaultStrum'..i..'X'] + strumXLocat, i)
			end
			if strumXLocat >= 50 then
				swapTime()
			end
			print(strumXLocat)
		end	
	end
end
