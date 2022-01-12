package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.system.FlxSound;
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
	var stopSpamming:Bool = false;
	var titleText:FlxSprite;

	override function create()
	{
		

		super.create();
		var bg:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('bgpurple'));
		var frame:FlxSprite = new FlxSprite(bg.x, bg.y).loadGraphic(Paths.image('frame'));
		
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
		
		
		song = new FlxSprite(225, 150).loadGraphic(Paths.image('cover arts/Rebeats', 'shared')); //ok so I'm going to have to make these cover arts be the same dimensions so that I only have to chnage the file path, but I can imagine this	
		song.setGraphicSize(Std.int(song.width * 0.675));											 //screen being used to display different songs like dark sheep instead of just rebeats
		song.updateHitbox();

		var songBorder:FlxSprite = new FlxSprite(song.x-3, song.y-2).loadGraphic(Paths.image('songFrame'));
		songBorder.setGraphicSize(Std.int(song.width * 1.1375), Std.int(song.height *  1.1375));

		var fanfare:FlxSound = new FlxSound().loadEmbedded(Paths.music('fanfare'), false, true);
            FlxG.sound.list.add(fanfare);
		
		

		button = new FlxSprite(930, 450);
		button.frames = Paths.getSparrowAtlas('buttonShit', 'preload');
		button.animation.addByPrefix('idle', 'buttonIdle', 24, false);
		button.animation.addByPrefix('press','buttonConfirm0', 24, false);
		button.setGraphicSize(Std.int(button.width * 0.45));
		button.updateHitbox();
		button.animation.play('idle');

		//FlxG.camera.fade(FlxColor.BLACK, 0.8, true);

		congrats = new FlxText(72, 50, Std.int(FlxG.width * 0.9), "Congrats, you unlocked a new song in Freeplay!", 50);
		congrats.color = 0xFFFFEA00;
		congrats.font = 'Righteous';

		titleText = new FlxSprite(125, FlxG.height * 0.1);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		if(FlxG.save.data.antialiasing)
			{
				titleText.antialiasing = true;
			}
		titleText.animation.play('idle');
		titleText.updateHitbox();
		titleText.alpha = 0;

		
		add(bg);	
		add(gfDance);
		add(songBorder);
		add(song);
		add(congrats);
		add(frame);
		add(button);
		add(titleText);
		
		fanfare.play(true, 0, fanfare.length);

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

		new FlxTimer().start(10.0, function(tmr:FlxTimer){ //longer timer because hopefully people know what to press to go to next screen at this point
			FlxTween.tween(titleText,{alpha:1},2);
		});

		if (controls.ACCEPT)
		{
			if(!stopSpamming){
				remove(titleText);
				stopSpamming = true;
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
			
			
		}
		super.update(elapsed);
	}
}