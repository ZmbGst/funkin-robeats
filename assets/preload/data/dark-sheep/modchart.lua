-- this gets called starts when the level loads.
function start(song) -- arguments, the song name
	setCamZoom(1.7)
end

-- this gets called every frame
function update(elapsed) -- arguments, how long it took to complete a frame

end

-- this gets called every beat
function beatHit(beat) -- arguments, the current beat of the song

end

stepHitCount = 0; --this function is useful for finding out what section starts at what step of a song (1/4 of a beat) as it prints the result in powershell
function stepHit (beat) 
	print(stepHitCount);	
	stepHitCount = stepHitCount + 1;
end