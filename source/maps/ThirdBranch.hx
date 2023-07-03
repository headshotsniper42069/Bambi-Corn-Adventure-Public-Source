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
import flixel.text.FlxText;
import characters.Bambi as Marcello;

using StringTools;

class ThirdBranch extends FlxState
{
	public var bambi:Marcello;
	var background:FlxSprite;
	var bcamerapos:FlxObject;
	var game:FlxCamera;
	var hud:FlxCamera;
    var zoomout:Bool = true;
    var zoom:Float = 1;
	var transitioning:Bool = false;
	var preloop:FlxSound;
	public static var entered:Bool = false;
	public static var exitedtutorial:Bool = false;
	public static var gotsniper:Bool = false;
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
		if (SecondBranch.entered || Backyard.entered)
		{
			FlxG.sound.music.pause();
			FlxG.sound.music.volume = 1;
			FlxG.sound.music.loadEmbedded("assets/music/forest post.ogg", true);
			preloop = FlxG.sound.load("assets/music/forest post pre loop.ogg", 1, false, null, false, false, "", function(){FlxG.sound.music.play();});
			preloop.play();
			SecondBranch.entered = false;
			trace(FlxG.sound.music.length);
		}
		bambi = new Marcello();
		background = new FlxSprite(0, 0).loadGraphic("assets/images/out.png");
		background.setGraphicSize(Std.int(background.width * 1.75));
		background.antialiasing = true; 
		add(background);
		add(bambi);		
		achievementext = new FlxText(0, 0, 0, "Achievement Unlocked: nothing lol", 28);
		achievementext.cameras = [hud];
		achievementext.font = "assets/fonts/koruri.ttf";
		achievementext.screenCenter(X);
		achievementext.y = -50;
		add(achievementext);
		bambi.y = 1400;
		if (Backyard.entered)
			bambi.x = -1245;
		else
			bambi.x = 3300; // and goes to 1430
		bambi.stopmovements = true;
		bambi.setOffsets(-1260, 3300);
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
			FlxG.camera.follow(bcamerapos, LOCKON, 0.0175);
		});
		FlxG.camera.zoom = 0.3;
		if (SecondBranch.knockedback)
			new FlxTimer().start(1.5, function(move:FlxTimer){bambi.forcemovement2 = true;});
		else
			new FlxTimer().start(0.6, function(move:FlxTimer){if(Backyard.entered){bambi.forcemovement = true;Backyard.entered = false;}else bambi.forcemovement2 = true;});
		transitioning = true;
		FlxG.keys.enabled = false;
		bambi.ybottom.y = bambi.y;
		entered = true;
		gotsniper = true;
		if (SecondBranch.knockedback)
		{
			new FlxTimer().start(0.25, function(thereheis:FlxTimer){
				bambi.knockbackaftermath("right");
				SecondBranch.knockedback = false;
				Branches.knockedback = false;
			});
		}
		DaveHouse.entered = false;
	} 

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (bambi.x <= 2440 && bambi.forcemovement2)
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
		if (bambi.x >= -400 && bambi.forcemovement)
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
            zoom = 0.3;
            bcamerapos.x = background.getGraphicMidpoint().x;
            bcamerapos.y = background.getGraphicMidpoint().y;
        }
        else
        {
            zoom = 0.9;
		    if (bambi.x >= -450 && bambi.x <= 2500)
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
			statetransition(new maps.SecondBranch(), true);
			new FlxTimer().start(0.25, function(fadeout:FlxTimer){
				FlxG.sound.music.fadeOut(0.7, 0);
				preloop.fadeOut(0.7, 0);
			});
		}
		if (bambi.x <= bambi.xoffse && !transitioning && !bambi.forcemovement2)
		{
			statetransition(new maps.Backyard(), true);
		}
	}
	public function statetransition(state:FlxState, ?iscoolerstate:Bool = false)
	{
		transitioning = true;
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