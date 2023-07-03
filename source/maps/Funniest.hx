package maps;

import flixel.text.FlxText;
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
import characters.BambiHesDead as BambiPhone;

using StringTools;

class Funniest extends FlxState
{
	public var bambi:Marcello;
	var bambisplit:BambiPhone;
	var background:FlxSprite;
	var bcamerapos:FlxObject;
	var game:FlxCamera;
	var hud:FlxCamera;
    var zoomout:Bool = true;
    var zoom:Float = 1;
	var transitioning:Bool = false;
	public static var entered:Bool = false;
	public static var currentlyplayingmusic:Bool = false;
	var down:Array<Float>;
	var left:Array<Float>;
	var right:Array<Float>;
	var up:Array<Float>;
	var idle:Array<Float>;
	var repositionx:Float;
	var repositiony:Float;
	var repositionybottomy:Float;
	var helptext:FlxText;
	var splitathonbambithing:FlxSound;
	var endingmusic:FlxSound;
	var endingimage:FlxSprite;
	var whatsupmyhell:FlxSprite;
	var generated:Bool = false;
	var corncooldown:Float = 0;
	public static var insidefarm:Bool = false;
	public static var alreadygotone:Bool = false;
	var achievementext:FlxText;
//    var quikmafsh:Float = (((120 * FlxG.updateFramerate / 120 - 120) / 2 / 10 / 100) * 4) * 8.5; ok no
	override public function create()
	{
		super.create();
		game = new FlxCamera();
		hud = new FlxCamera();
		down = [0.001, 0.52, 1.63, 1.76, 2.34];
		left = [1.66, 1.79, 2.08];
		right = [1.04, 1.17, 1.56, 1.69, 1.85, 2.60, 2.87, 3];
		up = [1.30, 1.59, 1.72, 1.82];
		idle = [0.26, 0.78];
		FlxG.cameras.reset(game);
		FlxG.cameras.add(hud, false);
		FlxG.cameras.setDefaultDrawTarget(game, true);
		hud.bgColor.alpha = 0;
		FlxG.sound.playMusic("assets/music/farm.ogg");
		endingmusic = FlxG.sound.load("assets/sounds/what the fuck.ogg");
		splitathonbambithing = FlxG.sound.load("assets/sounds/baldi.ogg");
		currentlyplayingmusic = true;
		bambi = new Marcello();
		helptext = new FlxText(0, 0, 0, "the funny", 22);
		helptext.screenCenter();
        helptext.setFormat("assets/fonts/koruri.ttf", 22);
		helptext.y -= 390;
		add(helptext);
		helptext.cameras = [hud];
		bambi.screenCenter();
		whatsupmyhell = new FlxSprite(0, 0, "assets/images/whats up my hell calling you.png");
		bambisplit = new BambiPhone();
		endingimage = new FlxSprite(0, 0, "assets/images/endings/something idk ending.png");
		endingimage.cameras = [hud];
		endingimage.visible = false;
		add(endingimage);
    //    bambi.setOffsets(-305, 2350);
		background = new FlxSprite(0, 0).loadGraphic("assets/images/farm.png");
		background.antialiasing = true;
		add(background);
		add(bambi);		
		achievementext = new FlxText(0, 0, 0, "Achievement Unlocked: nothing lol", 28);
		achievementext.cameras = [hud];
		achievementext.font = "assets/fonts/koruri.ttf";
		achievementext.screenCenter(X);
		achievementext.y = -50;
		add(achievementext);
		add(bambisplit);
		add(whatsupmyhell);
		whatsupmyhell.alpha = 0;
		whatsupmyhell.setGraphicSize(Std.int(whatsupmyhell.width / 3));
		bambi.y = 825;
		bambi.x = -325; // and goes to -615
		bambi.stopmovements = true;
		bcamerapos = new FlxObject(bambi.getGraphicMidpoint().x, bambi.getGraphicMidpoint().y - 65);
		add(bcamerapos);
		FlxG.camera.y += 720;
		FlxG.watch.add(bambi, "x", "bambi x thing");
		FlxG.watch.add(bambi, "y", "bambi y thing");
		FlxG.watch.add(bcamerapos, "x", "camera position x thing");
		FlxG.watch.add(bcamerapos, "y", "camera position y thing");
		FlxG.watch.add(whatsupmyhell, "x", "whats up my hell x thing");
		FlxG.watch.add(whatsupmyhell, "y", "whats up my hell y thing");
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 720}, 0.4, {ease: FlxEase.cubeOut});
		FlxG.camera.follow(bcamerapos, LOCKON, 5);
		new FlxTimer().start(0.5, function(borderfix:FlxTimer){
			FlxG.camera.follow(bcamerapos, LOCKON, 0.05);
		});
		FlxG.camera.zoom = 0.525;
		new FlxTimer().start(0.6, function(move:FlxTimer){bambi.forcemovement = true;});
		transitioning = true;
		FlxG.keys.enabled = false;
		bambi.ybottom.y = bambi.y;
		entered = true;
		repositionx = bambi.x;
		repositiony = bambi.y;
		repositionybottomy = bambi.ybottom.y;
		Tutorial.musicplayin = false;
		insidefarm = true;
	} 

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		corncooldown += elapsed;
		bambisplit.setPosition(bambi.x + 100, bambi.y + 154);
		#if !debug
		if (FlxG.keys.justPressed.F2)
		{
			if (FlxG.sound.music.playing)
				FlxG.sound.music.stop();
			FlxG.switchState(new CheatersGamers());
		}
		#end
		if (FlxG.keys.justPressed.E && bambi.animation.curAnim.name == "jumpdown")
			trace("it works");

        FlxG.camera.zoom = FlxMath.lerp(zoom, FlxG.camera.zoom, 0.95);

		if (bambi.x <= bambi.xoffse && !bambi.forcemovement && !transitioning)
		{
			maps.MiddleOfNowhere.funniest = true;
			statetransition(new maps.MiddleOfNowhere(), true);
		}
        
		if (bambi.x >= 550 && bambi.forcemovement)
		{
			bambi.forcemovement = false;
			bambi.animation.play(bambi.attr + "idle", true);
			bambi.setOffsets(-305, 2350);

			new FlxTimer().start(0.4, function(zoomincauseyes:FlxTimer){
			//	bambi.ybottom.y = bambi.y;
				zoomout = false;
				bambi.stopmovements = false;
				transitioning = false;
				new FlxTimer().start(0.6, function(fix:FlxTimer){
					FlxG.keys.enabled = true;
				});
			});
		}
		if ((bambi.x <= 650 || bambi.x >= 1200) && FlxG.keys.justPressed.E && bambi.jumping)
		{
			if (!bambi.hascorn && !alreadygotone)
			{
				FlxG.sound.music.volume = 0.3;
				FlxG.sound.play("assets/sounds/click.ogg");
				FlxG.sound.play("assets/sounds/corn collect.ogg");
				FlxG.camera.zoom += 0.2;	
				if (bambi.animation.curAnim.name == "jumpdown")
					bambi.animation.play("cornjumpdown");
				bambi.hascorn = true;
				Inventory.corn = true;
				new FlxTimer().start(1.5, function(fadeinagain:FlxTimer){
					FlxG.sound.music.fadeIn(0.35, 0.3, 1);
				});
				new FlxTimer().start(0.5, function(fadeinagain:FlxTimer){
					if (!FlxG.save.data.achievements.contains("Classic"))
					{
						achievement("Classic", "Clásico");
						FlxG.save.data.achievements.push("Classic");
					}
				});
				alreadygotone = true;
			}
			else if (alreadygotone && corncooldown >= 0.2)
			{
				FlxG.sound.play("assets/sounds/back.ogg");
				FlxG.camera.zoom -= 0.03;
				corncooldown = 0;
			}
		}
		if ((bambi.x <= 650 || bambi.x >= 1200) && bambi.jumping && !bambi.hascorn)
		{
			if (!generated && !FlxG.save.data.cornstackseen)
				generatehelp(FlxG.save.data.lang == "spanish" ? "Preciona E cuando saltes detras del maiz" : "Press E when jumping behind a corn stack", 2.5, 0);
		}
		if (bambi.hascorn && !generated && !FlxG.save.data.xkeyseen)
				generatehelp(FlxG.save.data.lang == "spanish" ? "Preciona X para comer el maiz" : "Press X to use the corn", 2, 1, 1.25);
		#if debug
        if (FlxG.keys.justPressed.H)
        {
            zoomout = !zoomout;
        }
		if (FlxG.keys.justPressed.K)
			whatsupmyhell.setPosition(bambi.x - 107, bambi.y + 112);
		if (FlxG.keys.justPressed.C)
			bambi.hascorn = !bambi.hascorn;
		if (FlxG.keys.justPressed.L)
			dothesplitathon();
		if (FlxG.keys.justPressed.R)
		{
			FlxG.save.data.cornstackseen = false;
			FlxG.save.data.xkeyseen = false;
		}
		#end
        if (zoomout)
        {
            zoom = 0.525;
            bcamerapos.x = background.getGraphicMidpoint().x;
            bcamerapos.y = background.getGraphicMidpoint().y;
        }
        else
        {
            zoom = 1;
		    if (bambi.x >= 415 && bambi.x <= 1615)
		    	bcamerapos.x = bambi.getGraphicMidpoint().x;
            else
            {
                if (bambi.x <= 1615)
                    bcamerapos.x = 665;
                else if (bambi.x >= 415)
                    bcamerapos.x = 1840;
            }
		    bcamerapos.y = bambi.getGraphicMidpoint().y - 65;
        }
		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.sound.music.fadeOut(0.65, 0);
			FlxG.sound.play("assets/sounds/back.ogg");
			statetransition(new MainMenuStateBetter());
			FlxG.keys.enabled = false;
		}
		// 2.25
		if (FlxG.keys.justPressed.X && !bambi.jumping && bambi.hascorn && bambi.animation.curAnim.name != "cornwalk")
			new FlxTimer().start(2.25, function(dothething:FlxTimer){whatsupmyhellcallingyou();});
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
	public function generatehelp(text:String, duration:Float, ?whichonegot:Int, ?delay:Float)
	{
		generated = true;
		helptext.text = text;
		helptext.screenCenter();
		helptext.y -= 390;
		helptext.alpha = 0;
		if (whichonegot != null)
			switch (whichonegot)
			{
				case 0: // Corn Stack
					FlxG.save.data.cornstackseen = true;
				case 1: // X key
					FlxG.save.data.xkeyseen = true;
			}
		FlxTween.tween(helptext, {y: helptext.y + 170, alpha: 1}, 0.35, {ease: FlxEase.cubeOut});
		if (delay != null)
			new FlxTimer().start(delay, function(getdowndelay:FlxTimer){
				new FlxTimer().start(duration, function(getdown:FlxTimer){
					FlxTween.tween(helptext, {y: helptext.y + 170, alpha: 0}, 0.5, {ease: FlxEase.cubeIn, onComplete: function(bruh:FlxTween){
						generated = false;
					}});
				});
			});
		else
			new FlxTimer().start(duration, function(getdown:FlxTimer){
				FlxTween.tween(helptext, {y: helptext.y + 170, alpha: 0}, 0.5, {ease: FlxEase.cubeIn, onComplete: function(bruh:FlxTween){
					generated = false;
				}});
			});
	}
	public function whatsupmyhellcallingyou()
	{
		FlxG.sound.music.fadeOut(0.75, 0, function(whatu:FlxTween){
			new FlxTimer().start(0.5, function(done2:FlxTimer){
				FlxG.sound.play("assets/sounds/whats up my hell calling you.ogg");
				bambi.hascorn = false;
				Inventory.corn = false;
				bambi.alpha = 0;
				whatsupmyhell.setPosition(bambi.x - 107, bambi.y + 112);
				whatsupmyhell.alpha = 1;
				new FlxTimer().start(1.5028, function(done3:FlxTimer){
					dothesplitathon();
				});
			});
		});
	}
	function dothesplitathon()
	{
		bambi.stopmovements = true;
		FlxG.keys.enabled = false;
		bambisplit.alpha = 1;
		bambi.alpha = 0;
		whatsupmyhell.alpha = 0;
		FlxG.sound.play("assets/sounds/stop stop bullying dave.ogg");
		bambi.flipX = false;
		for (l in left)
		{
			new FlxTimer().start(l, function(left:FlxTimer) {
				bambisplit.playanimation("left");
			});
		}
		for (r in right)
		{
			new FlxTimer().start(r, function(right:FlxTimer) {
				bambisplit.playanimation("right");
			});
		}
		for (u in up)
		{
			new FlxTimer().start(u, function(up:FlxTimer) {
				bambisplit.playanimation("up");
			});
		}
		for (d in down)
		{
			new FlxTimer().start(d, function(down:FlxTimer) {
				bambisplit.playanimation("down");
			});
		}
		for (i in idle)
		{
			new FlxTimer().start(i, function(idle:FlxTimer) {
				bambisplit.playanimation("idle");
			});
		}
		new FlxTimer().start(3.13, function(WHATTHEWHAAAAA:FlxTimer){
			bambisplit.alpha = 0;
			bambi.alpha = 1;
			bambi.noclip();
			new FlxTimer().start(0.51720, function(uhh:FlxTimer){
				ending();
				reposition();
			});
		});
	}
	function reposition()
	{
		bambi.y = repositiony;
		bambi.ybottom.y = repositionybottomy;
	}
	function ending()
	{
		FlxG.sound.music.pause();
		endingmusic.play();
		endingimage.visible = true;
		FlxTween.cancelTweensOf(bambi);
		reposition();
		new FlxTimer().start(1.1, function(back:FlxTimer){
            splitathonbambithing.play();
			bambi.forcedown = false;
			bambi.jumping = false;
			bambi.jumpingdown = false;
			bambi.stopmovements = false;
            new FlxTimer().start(0.125, function(getback:FlxTimer){
				reposition();
				splitathonbambithing.stop();
				endingmusic.stop();
				FlxG.keys.enabled = true;
				endingimage.visible = false;
				FlxG.sound.music.play();
				FlxG.sound.music.volume = 1;
			});
        });
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