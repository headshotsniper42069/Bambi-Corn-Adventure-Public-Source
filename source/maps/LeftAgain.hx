package maps;

import lime.app.Application;
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

class LeftAgain extends FlxState
{
	public var bambi:Marcello;
	var background:FlxSprite;
	var bcamerapos:FlxObject;
	var game:FlxCamera;
	var hud:FlxCamera;
    var zoomout:Bool = true;
    var zoom:Float = 1;
	var transitioning:Bool = false;
	var firsttime:Bool = false;
	public static var entered:Bool = false;
	public static var shotsniper:Bool = false;
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
		bambi = new Marcello();
		background = new FlxSprite(0, 0).loadGraphic("assets/images/oh whats that at the left.png");
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
		bambi.y = 900;
		if (Branches.entered)
			bambi.x = -750;
		else
			bambi.x = 3019; // and goes to 1430
		bambi.stopmovements = true;
		bambi.setOffsets(-1000, 3020);
		if (Branches.knockedback)
			new FlxTimer().start(1.5, function(move:FlxTimer){if (Branches.entered){bambi.forcemovement = true; Branches.entered = false;} else bambi.forcemovement2 = true;});
		else
			new FlxTimer().start(0.6, function(move:FlxTimer){if (Branches.entered){bambi.forcemovement = true; Branches.entered = false;} else bambi.forcemovement2 = true;});
		if (Branches.entered)
		{
			FlxG.sound.music.pause();
			FlxG.sound.music.volume = 1;
			FlxG.sound.playMusic("assets/music/corn.ogg", true);
		}
		else if (!Left.entered)
			FlxG.sound.playMusic("assets/music/corn.ogg");
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
		transitioning = true;
		FlxG.keys.enabled = false;
		bambi.ybottom.y = bambi.y;
		entered = true;
		if (!FlxG.save.data.firsttime && !FlxG.save.data.alreadyenteredagain)
			FlxG.save.data.firsttime = true;
		FlxG.save.data.alreadyenteredagain = true;
		Tutorial.musicplayin = true;
		if (Branches.shot || Branches.gotsniper)
		{
			shotsniper = true;
		}
		if (Branches.knockedback)
		{
			new FlxTimer().start(0.25, function(thereheis:FlxTimer){
				bambi.knockbackaftermath("left");
				SecondBranch.knockedback = false;
				Branches.knockedback = false;
			});
		}
	} 

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (bambi.x <= 2070 && bambi.forcemovement2)
		{
			bambi.forcemovement2 = false;
			bambi.animation.play(bambi.attr + "idle", true);

			new FlxTimer().start(0.4, function(zoomincauseyes:FlxTimer){
			//	bambi.ybottom.y = bambi.y;
				zoomout = false;
				transitioning = false;
				bambi.stopmovements = false;
				FlxG.save.data.firsttime = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer){
					FlxG.keys.enabled = true;
				});
			});
		}
		if (bambi.x >= -128 && bambi.forcemovement)
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
			if (FlxG.save.data.firsttime)
            	zoom = 0.6;
			else
				zoom = 0.4;
			if (FlxG.save.data.firsttime)
			{
            	bcamerapos.x = background.getGraphicMidpoint().x + 640;
				bcamerapos.y = background.getGraphicMidpoint().y + 120;
			}
			else
			{
				bcamerapos.x = background.getGraphicMidpoint().x;
            	bcamerapos.y = background.getGraphicMidpoint().y;
			}
        }
        else
        {
            zoom = 1;
		    if (bambi.x >= -200 && bambi.x <= 2230)
		    	bcamerapos.x = bambi.getGraphicMidpoint().x;
		    bcamerapos.y = bambi.getGraphicMidpoint().y - 65;
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
			statetransition(new maps.Left(), true);
		}
		if (bambi.x <= bambi.xoffse && !transitioning && !bambi.forcemovement2)
		{
		/*	zoomout = true;
			bambi.stopmovements = true;
			transitioning = true;
			new FlxTimer().start(0.6, function(youthought:FlxTimer){
				FlxTween.cancelTweensOf(bambi);
				FlxG.sound.play("assets/sounds/aw man.ogg");
				FlxG.camera.shake(0.05, 0.125);
				FlxTween.tween(bambi, {x: bambi.x + 470 * 4.5}, 0.65, {ease:FlxEase.cubeOut, onComplete:function(turnonmoving:FlxTween){
					bambi.stopmovements = false;
				}});
				FlxTween.tween(bambi, {y: bambi.y - 440}, 0.55, {ease:FlxEase.cubeOut, onComplete: function(getdownagain:FlxTween){
					bambi.getdown();
				}});
				bambi.jumping = true;
				bambi.jumpingdown = true;
				bambi.animation.play("jumpdown", true);
			});
			new FlxTimer().start(2.5, function(a:FlxTimer){
				zoomout = false;
				transitioning = false;
			}); */
		
			statetransition(new Branches(), true);
			new FlxTimer().start(0.25, function(fadeout:FlxTimer){
					FlxG.sound.music.fadeOut(0.7, 0);
			});
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