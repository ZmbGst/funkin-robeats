poopiesingle = nil;
poopiedouble = nil;

function start(song)
--	poopiesingle = makeSprite('ohhellyes','ohhellyes',false);
	poopiedouble = makeSprite('ohhellyes','ohhellyes',false);
	print("loaded images");
--	setActorAlpha(0,poopiesingle);
	setActorAlpha(0,poopiedouble);
	print("loaded alphas");
--	setActorX(200,poopiesingle);
	setActorX(800,poopiedouble);
--	setActorY(600,poopiesingle);
	setActorY(600,poopiedouble);
	print("loaded coordinates");
end


function update(elapsed)

end


function beatHit(beat)

end


function stepHit(step)

	if step == 300 then
		print ("its time");	
--		setActorAlpha(100,poopiesingle);
		setActorAlpha(100,poopiedouble);
	end	
end