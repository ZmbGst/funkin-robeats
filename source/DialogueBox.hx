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

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
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
	var portraitGirlfriend:FlxSprite;
	var portraitExtra:FlxSprite;

	var opponent:String = '';

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	var baseColor:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'lemon summer':
				if(${PlayState.instance.accuracy} >= 92.00){
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
		

		bgFade = new FlxSprite(0, 0).loadGraphic(Paths.image('bgpurple'));
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
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			default:
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('textbox','shared');
				box.animation.addByPrefix('normalOpen', 'zoom in', 24, false);
				box.animation.addByIndices('normal', 'textbox read', [4], "", 24);
				box.width = 230;
				box.height = 200;
				box.x = 30;
				box.y = 375;
				trace ('shitface');
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(200, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('portraits/Dialogue', 'shared');

		//all of these switch statements are determined by songs as opposed to weeks because the people speaking for these songs are the ones going to sing
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'shelter' | 'alone' | 'friends': 
				portraitLeft.animation.addByPrefix('enter', 'Noob Animation', 24, false);
			case 'bibi' | 'bad apple' | 'insight':	
				portraitLeft.animation.addByPrefix('enter', 'Chrisu Animation', 24, false);
			case 'lemon summer' | 'space battle' | 'freedom dive' | 'dark sheep':
				portraitLeft.animation.addByPrefix('enter', 'Spotco Animation', 24, false);
			default:
				portraitLeft.animation.addByPrefix('enter', 'Gf Animation', 24, false);
				trace ('wrong image');
		}
		
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.175));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(740, 140);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/Dialogue', 'shared');
		portraitRight.animation.addByPrefix('enter', 'Bf Animation', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.175));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitGirlfriend= new FlxSprite(780, 140);
		portraitGirlfriend.frames = Paths.getSparrowAtlas('portraits/Dialogue', 'shared');
		portraitGirlfriend.animation.addByPrefix('enter', 'Gf Animation', 24, false);
		portraitGirlfriend.setGraphicSize(Std.int(portraitGirlfriend.width * PlayState.daPixelZoom * 0.175));
		portraitGirlfriend.updateHitbox();
		portraitGirlfriend.scrollFactor.set();
		add(portraitGirlfriend);
		portraitGirlfriend.visible = false;

		portraitExtra = new FlxSprite(200, 40);
		portraitExtra.frames = Paths.getSparrowAtlas('viewers/thePeeps', 'shared');
		for(i in 0...4){
			portraitExtra.animation.addByPrefix(""+i, 'person'+i, 24, false);
			
		}
		portraitExtra.setGraphicSize(Std.int(portraitExtra.width*PlayState.daPixelZoom * 0.175));
		portraitExtra.updateHitbox();
		portraitExtra.scrollFactor.set();
		add(portraitExtra);
		portraitExtra.visible = false;
		
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);


		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));


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
			case 'tutorial':
				opponent = "Girlfriend";
			case 'shelter' | 'alone' | 'friends':
				opponent = "Noob";
			case 'bibi' | 'bad apple' | 'insight':
				opponent = "Chrisu";
			case 'lemon summer' | 'space battle' | 'freedom dive' | 'dark sheep':
				opponent = "Spotco";
			case 'rebeats':
				opponent = "Trash Kitty";
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
				speakingText(242,472,"Viewers");
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
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				/*/if (${PlayState.SONG.song} == 'Tutorial'&& ${PlayState.songFinish}){ 
								trace ('shitface');
								FlxG.switchState(new ResultsScreen());
							}/*/
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
						portraitGirlfriend.visible = false;
						portraitExtra.visible = false;
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

	/*/public function loadOffsetFile(viewer:String)
	{
		var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('images/viewers/viewersOffsets','shared'));

		for (i in 0...offset.length)
		{
			var data:Array<String> = offset[i].split(' ');
			addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
		}
	}/*/

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
		
		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitGirlfriend.visible = false;
				portraitExtra.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':

				portraitLeft.visible = false;
				portraitGirlfriend.visible = false;
				portraitExtra.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'gf':

				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitExtra.visible = false;
				if (!portraitGirlfriend.visible)
				{
					portraitGirlfriend.visible = true;
					portraitGirlfriend.animation.play('enter');
				}
			case 'extra':
				portraitRight.visible = false;
				portraitGirlfriend.visible = false;
				portraitLeft.visible = false;
			
				//Glasses = 1 Buzz = 2 thinking = 3 You'll never know what this means >=)
				
				//Code to randomize the portraits and make sure the same portrait doesn't come immediately after the first instance (still can come multiple times in a session)
				//If you steal this; first, thank you I feel I actually have some idea of what I'm doing. second, please atleast understand the logic and what each line of code does just so you can fix the issues on your code yourself
			
				goodNumber = FlxG.random.int(1,3);
				portraitExtra.animation.play(""+goodNumber);
				trace('1          '+portraitExtra.animation.frameName);//displays frame name (personx instance 10000)
				
				if(portraitExtra.animation.frameName == "person"+badNumber+" instance 10000"){
					var temporary:Int = FlxG.random.int(1,3,[badNumber]);
					portraitExtra.animation.play(""+temporary);
					trace('2          lmao the new sprite is '+portraitExtra.animation.frameName + ' the dumb thing made the same image go twice');
					badNumber = temporary;}

				else
				badNumber = goodNumber;
				
				if (!portraitExtra.visible)
				{
					portraitExtra.visible = true;
					portraitExtra.animation.play(""+goodNumber);
				}

	}}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
