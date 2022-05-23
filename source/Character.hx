package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var healthColor = 0xFF30B1D1; //bf's color btw

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		if(FlxG.save.data.antialiasing)
			{
				antialiasing = true;
			}

		switch (curCharacter)
		{
			case 'gf':
				healthColor = 0xFFA2054B;

				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets','shared',true);
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'gf-car':
				healthColor = 0xFFA2054B;

				tex = Paths.getSparrowAtlas('gfCar','shared',true);
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				loadOffsetFile(curCharacter);

				playAnim('danceRight');

			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND','shared',true);
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;
				
			case 'noob':
				healthColor = 0xFFFFE318;
				
				tex = Paths.getSparrowAtlas('Noob','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Noob idle', 24);
				animation.addByPrefix('singUP', 'Noob Up', 24);
				animation.addByPrefix('singRIGHT', 'Noob Right', 24);
				animation.addByPrefix('singDOWN', 'Noob Down', 24);
				animation.addByPrefix('singLEFT', 'Noob Left', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'chris':
				healthColor = 0xFF2962ff;
				
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('Chris','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'Chris Idle', 24);
				animation.addByPrefix('singUP', 'Chris Up', 24);
				animation.addByPrefix('singRIGHT', 'Chris Right', 24);
				animation.addByPrefix('singDOWN', 'Chris down', 24);
				animation.addByPrefix('singLEFT', 'Chris left', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'chrisangry':
				healthColor = 0xFF2962ff;
				
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('ChrisAngry','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'ChrisAngry Idle', 24);
				animation.addByPrefix('singUP', 'ChrisAngry Up', 24);
				animation.addByPrefix('singRIGHT', 'ChrisAngry Right', 24);
				animation.addByPrefix('singDOWN', 'ChrisAngry Down', 24);
				animation.addByPrefix('singLEFT', 'ChrisAngry Left', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'spotco':
				healthColor = 0xFF009A00;

				
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('SpotcoSprites','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'spotco idle', 24);
				animation.addByPrefix('singUP', 'spotco up', 24);
				animation.addByPrefix('singRIGHT', 'spotco right', 24);
				animation.addByPrefix('singDOWN', 'spotco down', 24);
				animation.addByPrefix('singLEFT', 'spotco left', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'spotcochair':
				healthColor = 0xFF009A00;

				
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('SpotcoChairSprites','shared',true);
				frames = tex;
				animation.addByPrefix('idle', 'SpotcoChair Idle', 24);
				animation.addByPrefix('singUP', 'SpotcoChair Up', 24);
				animation.addByPrefix('singRIGHT', 'SpotcoChair Right', 24);
				animation.addByPrefix('singDOWN', 'SpotcoChair Down', 24);
				animation.addByPrefix('singLEFT', 'SpotcoChair Left', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			
			case 'eggNaked':
					healthColor = 0xFFFFF3A0;

					tex = Paths.getSparrowAtlas('EggyBoiSprites', 'shared', true);
					frames = tex;
					animation.addByPrefix('idle', 'Egg Idle', 24);
					animation.addByPrefix('singUP', 'Egg Up', 24);
					animation.addByPrefix('singDOWN', 'Egg Down', 24);
					animation.addByPrefix('singRIGHT', 'Egg Right', 24);
					animation.addByPrefix('singLEFT', 'Egg Left', 24);

					loadOffsetFile(curCharacter);

					playAnim('idle');

			case 'matt': 
					healthColor = 0xFF2B2B2B;

					tex = Paths.getSparrowAtlas('MattSprites', 'shared', true);
					frames = tex;
					animation.addByPrefix('idle', 'Matt Idle', 24);
					animation.addByPrefix('singUP', 'Matt Up', 24);
					animation.addByPrefix('singDOWN', 'Matt Down', 24);
					animation.addByPrefix('singRIGHT', 'Matt Right', 24);
					animation.addByPrefix('singLEFT', 'Matt Left', 24);

					loadOffsetFile(curCharacter);

					playAnim('idle');
			
			case 'mattYolk':
				healthColor = 0xFFCAC49B;
				frames = Paths.getSparrowAtlas('MattEgg','shared',true);
				animation.addByPrefix('idle', 'Matt Idle', 24, false);
				
				animation.addByPrefix('singUP', 'Matt Up EGG', 24, false);
				animation.addByPrefix('singDOWN', 'Matt Down EGG', 24, false);
				animation.addByPrefix('singLEFT', 'Matt Left EGG', 24, false);
				animation.addByPrefix('singRIGHT', 'Matt Right EGG', 24, false);

				animation.addByPrefix('singUP-alt', 'Matt Up Matt', 24, false);
				animation.addByPrefix('singDOWN-alt', 'Matt Down Matt', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Matt Left Matt', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Matt Right Matt', 24, false);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				
			case 'noobDrip': 
				healthColor = 0xFFFFE318;

				tex = Paths.getSparrowAtlas('CockyNoobSprites', 'shared', true);
				frames = tex;
				animation.addByPrefix('idle', 'CockyNoob Idle', 24);
				animation.addByPrefix('singUP', 'CockyNoob Up', 24);
				animation.addByPrefix('singDOWN', 'CockyNoob Down', 24);
				animation.addByPrefix('singRIGHT', 'CockyNoob Right', 24);
				animation.addByPrefix('singLEFT', 'CockyNoob Left', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'kitty':
				healthColor = 0xFFB47A3C;

				tex = Paths.getSparrowAtlas('kitty','shared',true);
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

				flipX = true;


		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function loadOffsetFile(character:String)
	{
		var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('images/characters/' + character + "Offsets", 'shared'));

		for (i in 0...offset.length)
		{
			var data:Array<String> = offset[i].split(' ');
			addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance(forced:Bool = false)
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle', forced);
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
