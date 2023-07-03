package;

import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxState;

using StringTools;

class DebugState extends FlxState
{
	var bambi:FlxSprite;
	var subwooferdestroy:Int = 0;
	var subwoofermusic:FlxSound;
	var subwoofermusic2:FlxSound;
	var peacefulmusic:FlxSound;
	var helptext:FlxText;
	var idlething:Float = 0;
	var destroyed:Bool = false;
	override public function create()
	{
		super.create();
		subwoofermusic = FlxG.sound.load("assets/music/subwoofed corntheft.ogg", 1, true);
		subwoofermusic2 = FlxG.sound.load("assets/music/subwoofed maze.ogg", 1, true);
		peacefulmusic = FlxG.sound.load("assets/music/corn.ogg", 1, true);
		peacefulmusic.play();
		bambi = new FlxSprite(0, 0);
		bambi.frames = AssetPaths.getSparrowAtlas("bambi");
		bambi.animation.addByPrefix("idle", "cool", 24, true);
		bambi.animation.addByPrefix("bruh", "what", 24, true);
		bambi.animation.addByPrefix("theleft", "Left", 24, false);
		bambi.animation.addByPrefix("theright", "Right", 24, false);
		bambi.setGraphicSize(Std.int(bambi.width * 0.69));
		bambi.screenCenter();
		bambi.x -= 200;
		bambi.animation.play("idle", false);
		bambi.antialiasing = true;
		add(bambi);		
		helptext = new FlxText(0, 0, 0, "A/D or Left/Right Arrow Key - Animations\n", 22);
		helptext.text += "E - Play Better Music\n";
		helptext.text += "ESCAPE - Main Menu\n";
		helptext.setFormat("assets/fonts/koruri.ttf", 22, FlxColor.WHITE, FlxTextAlign.CENTER);
		helptext.screenCenter();
		helptext.x += 300;
		add(helptext);
		FlxG.camera.y += 720;
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 720}, 0.4, {ease: FlxEase.cubeOut});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (bambi.animation.curAnim.name.startsWith('the'))
			idlething += elapsed;
		if (idlething >= 0.1714285714285714 * 5) // 
		{
			idlething = 0;
			bambi.animation.play("idle");
		}
		if (FlxG.keys.justPressed.ESCAPE)
		{
			peacefulmusic.fadeOut(0.65, 0);
			subwoofermusic.fadeOut(0.65, 0);
			subwoofermusic2.fadeOut(0.65, 0);
			FlxG.sound.play("assets/sounds/back.ogg");
			statetransition(new MainMenuStateBetter());
			FlxG.keys.enabled = false;
		}
		if ((FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A) && !destroyed)
		{
			bambi.animation.play("theleft", true);
			idlething = 0;
		}
		if ((FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D) && !destroyed)
		{
			bambi.animation.play("theright", true);
			idlething = 0;
		}
		if (FlxG.keys.justPressed.E && !subwoofermusic.playing && !subwoofermusic2.playing && !destroyed)
		{
			peacefulmusic.pause();
			peacefulmusic.volume = 0;
			switch (FlxG.random.int(0, 1)){
				case 0:
					subwoofermusic.play();
				case 1:
					subwoofermusic2.play();
			}
		}
		subwooferdestroy = FlxG.random.int(0, 1000);
		trace(subwooferdestroy);
		if (subwooferdestroy == 69 && (subwoofermusic.playing || subwoofermusic2.playing))
		{
			destroyed = true;
			bambi.animation.play("bruh");
			FlxG.camera.shake(0.025, 0.2);
			subwoofermusic.stop();
			subwoofermusic2.stop();
			FlxG.sound.play("assets/sounds/aw man.ogg", 1);
			new FlxTimer().start(2.5, function(fadein:FlxTimer){
				peacefulmusic.play();
				peacefulmusic.fadeIn(0.5, 0, 1, function(idleagain:FlxTween){
					bambi.animation.play("idle");
					destroyed = false;
				});
			});
		}
	}
	public function statetransition(state:FlxState, ?iscoolerstate:Bool = false)
	{
		{
			FlxTween.tween(FlxG.camera, {y: FlxG.camera.y + 720}, 0.65, {ease: FlxEase.cubeIn});
			new FlxTimer().start(1, function(getback:FlxTimer)
			{
				MainMenuState.thing = 1;
				FlxG.switchState(state);
			});
		}
	}
}
