package maps;

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

class NewerTutorial extends FlxState
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

	var tutorialtext:Array<String> = [
		"welcome to the tutorial of bambi's corn adventure!",
		"actually, we're in the middle of nowhere, i dont know why the camera is focusing at you to be honest",
		"let me just...",
		"there",
		"you're probably familiar with the basic controls right?",
		"uhhh...alright",
		"press A/D or the Left/Right arrow keys to move",
		"press W, space or the up arrow key to jump",
		"...thats just the basic controls",
		"i knew it see i spared you the time", // 9
		"alright you can go to the map now" // 10
	];
	var game:FlxCamera;
	var hud:FlxCamera;
	var zoomedout:Bool = false;
	var zoom:Float = 1;
	var tutorialcurrent:Int = 0;
	var transitioning:Bool = false;
	var jumpingcameraperms:Bool = false;

	public static var tutorialdone:Bool = false;
	public static var left:Bool = false;

	override public function create()
	{
		super.create();
		if (FlxG.save.data.tutorialdone && !MiddleOfNowhere.exitedtutorial)
		{
			tutorialdone = true;
			savedone = true;
			musicplayin = true;
		}
		if (FlxG.save.data.lang == "spanish")
		{
			tutorialtext = [
				"bienvenido a el tutorial de la aventura de maíz de bambi!",
				"Actualmente, estamos en mitad de la nada, no se porque la cámara esta enfocada en ti para ser honesto",
				"déjame solo...",
				"asi",
				"tu probablemente ya sabes cuales son los controles básicos ¿verdad?",
				"uhhh ok",
				"pulsa A/D para o las flechas izquierda/derecha para moverte",
				"preciona W o la flecha de arriba para saltar",
				"...esos son los controles básicos",
				"lo sabia parece que te he salvado el tiempo",
				"ok puedes ir a ver el mapa ahora"
			];
		}
		game = new FlxCamera();
		hud = new FlxCamera();
		FlxG.cameras.reset(game);
		FlxG.cameras.add(hud, false);
		FlxG.cameras.setDefaultDrawTarget(game, true);
		hud.bgColor.alpha = 0;
		tutorialmusic = FlxG.sound.load("assets/music/tutorial.ogg", 1, true);
		FlxG.sound.load("assets/music/corn.ogg", 1, true);
		if (!tutorialdone)
			tutorialmusic.play();
		else
			musicplayin = true;
		if (FlxG.save.data.tutorialdone && !FlxG.sound.music.playing)
			FlxG.sound.playMusic("assets/music/corn.ogg");
		bambi = new Marcello();
		bambi.screenCenter();
		bambi.setOffsets(-340, 2360);
		background = new FlxSprite(0, 0).loadGraphic("assets/images/the funny middle of nowhere.png");
		background.antialiasing = true;
		add(background);
		add(bambi);		
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
		if (!tutorialdone)
			tutorialtextstuff();
		else if (savedone && !Left.entered)
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
			bambi.animation.play("idle", true);

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
			bambi.animation.play("idle", true);

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
		/*	if (FlxG.keys.justPressed.H)
			{
				FlxG.switchState(new maps.MiddleOfNowhere());
		}*/
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
		if ((FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A || FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D || FlxG.keys.justPressed.W
			|| FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.UP)
			&& tutorialcurrent == 1)
		{
			tutorialcurrent++;
			amogusthesususs.cancel();
			tutorialstuffdid();
		}
		if (tutorialcurrent >= 1)
		{
			trace(amogusthesususs.timeLeft);
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

	function tutorialtextstuff() // timers be like
	{
		var times:Array<Float> = [0.75, 3.6, 8.2, 10.93, 11.61, 13.54]; // 4th one not text
		new FlxTimer().start(times[0], function(getback:FlxTimer)
		{
			helptext.text = tutorialtext[0];
			helptext.screenCenter();
			helptext.y -= 390;
			FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
		});
		new FlxTimer().start(times[1], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef1:FlxTween)
				{
					helptext.text = tutorialtext[1];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
		});
		new FlxTimer().start(times[2], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef2:FlxTween)
				{
					helptext.text = tutorialtext[2];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
		});
		new FlxTimer().start(times[3], function(getback:FlxTimer)
		{
			zoomedout = true;
			zoom = 0.525;
			bcamerapos.x = background.getGraphicMidpoint().x;
			bcamerapos.y = background.getGraphicMidpoint().y;
		});
		new FlxTimer().start(times[4], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef2:FlxTween)
				{
					helptext.text = tutorialtext[3];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
		});
		new FlxTimer().start(times[5], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef2:FlxTween)
				{
					helptext.text = tutorialtext[4];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut, onComplete: function(fucking:FlxTween)
					{
						amogusthesususs = new FlxTimer().start(4, tutorialstuffdidnt);
						tutorialcurrent++;
					}});
				}
			});
		});
	}

	function tutorialstuffdid()
	{
		tutorialcurrent++;
		amogusthesususs.cancel();
		FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
			ease: FlxEase.cubeIn,
			onComplete: function(thef2:FlxTween)
			{
				helptext.text = tutorialtext[9];
				helptext.screenCenter();
				helptext.y -= 390;
				FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
			}
		});
		new FlxTimer().start(4.2, function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef2:FlxTween)
				{
					helptext.text = tutorialtext[10];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
			new FlxTimer().start(2.75, function(bruhbruh:FlxTimer)
			{
				tutorialmusic.fadeOut(0.75, 0, function(fucking:FlxTween)
				{
					tutorialdone = true;
					FlxG.save.data.tutorialdone = true;
					if (bambi.x >= bambi.xoffse2) // yes this is copy pasted
						statetransition(new maps.MiddleOfNowhere(), true);
					else
					{
						FlxG.sound.playMusic("assets/music/corn.ogg");
						musicplayin = true;
						zoomedout = false;
						zoom = 1;
					}
					if (bambi.x <= 405)
						bcamerapos.x = 725;
				});
				FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {ease: FlxEase.cubeIn});
			});
		});
	}

	function tutorialstuffdidnt(bruhwhy:FlxTimer)
	{
		tutorialcurrent++;
		var tiempos:Array<Float> = [0, 2.5, 6.3, 10.6, 14.2, 17.1];
		new FlxTimer().start(tiempos[0], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef1:FlxTween)
				{
					helptext.text = tutorialtext[5];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
		});
		new FlxTimer().start(tiempos[1], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef2:FlxTween)
				{
					helptext.text = tutorialtext[6];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
		});
		new FlxTimer().start(tiempos[2], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef2:FlxTween)
				{
					helptext.text = tutorialtext[7];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
		});
		new FlxTimer().start(tiempos[3], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef2:FlxTween)
				{
					helptext.text = tutorialtext[8];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
		});
		new FlxTimer().start(tiempos[4], function(getback:FlxTimer)
		{
			FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {
				ease: FlxEase.cubeIn,
				onComplete: function(thef2:FlxTween)
				{
					helptext.text = tutorialtext[10];
					helptext.screenCenter();
					helptext.y -= 390;
					FlxTween.tween(helptext, {y: helptext.y + 170}, 0.35, {ease: FlxEase.cubeOut});
				}
			});
			new FlxTimer().start(2.75, function(bruhbruh:FlxTimer)
			{
				tutorialmusic.fadeOut(0.75, 0, function(fucking:FlxTween)
				{
					tutorialdone = true;
					FlxG.save.data.tutorialdone = true;
					if (bambi.x >= bambi.xoffse2) // yes this is copy pasted
						statetransition(new maps.MiddleOfNowhere(), true);
					else
					{
						FlxG.sound.playMusic("assets/music/corn.ogg");
						musicplayin = true;
						zoomedout = false;
						zoom = 1;
					}
					if (bambi.x <= 405)
						bcamerapos.x = 725;
				});
				FlxTween.tween(helptext, {y: helptext.y - 170}, 0.35, {ease: FlxEase.cubeIn});
			});
		});
	}
}