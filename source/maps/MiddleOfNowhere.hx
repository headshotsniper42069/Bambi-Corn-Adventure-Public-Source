package maps;

import flixel.math.FlxRect;
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

class MiddleOfNowhere extends FlxState
{
	var bambi:Marcello;
	var background:FlxSprite;
	var bcamerapos:FlxObject;
	var game:FlxCamera;
	var hud:FlxCamera;
    var zoomout:Bool = true;
	public static var funniest:Bool = false;
    var zoom:Float = 1;
	var transitioning:Bool = false;
	public static var exitedtutorial:Bool = false;
	var achievementext:FlxText;
//    var quikmafsh:Float = (((120 * FlxG.updateFramerate / 120 - 120) / 2 / 10 / 100) * 4) * 8.5; ok no
	override public function create()
	{
		super.create();
		game = new FlxCamera();
		hud = new FlxCamera();
		FlxG.cameras.reset(game);
		FlxG.cameras.add(hud, false);
		FlxG.cameras.setDefaultDrawTarget(game, true);
		hud.bgColor.alpha = 0;
		if ((!Tutorial.musicplayin || Funniest.entered))
		{
			if (Funniest.currentlyplayingmusic && !Tutorial.musicplayin)
			{
				FlxG.sound.playMusic("assets/music/corn.ogg");
				Funniest.currentlyplayingmusic = false;
			}
		}
		Funniest.currentlyplayingmusic = false;
		Tutorial.tutorialdone = true;
		bambi = new Marcello();
		bambi.screenCenter();
        bambi.setOffsets(-1600, 3630);
		background = new FlxSprite(0, 0).loadGraphic("assets/images/awesomest.png");
		background.antialiasing = true;
        background.setGraphicSize(Std.int(background.width * 2));
		add(background);
		add(bambi);		
		achievementext = new FlxText(0, 0, 0, "Achievement Unlocked: nothing lol", 28);
		achievementext.cameras = [hud];
		achievementext.font = "assets/fonts/koruri.ttf";
		achievementext.screenCenter(X);
		achievementext.y = -50;
		add(achievementext);
		if (!funniest)
		{
			bambi.y = 1020;
			bambi.x = -1215; // and goes to -615
		}
		else
		{
			bambi.y = 1546.641;
			bambi.x = 3600; // and goes to -615
		}
		bambi.stopmovements = true;
		bcamerapos = new FlxObject(bambi.getGraphicMidpoint().x, bambi.getGraphicMidpoint().y - 65);
		add(bcamerapos);
		FlxG.camera.y += 720;
		FlxG.watch.add(bambi, "x", "bambi x thing");
		FlxG.watch.add(bambi, "y", "bambi y thing");
		FlxG.watch.add(bcamerapos, "x", "camera position x thing");
		FlxG.watch.add(bcamerapos, "y", "camera position y thing");
		FlxG.watch.add(bambi.ybottom, "x", "bambi y x thing");
		FlxG.watch.add(bambi.ybottom, "y", "bambi y y thing");
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 720}, 0.4, {ease: FlxEase.cubeOut});
		FlxG.camera.follow(bcamerapos, LOCKON, 5);
		new FlxTimer().start(0.5, function(borderfix:FlxTimer){
			FlxG.camera.follow(bcamerapos, LOCKON, 0.05);
		});
		FlxG.camera.zoom = 0.3;
		new FlxTimer().start(0.6, function(move:FlxTimer){if (!funniest)bambi.forcemovement = true;else bambi.forcemovement2 = true;});
		FlxG.keys.enabled = false;
		bambi.ybottom.y = bambi.y;
		Tutorial.savedone = false;
		Tutorial.tutorialdone = true;
		exitedtutorial = true;
		Funniest.insidefarm = false;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		#if !debug
		if (FlxG.keys.justPressed.F2)
		{
			if (FlxG.sound.music.playing)
				FlxG.sound.music.stop();
			FlxG.switchState(new CheatersGamers());
		}
		#end

        FlxG.camera.zoom = FlxMath.lerp(zoom, FlxG.camera.zoom, 0.95);

		if (bambi.x <= bambi.xoffse && !bambi.forcemovement && !transitioning)
		{
			statetransition(new maps.Tutorial(), true);
		}
		else if (bambi.x >= bambi.xoffse2 && !bambi.forcemovement2 && !transitioning)
		{
			statetransition(new maps.Funniest(), true);
		}
        
		if (bambi.x >= -795 && bambi.forcemovement)
		{
			bambi.forcemovement = false;
			bambi.animation.play(bambi.attr + "idle", true);

			new FlxTimer().start(0.4, function(zoomincauseyes:FlxTimer){
			//	bambi.ybottom.y = bambi.y;
				zoomout = false;
				bambi.stopmovements = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer){
					FlxG.keys.enabled = true;
				});
			});
		}
		else if (bambi.x <= 2770 && bambi.forcemovement2)
		{
			bambi.forcemovement2 = false;
			bambi.animation.play(bambi.attr + "idle", true);

			new FlxTimer().start(0.4, function(zoomincauseyes:FlxTimer){
			//	bambi.ybottom.y = bambi.y;
				zoomout = false;
				bambi.stopmovements = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer){
					FlxG.keys.enabled = true;
				});
			});
		}
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
            zoom = 1;
		    if (bambi.x >= -845 && bambi.x <= 2895)
		    	bcamerapos.x = bambi.getGraphicMidpoint().x;
            else
            {
                if (bambi.x <= -845)
                    bcamerapos.x = -608;
                else if (bambi.x >= 2895)
                    bcamerapos.x = 3115;
            }
		    bcamerapos.y = bambi.getGraphicMidpoint().y - 65;
        }

        if (bambi.x >= -910 && bambi.x <= 30 && (bambi.animation.curAnim.name == bambi.attr + 'walk' || bambi.animation.curAnim.name == bambi.attr + 'jump' || bambi.animation.curAnim.name == bambi.attr + 'jumpdown'))
        {
            if (bambi.flipX)
            {	
				if (!bambi.jumping)
				{
                	bambi.y -= 1 / FlxG.updateFramerate * 75 * 3.5 / 2; // what the fuck?
				}
				if (bambi.presses)
					bambi.ybottom.y -= 1 / FlxG.updateFramerate * 75 * 3.5 / 2;
            //    bambi.y -= elapsed * FlxG.updateFramerate;
            }
            else
            {
				if (!bambi.jumping)
				{
                	bambi.y += 1 / FlxG.updateFramerate * 75 * 3.5 / 2;	
				}
				if (bambi.presses)
					bambi.ybottom.y += 1 / FlxG.updateFramerate * 75 * 3.5 / 2; 
            //    bambi.y += elapsed * FlxG.updateFramerate;
            }
        }
        else if (bambi.x >= 30 && bambi.x <= 2980 && (bambi.animation.curAnim.name == bambi.attr + 'walk' || bambi.animation.curAnim.name == bambi.attr + 'jump' || bambi.animation.curAnim.name == bambi.attr + 'jumpdown'))
        {
            if (bambi.flipX)
            {
            //    bambi.y -= elapsed * FlxG.updateFramerate / 2;
				if (!bambi.jumping)
				{
                	bambi.y -= 1 / FlxG.updateFramerate * 75 * 3.5 / 2 / 2;
				}
				if (bambi.presses)
					bambi.ybottom.y -= 1 / FlxG.updateFramerate * 75 * 3.5 / 2 / 2;
            }
            else
            {
            //    bambi.y += elapsed * FlxG.updateFramerate / 2;
				if (!bambi.jumping)
				{
                	bambi.y += 1 / FlxG.updateFramerate * 75 * 3.5 / 2 / 2;
				}
				if (bambi.presses)
					bambi.ybottom.y += 1 / FlxG.updateFramerate * 75 * 3.5 / 2 / 2;
            }
        }
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.sound.music.fadeOut(0.65, 0);
			FlxG.sound.play("assets/sounds/back.ogg");
			statetransition(new MainMenuStateBetter());
			FlxG.keys.enabled = false;
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