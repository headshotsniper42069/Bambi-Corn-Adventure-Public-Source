package;

import Discord.DiscordClient;
import lime.app.Application;
import openfl.Lib;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxState;

class Initializer extends FlxState
{
	var disclaimer:FlxText;
	var cont:FlxText;
	var canclick:Bool = false;
	var ishovering:Bool = false;
	override public function create()
	{
		super.create(); // HAHA NO MODDING FOR YOU LOL
		FlxG.fixedTimestep = false;
		DiscordClient.changePresence("In The Main Menu", null);
		if (FlxG.save.data.framerate == 15)
			Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + FlxG.drawFramerate + " FPS";
		else
			Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + Application.current.window.displayMode.refreshRate + " FPS";
		if (FlxG.save.data.lang == "spanish")
			disclaimer = new FlxText(0, 0, 0, "ADVERTENCIA: \nEste juego no esta asociado con bambi takeover o con nada mas relacionado.\n", 20);
		else
			disclaimer = new FlxText(0, 0, 0, "DISCLAIMER: \nThis game is not associated with bambi takeover or anything else related.\n", 20);
		disclaimer.setFormat("assets/fonts/koruri.ttf", 22, FlxColor.WHITE, FlxTextAlign.CENTER);
		disclaimer.screenCenter();
		disclaimer.y -= 900;
		add(disclaimer);
		cont = new FlxText(0, 0, 0, "Continue", 20);
		if (FlxG.save.data.lang == "spanish")
			cont.text = "Continuar";
		cont.font = "assets/fonts/koruri.ttf";
		cont.screenCenter();
		cont.y += 150;
		cont.alpha = 0;
		add(cont);
		FlxTween.tween(disclaimer, {y: disclaimer.y + 900}, 0.35, {ease: FlxEase.cubeOut});
		FlxG.mouse.visible = true;
		new FlxTimer().start(2.5, function(showcont:FlxTimer){
			FlxTween.tween(cont, {y: cont.y + 50, alpha: 1}, 0.5, {ease: FlxEase.cubeOut, onComplete: function(turn:FlxTween){
				canclick = true;
			}});
		});
		var achievementext:FlxText = new FlxText(0, 0, 0, "Achievement Unlocked: A True One", 28);
		if (FlxG.save.data.lang == "spanish")
			achievementext.text = "Logro Desbloqueado: Uno Verdadero";
		achievementext.font = "assets/fonts/koruri.ttf";
		achievementext.y = -50;
		achievementext.screenCenter(X);
		add(achievementext);
		if (!FlxG.save.data.achievements.contains("A True One"))
		{
			FlxG.save.data.achievements.push("A True One");
			FlxTween.tween(achievementext, {y: 20}, 0.25, {ease:FlxEase.cubeOut, onComplete: function(goback:FlxTween){
				new FlxTimer().start(1.5, function(goback:FlxTimer){
					FlxTween.tween(achievementext, {y: -50}, 0.25, {ease:FlxEase.cubeIn});
				});
			}});
			FlxG.sound.play("assets/sounds/achievement.ogg");
		}
		new Loader().checkfiles();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	/*	if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new RandomVid());
		} */
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(cont) && canclick)
		{
			canclick = false;
			gotomain();
		}
		if (FlxG.mouse.overlaps(cont) && canclick)
		{
			cont.color = 0xFFE100;
			if (!ishovering)
			{
				FlxG.sound.play("assets/sounds/select.ogg", 1);
				ishovering = true;
			}
		}
		else
		{
			cont.color = 0xFFFFFF;
			ishovering = false;
		}
	}

	function gotomain()
	{
		FlxG.mouse.visible = false;
		FlxG.sound.play("assets/sounds/click.ogg", 1);
		FlxTween.tween(cont, {y: cont.y + 50, alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
		FlxTween.tween(disclaimer, {y: disclaimer.y - 100, alpha: 0}, 0.55, {ease: FlxEase.cubeOut, onComplete: function(getback:FlxTween){
			FlxG.switchState(new MainMenuStateBetter());
		}});
	}
}
