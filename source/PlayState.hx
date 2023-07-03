package;

import lime.graphics.cairo.CairoAntialias;
import flixel.FlxCamera;
import flixel.tile.FlxTileblock;
import flixel.math.FlxRect;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxState;
import characters.Bambi as Marcello;

using StringTools;

class PlayState extends FlxState
{
	var bambi:Marcello;
	var subwooferdestroy:Int = 0;
	var subwoofermusic:FlxSound;
	var subwoofermusic2:FlxSound;
	var tutorialmusic:FlxSound;
	var background:FlxSprite;
	var helptext:FlxText;
	public static var destroyed:Bool = false;
	var bcamerapos:FlxObject;
	var tutorialtext:Array<String> = [
	"welcome to the tutorial of bambi's corn adventure!",
	"actually, we're in the middle of nowhere, i dont know why the camera is focusing at you to be honest",
	"let me just...",
	"there",
	"you're probably familiar with the basic controls right?",
	"uhhh...alright",
	"press A/D or the Left/Right arrow keys to move",
	"jumping will be implemented in a future update",
	"...thats just the basic controls tbh",
	"i knew it see i spared you the time", // 9
	"alright you can go to the map now" // 10
	];
	var game:FlxCamera;
	var hud:FlxCamera;
	override public function create()
	{
		super.create();
		game = new FlxCamera();
		hud = new FlxCamera();
		FlxG.cameras.reset(game);
		FlxG.cameras.add(hud, false);
		FlxG.cameras.setDefaultDrawTarget(game, true);
		hud.bgColor.alpha = 0;
		helptext = new FlxText(0, 0, 0, "", 22);
		helptext.screenCenter();
		helptext.y -= 120;
		helptext.cameras = [game];
		add(helptext);
		subwoofermusic = FlxG.sound.load("assets/music/subwoofed corntheft.ogg", 1, true);
		subwoofermusic2 = FlxG.sound.load("assets/music/subwoofed maze.ogg", 1, true);
		tutorialmusic = FlxG.sound.load("assets/music/corn.ogg", 1, true);
		tutorialmusic.play();
		bambi = new Marcello();
		bambi.y = 700;
		bambi.screenCenter();
		background = new FlxSprite(0, 0).loadGraphic("assets/images/the funny middle of nowhere.png");
		background.antialiasing = true;
		add(background);
		add(bambi);		
		bcamerapos = new FlxObject(bambi.getGraphicMidpoint().x, bambi.getGraphicMidpoint().y - 65);
		add(bcamerapos);
		FlxG.camera.y += 720;
		FlxG.watch.add(bambi, "x", "bambi x thing");
		FlxG.watch.add(bambi, "y", "bambi y thing");
		FlxG.watch.add(bcamerapos, "x", "camera position x thing");
		FlxG.watch.add(bcamerapos, "y", "camera position y thing");
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 720}, 0.4, {ease: FlxEase.cubeOut});
		FlxG.camera.follow(bcamerapos, LOCKON, 0.05);
		bambi.y = 700;
		bambi.x = 1200;
	}

	override public function update(elapsed:Float)
	{
		if (bambi.x >= 405 && bambi.x <= 1630)
			bcamerapos.x = bambi.getGraphicMidpoint().x;
		bcamerapos.y = bambi.getGraphicMidpoint().y - 65;
		super.update(elapsed);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			tutorialmusic.fadeOut(0.65, 0);
			subwoofermusic.fadeOut(0.65, 0);
			subwoofermusic2.fadeOut(0.65, 0);
			FlxG.sound.play("assets/sounds/back.ogg");
			statetransition(new MainMenuStateBetter());
			FlxG.keys.enabled = false;
		}
	/*	if (FlxG.keys.justPressed.E && !subwoofermusic.playing && !subwoofermusic2.playing && !destroyed)
		{
			tutorialmusic.pause();
			tutorialmusic.volume = 0;
			switch (FlxG.random.int(0, 1)){
				case 0:
					subwoofermusic.play();
				case 1:
					subwoofermusic2.play();
			}
		} */
		subwooferdestroy = FlxG.random.int(0, 1000);
		trace(subwooferdestroy);
		if (subwooferdestroy == 69 && (subwoofermusic.playing || subwoofermusic2.playing))
		{
			destroyed = true;
			FlxG.camera.shake(0.025, 0.2);
			subwoofermusic.stop();
			subwoofermusic2.stop();
			bambi.animation.play("idle", true);
			FlxG.sound.play("assets/sounds/aw man.ogg", 1);
			new FlxTimer().start(2.5, function(fadein:FlxTimer){
				tutorialmusic.play();
				tutorialmusic.fadeIn(0.5, 0, 1, function(idleagain:FlxTween){
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
	function tutorialtextstuff()
	{

	}
}
