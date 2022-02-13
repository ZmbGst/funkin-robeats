package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxPoint;

using StringTools;



class DialogueBox extends FlxSpriteGroup
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	var box:FlxSprite;

	var curCharacter:String = '';
	var emotion:String='';
	var oldEmotion:String='';

	var portraitLeftoldEmotion:String='';
	var portraitRightoldEmotion:String='';
	var portraitCenteroldEmotion:String='';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	var speakerText:FlxText;

	public var finishThing:Void->Void;
	public var finishThingTwo:Void -> Void;
	public var pleaseDontBreak:Bool = true;
	public var noMusic = false;
	public var goodNumber:Int;
	public var badNumber:Int;
	public var viewer:String = 'one';


	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitCenter:FlxSprite;

	var opponent:String = '';

	var bgFade:FlxSprite;
	var baseColor:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		animOffsets = new Map<String, Array<Dynamic>>();

		super();

		switch (PlayState.SONG.song.toLowerCase())
		{

			case 'lemon summer':
				if(${PlayState.instance.accuracy} >= 98.00){
					FlxG.sound.playMusic(Paths.music('silence'), 0);//lol everytime i do this without a playMusic thing, the previous song continues playing
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				}
				else
				{
					FlxG.sound.playMusic(Paths.music('showsOver'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);
				}
			default:
				FlxG.sound.playMusic(Paths.music('showsOver'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}
		

		bgFade = new FlxSprite(0, 0).loadGraphic(Paths.image('bgpurple')); //Change this to get backgrounds based on what week it is
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;

		baseColor = new FlxSprite(0.0).makeGraphic(Std.int(bgFade.width), Std.int(bgFade.height), FlxColor.BLACK);
		add(baseColor);
		add(bgFade);

		 if (${PlayState.SONG.song} != 'Tutorial'){
		 new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 7);}

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			default:
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('textbox','shared');
				box.animation.addByPrefix('normalOpen', 'zoom in', 24, false);
				box.animation.addByIndices('normal', 'textbox read', [4], "", 24);
				box.width = 230;
				box.height = 200;
				box.x = 30;
				box.y = 375;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(200, 60);

		//all of these switch statements are determined by songs as opposed to weeks because the people speaking for these songs are the ones going to sing
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'shelter' | 'alone' | 'friends': //Week 1
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/EggYolk', 'shared');
				portraitLeft.animation.addByPrefix('hey', 'hey', 24, true);	
				portraitLeft.animation.addByPrefix('relax', 'relax', 24, true);	
				portraitLeft.animation.addByPrefix('scared', 'scared', 24, true);	
				portraitLeft.animation.addByPrefix('happy', 'happy', 24, true);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065));
			
			case 'bibi hendl' | 'bad apple' | 'insight'://Week 2
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/EggYolk', 'shared');
				portraitLeft.animation.addByPrefix('hey', 'hey', 24, true);	
				portraitLeft.animation.addByPrefix('relax', 'relax', 24, true);	
				portraitLeft.animation.addByPrefix('scared', 'scared', 24, true);	
				portraitLeft.animation.addByPrefix('happy', 'happy', 24, true);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065));
			
			case 'lemon summer' | 'space battle' | 'freedom dive' | 'dark sheep': //Week 3 
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/EggYolk', 'shared');
				portraitLeft.animation.addByPrefix('hey', 'hey', 24, true);	
				portraitLeft.animation.addByPrefix('relax', 'relax', 24, true);	
				portraitLeft.animation.addByPrefix('scared', 'scared', 24, true);	
				portraitLeft.animation.addByPrefix('happy', 'happy', 24, true);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065));
			
			//Week 4+ which will have more dynamic interactions w/ multiple portraitLeft characters
			case 'retaliation' | 'vix': 
				//Egg Yolk
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/EggYolk', 'shared');
				portraitLeft.animation.addByPrefix('hey', 'hey', 24, true);	
				portraitLeft.animation.addByPrefix('relax', 'relax', 24, true);	
				portraitLeft.animation.addByPrefix('scared', 'scared', 24, true);	
				portraitLeft.animation.addByPrefix('happy', 'happy', 24, true);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065));
			case 'mattyolk': //wip name. change later
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/EggYolkNoShell', 'shared');
				portraitLeft.animation.addByPrefix('hey', 'hey', 24, true);	
				portraitLeft.animation.addByPrefix('relax', 'relax', 24, true);	
				portraitLeft.animation.addByPrefix('scared', 'scared', 24, true);	
				portraitLeft.animation.addByPrefix('happy', 'happy', 24, true);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065));
		
			case 'rebeats':
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/EggYolk', 'shared');
				portraitLeft.animation.addByPrefix('hey', 'hey', 24, true);	
				portraitLeft.animation.addByPrefix('relax', 'relax', 24, true);	
				portraitLeft.animation.addByPrefix('scared', 'scared', 24, true);	
				portraitLeft.animation.addByPrefix('happy', 'happy', 24, true);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065));
			default:
				portraitLeft.frames = Paths.getSparrowAtlas('portraits/EggYolk', 'shared');
				portraitLeft.animation.addByPrefix('hey', 'hey', 24, true);	
				portraitLeft.animation.addByPrefix('relax', 'relax', 24, true);	
				portraitLeft.animation.addByPrefix('scared', 'scared', 24, true);	
				portraitLeft.animation.addByPrefix('happy', 'happy', 24, true);
				portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065));
		}			
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(740, 140);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/EggYolkNoShell', 'shared');
		portraitRight.animation.addByPrefix('hey', 'hey', 24, true);	
		portraitRight.animation.addByPrefix('relax', 'relax', 24, true);	
		portraitRight.animation.addByPrefix('scared', 'scared', 24, true);	
		portraitRight.animation.addByPrefix('happy', 'happy', 24, true);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.065));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		/*/Redo code so that its foratted similarly above
		portraitRight = new FlxSprite(740, 140);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/Dialogue', 'shared');
		portraitRight.animation.addByPrefix('enter', 'Gf Animation', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.175));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;/*/


		//spectators + randoms if we need them
		portraitCenter = new FlxSprite(200, 40);
		portraitCenter.frames = Paths.getSparrowAtlas('viewers/thePeeps', 'shared');
		for(i in 0...9){
			portraitCenter.animation.addByPrefix(""+i, 'person'+i, 24, false);
			loadOffsetFile(""+i);	
		}
		portraitCenter.animation.addByPrefix('9', 'person9', 24, false);
		portraitCenter.setGraphicSize(Std.int(portraitCenter.width*PlayState.daPixelZoom * 0.175));
		portraitCenter.updateHitbox();
		portraitCenter.scrollFactor.set();
		add(portraitCenter);
		portraitCenter.visible = false;
		
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(245, 527, Std.int(FlxG.width * 0.6), "", 26);
		dropText.font = 'Righteous';
		dropText.color = FlxColor.BLACK;
		add(dropText);

		swagDialogue = new FlxTypeText(243, 525, Std.int(FlxG.width * 0.6), "", 26);
		swagDialogue.font = 'Righteous';
		swagDialogue.color = 0xFFFEF1FF;
		//swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)]; lolo this is so annoying
		add(swagDialogue);

		speakerText = new FlxText(0, 0, Std.int(FlxG.width * 0.6), "", 32);
		speakerText.color = 0xFFE1E8FF;
		speakerText.font = 'Righteous';
		add(speakerText);
		
		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'monday night monsters':
				opponent = "Girlfriend";
			case 'shelter' | 'alone' | 'friends':
				opponent = "Noob";
			case 'bibi hendl' | 'bad apple' | 'insight':
				opponent = "Chrisu";
			case 'lemon summer' | 'space battle' | 'freedom dive' | 'dark sheep':
				opponent = "Spotco";
			case 'rebeats':
				opponent = "Trash Kitty";
			case 'retaliation' | 'vix':
				opponent= "Egg Yolk";
			default:
				opponent = "Opponent";
				trace ('not working');
		}

		dropText.text = swagDialogue.text;

		switch (curCharacter){
			case 'dad':
				speakingText(242,472,opponent); 
			case 'gf':
				speakingText(242,472,"Girlfriend");
			case 'bf':
				speakingText(242,472,"Boyfriend");
			case 'extra':
				speakingText(242,472,"Robeats Player");
		}

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}
		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
			
			//Maybe change this out later?
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;
					if (pleaseDontBreak)
						FlxG.sound.music.fadeOut(2.2, 0);
					

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						baseColor.alpha -= 1 / 5 * 0.7;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						portraitCenter.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
						speakerText.alpha = swagDialogue.alpha;
					}, 5);
					
					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
							finishThing();
							kill();
					});
				}
				
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function speakingText(x,y,poop){
				speakerText.text = poop;
				speakerText.x = x;
				speakerText.y = y;
	}

	public function loadOffsetFile(viewer:String)
	{
		var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('images/viewers/thePeepsOffsets','shared'));

		for (i in 0...offset.length)
		{
			var data:Array<String> = offset[i].split(' ');
			addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
		}
	}
	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
	

	function startDialogue():Void
	{
		cleanDialog();

		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
		
		switch (curCharacter)
		{
			case 'dad':

				if (!portraitLeft.visible)
					portraitLeft.visible = true;

				if (!(portraitLeftoldEmotion == emotion)){
					portraitLeft.alpha = 0;
					portraitLeft.scale.set(1.0,1.0);
					FlxTween.tween(portraitLeft.scale, {x:Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065)*0.003, y:Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.065)*0.003}, 0.2);
					FlxTween.tween(portraitLeft, {alpha:1.0}, 0.2);
					portraitLeft.animation.play(emotion);
					portraitLeftoldEmotion = emotion; 
				}
			case 'gf':

				if (!portraitRight.visible)
					portraitRight.visible = true;

				if (!(portraitRightoldEmotion == emotion)){
					portraitRight.alpha = 0;
					portraitRight.scale.set(1.0,1.0);
					FlxTween.tween(portraitRight.scale, {x:Std.int(portraitRight.width * PlayState.daPixelZoom * 0.065)*0.003, y:Std.int(portraitRight.width * PlayState.daPixelZoom * 0.065)*0.003}, 0.2);
					FlxTween.tween(portraitRight, {alpha:1.0}, 0.2);
					portraitRight.animation.play(emotion);
					portraitRightoldEmotion = emotion; 
				}
			case 'extra':
				
				//Determine which npc will play based on randomization
				goodNumber = FlxG.random.int(1,8);
				playAnim(""+goodNumber);
				
				if(portraitCenter.animation.frameName == "person"+badNumber+"0000"){
					var temporary:Int = FlxG.random.int(1,8,[badNumber]);
					playAnim(""+temporary);
					badNumber = temporary;}
				else
				badNumber = goodNumber;


				if (!portraitCenter.visible)
					portraitCenter.visible = true;

				playAnim(""+goodNumber);

			case 'banned':

				if (!portraitCenter.visible)
					portraitCenter.visible = true;

				playAnim('9');

			default:
				trace('this should be bf talking');
		
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		emotion = splitName[3];
		curCharacter = splitName[1];
		
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + splitName[3].length + 4).trim();
	}

	public function playAnim(AnimName:String):Void
	{
		portraitCenter.animation.play(AnimName);
		var daOffset = animOffsets.get("person" +AnimName);
		
		if (animOffsets.exists("person"+AnimName))
		{
			portraitCenter.offset.set(daOffset[0], daOffset[1]);
		}
		else
			portraitCenter.offset.set(0, 0);
	}
}