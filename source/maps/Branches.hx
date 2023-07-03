package maps;

import flixel.system.FlxSound;
import flixel.math.FlxMath;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import characters.Bambi as Marcello;
import characters.BambiShootsMamiOnFortniteNotClickbait as BambiSniper;
import items.SniperRifle as CoolSniper;
import flixel.text.FlxText;
using StringTools;

class Branches extends FlxState
{
	public var bambi:Marcello;
	public var sniperguy:BambiSniper;
	var background:FlxSprite;
	var bcamerapos:FlxObject;
	var game:FlxCamera;
	var hud:FlxCamera;
    var zoomout:Bool = true;
    var zoom:Float = 1;
	var transitioning:Bool = false;
	var shader:FlxSprite;
	public var heavysniper:CoolSniper;
	public static var entered:Bool = false;
	public static var exitedtutorial:Bool = false;
	public static var gotsniper:Bool = false;
	var actuallyequiped:Bool = false;
	public static var shot:Bool = false;
	public static var firsttimehere:Bool = true;
	public static var knockedback:Bool = false;
	var achievementext:FlxText;
	override public function create()
	{
		super.create();
		game = new FlxCamera();
		hud = new FlxCamera();
		FlxG.cameras.reset(game);
		FlxG.cameras.add(hud, false);
		FlxG.cameras.setDefaultDrawTarget(game, true);
		hud.bgColor.alpha = 0;
		if (LeftAgain.entered)
		{
			FlxG.sound.music.pause();
			FlxG.sound.playMusic("assets/music/forest.ogg", 0, true);
			FlxG.sound.music.fadeIn(0.25, 0, 1);
			LeftAgain.entered = false;
			trace(FlxG.sound.music.length);
		}
	//	shader = new FlxSprite(-100, -100).makeGraphic(Std.int(FlxG.width * 4), Std.int(FlxG.height * 4), 0xFF21102b);
		shader = new FlxSprite(-100, -100).makeGraphic(Std.int(FlxG.width * 4), Std.int(FlxG.height * 4), 0xFF000000);
		shader.cameras = [hud];
		shader.alpha = 0.55;
		add(shader);
		bambi = new Marcello();
		background = new FlxSprite(0, 0).loadGraphic("assets/images/night sky.png");
		background.setGraphicSize(Std.int(background.width * 2.5));
		background.antialiasing = true; 
		add(background);
		background.scrollFactor.set(0.4, 0.4);
		addTheParts();
		add(bambi);		
		achievementext = new FlxText(0, 0, 0, "Achievement Unlocked: nothing lol", 28);
		achievementext.cameras = [hud];
		achievementext.font = "assets/fonts/koruri.ttf";
		achievementext.screenCenter(X);
		achievementext.y = -50;
		add(achievementext);
		sniperguy = new BambiSniper();
		add(sniperguy);
		heavysniper = new CoolSniper();
		add(heavysniper);
		bambi.y = 1900;
		if (SecondBranch.entered)
			bambi.x = -1630;
		else
			bambi.x = 3800; // and goes to 1430
		bambi.stopmovements = true;
		sniperguy.stopmovements = true;
		bambi.setOffsets(-2195, 4200);
		sniperguy.setOffsets(-2849, 4200);
		bcamerapos = new FlxObject(bambi.getGraphicMidpoint().x, bambi.getGraphicMidpoint().y - 65);
		add(bcamerapos);
		FlxG.camera.y += 720;
		FlxG.watch.add(bambi, "x", "bambi x thing");
		FlxG.watch.add(bambi, "y", "bambi y thing");
		FlxG.watch.add(sniperguy, "x", "sniper x thing");
		FlxG.watch.add(sniperguy, "y", "sniper y thing");
		FlxG.watch.add(bcamerapos, "x", "camera position x thing");
		FlxG.watch.add(bcamerapos, "y", "camera position y thing");
		FlxG.watch.add(heavysniper, "x", "actual sniper x thing");
		FlxG.watch.add(heavysniper, "y", "actual sniper y thing");
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 720}, 0.4, {ease: FlxEase.cubeOut});
		FlxG.camera.follow(bcamerapos, LOCKON, 5);
		new FlxTimer().start(0.5, function(borderfix:FlxTimer){
			FlxG.camera.follow(bcamerapos, LOCKON, 0.0175);
		});
		FlxG.camera.zoom = 0.4;
		new FlxTimer().start(1.25, function(move:FlxTimer){if (SecondBranch.entered){if (SecondBranch.gotsniper && !SecondBranch.shot)sniperguy.alpha = 1;bambi.forcemovement = true;sniperguy.forcemovement = true;SecondBranch.entered = false;} else{bambi.forcemovement2 = true;sniperguy.forcemovement2 = true;}});
		transitioning = true;
		FlxG.keys.enabled = false;
		bambi.ybottom.y = bambi.y;
		sniperguy.x = bambi.x - 654; // 654
		sniperguy.y = bambi.y - 168; // 168
		sniperguy.ybottom.y = sniperguy.y;
		if (gotsniper && !LeftAgain.shotsniper)
		{
			sniperguy.alpha = 1;
			bambi.alpha = 0;
			heavysniper.alpha = 1;
		}
		else
		{
			sniperguy.alpha = 0;
			heavysniper.alpha = 1;
		//	heavysniper.alpha = 0;
		}
		entered = true;
		heavysniper.x = bambi.x;
		heavysniper.y = sniperguy.y + 332;
		if (SecondBranch.gotsniper && !LeftAgain.shotsniper)
		{
			gotsniper = true;
			actuallyequiped = true;
			heavysniper.angle = 0;
			heavysniper.y = sniperguy.y + 332;
			bambi.alpha = 0;
			sniperguy.alpha = 0;
			if (SecondBranch.shot)
			{
				shot = true;
				heavysniper.shot = true;
				bambi.alpha = 1;
				sniperguy.alpha = 0;
			}
		}
		if (gotsniper)
		{
			heavysniper.alpha = 0;
		}
		if (LeftAgain.shotsniper)
		{
			shot = true;
			gotsniper = true;
			actuallyequiped = true;
			heavysniper.shot = true;
			heavysniper.alpha = 0;
			sniperguy.alpha = 0;
		}
		if (SecondBranch.knockedback)
		{
			new FlxTimer().start(0.25, function(thereheis:FlxTimer){
				bambi.knockbackaftermath("left");
				SecondBranch.knockedback = false;
				Branches.knockedback = false;
			});
		}
		if (firsttimehere) // latency fix
		{
			var a:FlxSprite;
			var b:FlxSprite;
			var c:FlxSprite;
			var d:FlxSprite;
			var e:FlxSprite;
			a = new FlxSprite(0, 0, "assets/images/secondforest/1.png");
			b = new FlxSprite(0, 0, "assets/images/secondforest/2.png");
			c = new FlxSprite(0, 0, "assets/images/secondforest/3.png");
			d = new FlxSprite(0, 0, "assets/images/secondforest/4.png");
			e = new FlxSprite(0, 0, "assets/images/secondforest/5.png");
			a.setGraphicSize(Std.int(a.width * 2.5));
			b.setGraphicSize(Std.int(b.width * 2.5));
			c.setGraphicSize(Std.int(c.width * 2.5));
			d.setGraphicSize(Std.int(d.width * 2.5));
			e.setGraphicSize(Std.int(e.width * 2.5));
			a.antialiasing = true;
			b.antialiasing = true;
			c.antialiasing = true;
			d.antialiasing = true;
			e.antialiasing = true;
			a.scrollFactor.x = 0.8;
			add(a);
			add(b);
			add(c);
			add(d);
			add(e);
			a.alpha = 0;
			b.alpha = 0;
			c.alpha = 0;
			d.alpha = 0;
			e.alpha = 0;
			firsttimehere = false;
		}
	//	FlxG.switchState(new CheatersGamers()); // HAH lmao
	} 

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (bambi.animation.curAnim.name.contains("walk") && (!bambi.stopmovements) && !gotsniper && !LeftAgain.shotsniper)
		{
		/*	if (FlxG.random.bool(0.028))
			{
				trace("chance gotten");
				gotsniper = true;
				FlxTween.tween(heavysniper, {x: bambi.x, y: bambi.y + 120}, 0.75, {ease:FlxEase.cubeIn});
				FlxTween.angle(heavysniper, 0, 720, 0.75, {ease:FlxEase.cubeIn, onComplete: function(goback:FlxTween){
					actuallyequiped = true;
					heavysniper.angle = 0;
					heavysniper.y = sniperguy.y + 332;
					heavysniper.alpha = 0;
					bambi.alpha = 0;
					sniperguy.alpha = 1;
					if (!bambi.animation.curAnim.name.contains("walk"))
					{
						FlxG.camera.scroll.x -= 65;
						FlxTween.tween(FlxG.camera.scroll, {x: FlxG.camera.scroll.x + 65}, 0.75, {ease:FlxEase.cubeOut});
					}
					FlxG.sound.play("assets/sounds/sniper/equip.ogg", 0.6);
				}});
			} */
		}
		if (!gotsniper)
		{
			heavysniper.x = bambi.x - 1000;
			heavysniper.y = bambi.y - 3500;
		}
		else if (actuallyequiped)
		{
			heavysniper.y = sniperguy.y + 332;
		}
		if (!heavysniper.shot)
		{
			heavysniper.flipX = bambi.flipX;
			if (!sniperguy.flipX)
				heavysniper.x = sniperguy.x + 825;
			else
				heavysniper.x = sniperguy.x + 444;
		}
		if (bambi.x <= 3200 && bambi.forcemovement2)
		{
			bambi.forcemovement2 = false;
			sniperguy.forcemovement2 = false;
			bambi.animation.play(bambi.attr + "idle", true);
			sniperguy.animation.play("idle", true);

			new FlxTimer().start(0.9, function(zoomincauseyes:FlxTimer){
			//	bambi.ybottom.y = bambi.y;
				zoomout = false;
				transitioning = false;
				bambi.stopmovements = false;
				sniperguy.stopmovements = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer){
					FlxG.keys.enabled = true;
				});
			});
		}
		if (bambi.x >= -1080 && bambi.forcemovement)
		{
			bambi.forcemovement = false;
			sniperguy.forcemovement = false;
			bambi.animation.play(bambi.attr + "idle", true);
			sniperguy.animation.play("idle", true);

			new FlxTimer().start(0.9, function(zoomincauseyes:FlxTimer){
			//	bambi.ybottom.y = bambi.y;
				zoomout = false;
				transitioning = false;
				bambi.stopmovements = false;
				sniperguy.stopmovements = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer){
					FlxG.keys.enabled = true;
				});
			});
		}
		#if !debug
		if (FlxG.keys.justPressed.F2)
		{
			if (FlxG.sound.music.playing)
				FlxG.sound.music.stop();
			FlxG.switchState(new CheatersGamers());
		}
		#end

        FlxG.camera.zoom = FlxMath.lerp(zoom, FlxG.camera.zoom, 0.95);

		#if debug
        if (FlxG.keys.justPressed.H)
        {
            zoomout = !zoomout;
        }
		#end
		if (FlxG.mouse.justPressed && !heavysniper.shot && actuallyequiped)
		{
			bambi.knockback();
			FlxG.camera.shake(0.1, 0.125);
			bambi.alpha = 1;
			sniperguy.alpha = 0;
			heavysniper.alpha = 1;
			heavysniper.shoot();
			shot = true;
		}
        if (zoomout)
        {
            zoom = 0.25;
            bcamerapos.x = background.getGraphicMidpoint().x;
            bcamerapos.y = background.getGraphicMidpoint().y + 125;
        }
        else
        {
            zoom = 0.8;
		    if (bambi.x >= -1310 && bambi.x <= 3312)
		    	bcamerapos.x = bambi.getGraphicMidpoint().x;
		    bcamerapos.y = bambi.getGraphicMidpoint().y - 165;
        }
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.sound.music.fadeOut(0.65, 0);
			FlxG.sound.play("assets/sounds/back.ogg");
			statetransition(new MainMenuStateBetter());
			FlxG.keys.enabled = false;
		}
		if (bambi.x >= bambi.xoffse2 && !transitioning && !bambi.forcemovement2)
		{
			statetransition(new maps.LeftAgain(), true);
			new FlxTimer().start(0.25, function(fadeout:FlxTimer){
				FlxG.sound.music.fadeOut(0.7, 0);
			});
		}
		if (bambi.x <= bambi.xoffse && !transitioning && !bambi.forcemovement2)
		{
			statetransition(new maps.SecondBranch(), true);
		}
	}
	public function statetransition(state:FlxState, ?iscoolerstate:Bool = false)
	{
		transitioning = true;
		if (bambi.knockedback)
			knockedback = true;
		if (iscoolerstate)
		{
			zoomout = true;
			bambi.stopmovements = true;
			new FlxTimer().start(0.5, function(theyesagaih:FlxTimer){
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
	function addTheParts() // seperate function so that theres no clutter
	{
		var a:FlxSprite;
		var b:FlxSprite;
		var c:FlxSprite;
		var d:FlxSprite;
		var e:FlxSprite;
		a = new FlxSprite(0, 0, "assets/images/forest/1.png");
		b = new FlxSprite(0, 0, "assets/images/forest/2.png");
		c = new FlxSprite(0, 0, "assets/images/forest/3.png");
		d = new FlxSprite(0, 0, "assets/images/forest/4.png");
		e = new FlxSprite(0, 0, "assets/images/forest/5.png");
		a.setGraphicSize(Std.int(a.width * 2.5));
		b.setGraphicSize(Std.int(b.width * 2.5));
		c.setGraphicSize(Std.int(c.width * 2.5));
		d.setGraphicSize(Std.int(d.width * 2.5));
		e.setGraphicSize(Std.int(e.width * 2.5));
		a.antialiasing = true;
		b.antialiasing = true;
		c.antialiasing = true;
		d.antialiasing = true;
		e.antialiasing = true;
		a.scrollFactor.x = 0.8;
		add(a);
		add(b);
		add(c);
		add(d);
		add(e);
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