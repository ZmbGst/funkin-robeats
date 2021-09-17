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

//I stole this from bob mod :trolled:

class UpdateScreen extends MusicBeatState
{
	

	var button:FlxSprite;
	var box:FlxSprite;

	override function create()
	{
		

		super.create();
		var black:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('baseplate', 'preload'));
		box = new FlxSprite(250, 20).loadGraphic(Paths.image('updateNotif', 'preload'));
		box.setGraphicSize(Std.int(box.width * 0.675));
		box.updateHitbox();
		add(black);
		add(box);

		button = new FlxSprite(920, 480);
		button.frames = Paths.getSparrowAtlas('buttonShit', 'preload');
		button.animation.addByPrefix('idle', 'buttonIdle', 24, false);
		button.animation.addByPrefix('press','buttonConfirm0', 24, false);
		button.setGraphicSize(Std.int(button.width * 0.45));
		button.updateHitbox();
		button.animation.play('idle');
		add(button);
		FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			button.offset.x +=33;
			button.offset.y +=33;
			
			button.animation.play('press');
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			new FlxTimer().start (0.2, function(tmr:FlxTimer){
				FlxTween.tween(box,{alpha:0},0.5); //lol this isnt efficient
			});
			new FlxTimer().start (0.8, function(tmr:FlxTimer){
				FlxG.switchState(new MainMenuState());
			});
			
		}
		super.update(elapsed);
	}
}