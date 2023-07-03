package maps;

import Discord.DiscordClient;
import openfl.Lib;
import lime.app.Application;
import flixel.util.FlxColor;
import flixel.math.FlxMath;
import flixel.FlxCamera;
import flixel.FlxObject;
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

class Tutorial extends FlxState
{
	var bambi:Marcello;
	var subwooferdestroy:Int = 0;
	var subwoofermusic:FlxSound;
	var subwoofermusic2:FlxSound;
	var tutorialmusic:FlxSound;
	var background:FlxSprite;
	var helptext:FlxText;
	var idlething:Float = 0;
	public static var destroyed:Bool = false;
	var bcamerapos:FlxObject;
	var amogusthesususs:FlxTimer;
	public static var musicplayin = false;
	public static var savedone = false;
	var game:FlxCamera;
	var hud:FlxCamera;
	var zoomedout:Bool = false;
	var zoom:Float = 1;
	var tutorialcurrent:Int = 0;
	var transitioning:Bool = false;
	var jumpingcameraperms:Bool = false;
	public static var tutorialdone:Bool = false;
	public static var left:Bool = false;
	var achievementext:FlxText;

	override public function create()
	{
		super.create();
		if (!MiddleOfNowhere.exitedtutorial)
		{
			tutorialdone = true;
			savedone = true;
			musicplayin = true;
		}
		tutorialdone = true;
		musicplayin = true;
		game = new FlxCamera();
		hud = new FlxCamera();
		FlxG.cameras.reset(game);
		FlxG.cameras.add(hud, false);
		FlxG.cameras.setDefaultDrawTarget(game, true);
		hud.bgColor.alpha = 0;
		tutorialmusic = FlxG.sound.load("assets/music/tutorial.ogg", 1, true);
		FlxG.sound.load("assets/music/corn.ogg", 1, true);
		if (!FlxG.sound.music.playing)
			FlxG.sound.playMusic("assets/music/corn.ogg");
		bambi = new Marcello();
		bambi.screenCenter();
		bambi.setOffsets(-340, 2360);
		background = new FlxSprite(0, 0).loadGraphic("assets/images/the funny middle of nowhere.png");
		background.antialiasing = true;
		add(background);
		add(bambi);		
		achievementext = new FlxText(0, 0, 0, "Achievement Unlocked: nothing lol", 28);
		achievementext.cameras = [hud];
		achievementext.font = "assets/fonts/koruri.ttf";
		achievementext.screenCenter(X);
		achievementext.y = -50;
		add(achievementext);
		bambi.y = 700;
		bambi.x = 1200;
		bambi.ybottom.y = bambi.y;
		bcamerapos = new FlxObject(bambi.getGraphicMidpoint().x, bambi.getGraphicMidpoint().y - 65);
		add(bcamerapos);
		FlxG.camera.y += 720;
		FlxG.watch.add(bambi, "x", "bambi x thing");
		FlxG.watch.add(bambi, "y", "bambi y thing");
		FlxG.watch.add(bcamerapos, "x", "camera position x thing");
		FlxG.watch.add(bcamerapos, "y", "camera position y thing");
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 720}, 0.4, {ease: FlxEase.cubeOut});
		FlxG.camera.follow(bcamerapos, LOCKON, 0.05); // 0.05
		helptext = new FlxText(0, 0, 0, "the funny", 22);
		helptext.screenCenter();
		helptext.setFormat("assets/fonts/koruri.ttf", 22);
		helptext.y -= 390;
		add(helptext);
		helptext.cameras = [hud];
		if (savedone && !Left.entered)
		{
			zoomedout = true;
			zoom = 0.525;
			bcamerapos.x = background.getGraphicMidpoint().x;
			bcamerapos.y = background.getGraphicMidpoint().y;
			new FlxTimer().start(0.8, function(fuck:FlxTimer)
			{
				zoomedout = false;
				zoom = 1;
			});
			trace("just came in");
		}
		else
		{
			zoomedout = true;
			zoom = 0.525;
			bcamerapos.x = background.getGraphicMidpoint().x;
			bcamerapos.y = background.getGraphicMidpoint().y;
			if (left)
				bambi.x = bambi.xoffse + 10; // 1575
			else
				bambi.x = bambi.xoffse2 - 10; // 1575
			FlxG.keys.enabled = false;
			if (left)
				new FlxTimer().start(0.6, function(move:FlxTimer)
				{
					bambi.forcemovement = true;
				});
			else
				new FlxTimer().start(0.6, function(move:FlxTimer)
				{
					bambi.forcemovement2 = true;
				});
			bambi.stopmovements = true;
		}
		MiddleOfNowhere.funniest = false;
		Funniest.currentlyplayingmusic = false;
		DiscordClient.changePresence("Playing the maps", null);
		//	Lib.application.window.title = "Bambi's Corn Adventure | Alpha 2 on " + Application.current.window.displayMode.refreshRate + " FPS - Press H to go to the second background";
	}

	override public function update(elapsed:Float)
	{
		trace(background.getGraphicMidpoint().x);
		trace(background.getGraphicMidpoint().y);
		#if !debug
		if (FlxG.keys.justPressed.F2)
		{
			if (FlxG.sound.music.playing)
				FlxG.sound.music.stop();
			if (tutorialmusic.playing)
				tutorialmusic.stop();
			FlxG.switchState(new CheatersGamers());
		}
		#end
		if (bambi.x <= 1500 && bambi.forcemovement2)
		{
			bambi.forcemovement2 = false;
			bambi.animation.play(bambi.attr + "idle", true);

			new FlxTimer().start(0.4, function(zoomincauseyes:FlxTimer)
			{
				zoomedout = false;
				bambi.stopmovements = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer)
				{
					FlxG.keys.enabled = true;
				});
			});
		}
		if (bambi.x >= 450 && bambi.forcemovement)
		{
			left = false;
			bambi.forcemovement = false;
			bambi.animation.play(bambi.attr + "idle", true);

			new FlxTimer().start(0.4, function(zoomincauseyes:FlxTimer)
			{
				zoomedout = false;
				bambi.stopmovements = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer)
				{
					FlxG.keys.enabled = true;
				});
			});
		}
		if (FlxG.keys.justPressed.H)
		{
			achievement();
		}
		FlxG.camera.zoom = FlxMath.lerp(zoom, FlxG.camera.zoom, 0.95);
		if (!zoomedout)
		{
			if (bambi.x >= 405 && bambi.x <= 1630)
			{
				jumpingcameraperms = true;
				bcamerapos.x = bambi.getGraphicMidpoint().x;
				if (tutorialdone)
					zoom = 1;
			}
			if (jumpingcameraperms)
				bcamerapos.y = bambi.getGraphicMidpoint().y - 65;
		}
		super.update(elapsed);
		if (FlxG.keys.justPressed.ESCAPE && !transitioning)
		{
			tutorialmusic.fadeOut(0.65, 0);
			FlxG.sound.music.fadeOut(0.65, 0);
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
		}*/
		if (bambi.x >= bambi.xoffse2 && !transitioning && tutorialdone && !bambi.forcemovement2)
		{
			statetransition(new maps.MiddleOfNowhere(), true);
		}
		if (bambi.x <= bambi.xoffse && !transitioning && tutorialdone && !bambi.forcemovement2)
		{
			statetransition(new maps.Left(), true);
		}
	}

	public function statetransition(state:FlxState, ?iscoolerstate:Bool = false)
	{
		transitioning = true;
		if (iscoolerstate)
		{
			zoomedout = true;
			zoom = 0.525;
			bcamerapos.x = background.getGraphicMidpoint().x;
			bcamerapos.y = background.getGraphicMidpoint().y;
			bambi.stopmovements = true;
			new FlxTimer().start(0.75, function(theyesagaih:FlxTimer)
			{
				FlxTween.tween(FlxG.camera, {y: FlxG.camera.scroll.y + 720}, 0.6, {ease: FlxEase.cubeIn});
				FlxTween.tween(hud, {y: hud.scroll.y + 720}, 0.6, {ease: FlxEase.cubeIn});
				new FlxTimer().start(1.5, function(getback:FlxTimer)
				{
					FlxG.switchState(state);
				});
			});
		}
		else
		{
			FlxTween.tween(FlxG.camera, {y: FlxG.camera.scroll.y + 720}, 0.65, {ease: FlxEase.cubeIn});
			FlxTween.tween(hud, {y: hud.scroll.y + 720}, 0.65, {ease: FlxEase.cubeIn});
			new FlxTimer().start(1, function(getback:FlxTimer)
			{
				FlxG.sound.music.stop();
				MainMenuState.thing = 1;
				FlxG.switchState(state);
			});
		}
	}

	function achievement(text:String = "you forgor input", spanishtext:String = "you forgor text")
	{
		achievementext.text = "Achievement Unlocked: " + text;
        if (FlxG.save.data.lang == "spanish")
            achievementext.text = "Logro Desbloqueado: " + spanishtext;
		achievementext.screenCenter(X);
		FlxTween.tween(achievementext, {y: 20}, 0.25, {ease:FlxEase.cubeOut, onComplete: function(goback:FlxTween){
            new FlxTimer().start(1.5, function(goback:FlxTimer){
                FlxTween.tween(achievementext, {y: -50}, 0.25, {ease:FlxEase.cubeIn});
            });
        }});
        FlxG.sound.play("assets/sounds/achievement.ogg");
	}
}