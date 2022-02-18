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
import flixel.text.FlxText;

//I stole this from bob mod :trolled:

class UpdateScreen extends MusicBeatState
{
	
	private var updateBox:Array<Dynamic> = [];
	var button:FlxSprite;
	var box:FlxSprite;
	var boxTitle:FlxSprite;
	var updateBanner:FlxSprite;
	var updateTextBig:FlxText;
	var updateTextSmall:FlxText;
	var titleText:FlxSprite;
	var stopSpamming:Bool = false;

	override function create()
	{
		var black:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('baseplate', 'preload'));
		box = new FlxSprite(250, 20).loadGraphic(Paths.image('genericBox', 'preload'));
		box.setGraphicSize(Std.int(box.width * 0.675));
		box.updateHitbox();
		updateBox.push(box);

		boxTitle = new FlxSprite(280, 55).loadGraphic(Paths.image('news', 'preload'));
		boxTitle.setGraphicSize(Std.int(box.width *0.25));
		boxTitle.updateHitbox();
		updateBox.push(boxTitle);

		updateTextBig = new FlxText(295,175,700,"FnF Feat Robeats Chapter 2!");
		updateTextBig.alignment = CENTER;
        updateTextBig.size = 40;
        updateTextBig.font = 'Righteous';
        updateTextBig.color = 0xFFDABA52;
        updateTextBig.scrollFactor.set();
		updateBox.push(updateTextBig);

		updateTextSmall = new FlxText(392,260,500,"Welcome back to the city, featuring 10+ NEW songs, community related opponents, and a new fever bar feature. Play now!");
		updateTextSmall.alignment = CENTER;
        updateTextSmall.size = 20;
        updateTextSmall.font = 'Righteous';
        updateTextSmall.color = FlxColor.WHITE;
        updateTextSmall.scrollFactor.set();
		updateBox.push(updateTextSmall);

		updateBanner = new FlxSprite(335, 380).loadGraphic(Paths.image('updateBanner','preload'));
		updateBanner.setGraphicSize(Std.int(box.width*0.75));
		updateBanner.updateHitbox();
		updateBox.push(updateBanner);

		add(black);
		add(box);
		add(boxTitle);
		add(updateTextBig);
		add(updateTextSmall);
		add(updateBanner);

		button = new FlxSprite(920, 480);
		button.frames = Paths.getSparrowAtlas('buttonShit', 'preload');
		button.animation.addByPrefix('idle', 'buttonIdle', 24, false);
		button.animation.addByPrefix('press','buttonConfirm0', 24, false);
		button.setGraphicSize(Std.int(button.width * 0.45));
		button.updateHitbox();
		button.animation.play('idle');
		add(button);

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
		add(titleText);

		FlxG.camera.fade(FlxColor.BLACK, 0.8, true);

		super.create();
	}

	override function update(elapsed:Float)
	{
		new FlxTimer().start(5.0, function(tmr:FlxTimer){
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
				FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
				new FlxTimer().start (0.2, function(tmr:FlxTimer){
					for (i in 0...updateBox.length){
						FlxTween.tween(updateBox[i],{alpha:0},0.5);
					}	
				});
				new FlxTimer().start (0.8, function(tmr:FlxTimer){
					FlxG.switchState(new MainMenuState());
				});
			}
			
			
		}
		super.update(elapsed);
	}
}