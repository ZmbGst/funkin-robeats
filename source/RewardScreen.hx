package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

//I stole this from bob mod :trolled:

class RewardScreen extends MusicBeatState
{
	

	var song:FlxSprite;
	var gfDance:FlxSprite;
	var congrats:FlxText; 
	var button:FlxSprite;
	var danceLeft:Bool = false;

	override function create()
	{
		

		super.create();
		var bg:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('bgpurple'));
		
		gfDance = new FlxSprite(FlxG.width*0.35,FlxG.height*0.15);
		gfDance.frames = Paths.getSparrowAtlas('characters/GF_assets', 'shared');
		gfDance.animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		gfDance.animation.addByPrefix('cheer', 'GF Cheer', 24, false);
		gfDance.animation.play('danceRight');

		
		if(FlxG.save.data.antialiasing)
			{
				gfDance.antialiasing = true;
			}
		
		
		song = new FlxSprite(250, 150).loadGraphic(Paths.image('one/cover arts/rebeats', 'shared'));
		song.setGraphicSize(Std.int(song.width * 0.675));
		song.updateHitbox();

		var songBorder:FlxSprite = new FlxSprite(song.x-20, song.y-20).makeGraphic(Std.int(song.width * 1.1375), Std.int(song.height *  1.1375), FlxColor.BLUE);


		
		add(bg);	
		add(gfDance);
		add(songBorder);
		add(song);
		

		button = new FlxSprite(1050, 500);
		button.frames = Paths.getSparrowAtlas('buttonShit', 'preload');
		button.animation.addByPrefix('idle', 'buttonIdle', 24, false);
		button.animation.addByPrefix('press','buttonConfirm0', 24, false);
		button.setGraphicSize(Std.int(button.width * 0.45));
		button.updateHitbox();
		button.animation.play('idle');
		add(button);
		FlxG.camera.fade(FlxColor.BLACK, 0.8, true);

		congrats = new FlxText(100, 50, Std.int(FlxG.width * 0.9), "Congrats, you unlocked a new song in Freeplay!", 50);
		congrats.color = 0xFFFFEA00;
		congrats.font = 'Righteous';
		add(congrats);

		Conductor.changeBPM(102);
	}

		

	override function beatHit()
	{
		super.beatHit();
		
		if (danceLeft){
			gfDance.animation.play('danceRight');
			danceLeft = false;
			}
		else{
			gfDance.animation.play('danceLeft');
			danceLeft = true;
		}
	}

	override function update(elapsed:Float)
	{
		Conductor.songPosition = FlxG.sound.music.time;
		if (controls.ACCEPT)
		{
			button.offset.x +=33;
			button.offset.y +=33;
			
			button.animation.play('press');
			gfDance.animation.remove('danceRight');
			gfDance.animation.remove('danceLeft');
			gfDance.animation.play('cheer');
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			new FlxTimer().start (1, function(tmr:FlxTimer){
				FlxG.switchState(new MainMenuState());
			});
			
		}
		super.update(elapsed);
	}
}