package maps;

import flixel.math.FlxMath;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import characters.Bambi as Marcello;

using StringTools;

class DaveHouse extends FlxState // to be used as template
{
	public var bambi:Marcello;
	var background:FlxSprite;
	var bcamerapos:FlxObject;
	var game:FlxCamera;
	var hud:FlxCamera;
    var zoomout:Bool = true;
    var zoom:Float = 1;
	var transitioning:Bool = false;
	public static var entered:Bool = false;
	var count:Int = 0;
	var way:String = "center";
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
		FlxG.sound.playMusic("assets/music/dave house walking.ogg");
		bambi = new Marcello();
		background = new FlxSprite(0, 0).loadGraphic("assets/images/dave house.png");
		background.setGraphicSize(Std.int(background.width * 1.5));
		background.antialiasing = true;
		add(background);
		add(bambi);		
		achievementext = new FlxText(0, 0, 0, "Achievement Unlocked: nothing lol", 28);
		achievementext.cameras = [hud];
		achievementext.font = "assets/fonts/koruri.ttf";
		achievementext.screenCenter(X);
		achievementext.y = -50;
		add(achievementext);
		bambi.y = 1250;
		if (Backyard.entered)
			bambi.x = 3600;
		else
		 	bambi.x = 3600;
		bambi.stopmovements = true;
		bambi.setOffsets(-1275, 4645);
		bcamerapos = new FlxObject(bambi.getGraphicMidpoint().x, bambi.getGraphicMidpoint().y - 65);
		add(bcamerapos);
		FlxG.camera.y += 720;
		FlxG.watch.add(bambi, "x", "bambi x thing");
		FlxG.watch.add(bambi, "y", "bambi y thing");
		FlxG.watch.add(bcamerapos, "x", "camera position x thing");
		FlxG.watch.add(bcamerapos, "y", "camera position y thing");
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 720}, 0.4, {ease: FlxEase.cubeOut});
		FlxG.camera.follow(bcamerapos, LOCKON, 5);
		new FlxTimer().start(0.5, function(borderfix:FlxTimer){
			FlxG.camera.follow(bcamerapos, LOCKON, 0.05);
		});
		FlxG.camera.zoom = 0.4;
		new FlxTimer().start(0.6, function(move:FlxTimer){if (Backyard.entered){Backyard.entered = false;bambi.forcemovement2 = true;}else bambi.forcemovement = true;});
		transitioning = true;
		FlxG.keys.enabled = false;
		bambi.ybottom.y = bambi.y;
		entered = true;
		ThirdBranch.entered = false;
		count = 0;
		if (FlxG.save.data.framerate == 15)
			openfl.Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + lime.app.Application.current.window.displayMode.refreshRate + " FPS | Corridor #" + (count + 1);
		else
			openfl.Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + FlxG.drawFramerate + " FPS | Corridor #" + (count + 1);
	} 

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (bambi.x <= 3175 && bambi.forcemovement2)
		{
			bambi.forcemovement2 = false;
			bambi.animation.play(bambi.attr + "idle", true);

			new FlxTimer().start(0.4, function(zoomincauseyes:FlxTimer){
			//	bambi.ybottom.y = bambi.y;
				zoomout = false;
				transitioning = false;
				bambi.stopmovements = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer){
					FlxG.keys.enabled = true;
				});
			});
		}
		if (bambi.x >= 170 && bambi.forcemovement)
		{
			bambi.forcemovement = false;
			bambi.animation.play(bambi.attr + "idle", true);

			new FlxTimer().start(0.4, function(zoomincauseyes:FlxTimer){
			//	bambi.ybottom.y = bambi.y;
				zoomout = false;
				transitioning = false;
				bambi.stopmovements = false;
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
        if (zoomout)
        {
            zoom = 0.35;
			switch (way)
			{
				case "center":
					bcamerapos.x = background.getGraphicMidpoint().x;
				case "left":
					bcamerapos.x = background.getGraphicMidpoint().x - 800;
				case "right":
					bcamerapos.x = background.getGraphicMidpoint().x + 800;
			}
            bcamerapos.y = background.getGraphicMidpoint().y;
        }
        else
        {
            zoom = 1;
		    if (bambi.x >= -550 && bambi.x <= 3920)
		    	bcamerapos.x = bambi.getGraphicMidpoint().x;
		    bcamerapos.y = bambi.getGraphicMidpoint().y - 115;
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
			count--;
			statetransition(new maps.Backyard(), true, false);
		}
		if (bambi.x <= bambi.xoffse && !transitioning && !bambi.forcemovement2)
		{
			count++;
			statetransition(new maps.LeftAgain(), true, true);
		}
		trace(count);
	}
	public function statetransition(state:FlxState, ?iscoolerstate:Bool = false, ?wentleft:Bool = false)
	{
		transitioning = true;
		bambi.stopmovements = true;
		if (iscoolerstate)
		{
			if (count >= 0)
			{
				zoomout = true;
				if (wentleft)
				{
					bambi.x = 3600;
					new FlxTimer().start(0.6, function(move:FlxTimer){
						bambi.forcemovement2 = true;		
						if (FlxG.save.data.framerate == 15)
						openfl.Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + lime.app.Application.current.window.displayMode.refreshRate + " FPS | Corridor #" + (count + 1);
						else
						openfl.Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + FlxG.drawFramerate + " FPS | Corridor #" + (count + 1);
					});
				}
				else
				{
					bambi.x = -235;
					new FlxTimer().start(0.6, function(move:FlxTimer){
						bambi.forcemovement = true;
						if (FlxG.save.data.framerate == 15)
							openfl.Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + lime.app.Application.current.window.displayMode.refreshRate + " FPS | Corridor #" + (count + 1);
						else
							openfl.Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + FlxG.drawFramerate + " FPS | Corridor #" + (count + 1);
					});
				}
			}
			else
			{
				zoomout = true;
				new FlxTimer().start(0.5, function(theyesagaih:FlxTimer){
				FlxTween.tween(FlxG.camera, {y: FlxG.camera.scroll.y + 720}, 0.6, {ease: FlxEase.cubeIn});
				FlxTween.tween(hud, {y: hud.scroll.y + 720}, 0.6, {ease: FlxEase.cubeIn});
					new FlxTimer().start(1.5, function(getback:FlxTimer)
					{
						FlxG.switchState(state);
					});
				});
			}
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