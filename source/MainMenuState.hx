package;

import maps.Tutorial;
import maps.MiddleOfNowhere;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;
import openfl.Lib;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxState;

class MainMenuState extends FlxState
{
    var phone:FlxText;
	var phone2:FlxText;
	var phone3:FlxText;
	var phone4:FlxText;
	var phone5:FlxText;
	var phone6:FlxText;
	var title:FlxText;
	var version:FlxText;
	var funny:FlxSprite;
	public static var versionagain:String = "Alpha 5";
	var creditsbutton:FlxButton;
	var play:FlxButton;
	var language:FlxButton;
	var canpressenter:Bool = false;
	var mainmenu:FlxSound;
	var mainmenu2:FlxSound;
	public static var alreadylaunched:Bool = false;
	public static var clicked:Bool = false;
	public static var thing:Int = 0;
	public static var alreadypressed:Bool = false;
	override public function create()
	{
		MiddleOfNowhere.exitedtutorial = false;
		FlxG.keys.enabled = true;
		alreadypressed = false;
		mainmenu = FlxG.sound.load("assets/music/mainmenu1.ogg");
		mainmenu2 = FlxG.sound.load("assets/music/mainmenu2.ogg");
		if (!alreadylaunched)
		{
			FlxG.sound.playMusic("assets/music/mainmenu1.ogg", 0, false);
			FlxG.sound.music.fadeIn(0.75, 0, 1);
		}
		if (!alreadylaunched)
		{
			if (FlxG.save.data.lang == "spanish")
			{
				phone = new FlxText(0, 0, 0, "headshotsniper presenta", 16);
				phone2 = new FlxText(0, 0, 0, "Creditos adicionales para:", 16);
				phone3 = new FlxText(0, 0, 0, "H-Corp - Jugador de fortnite", 16);
				phone4 = new FlxText(0, 0, 0, "vicholama0 - Traducciones a el español", 16);
				if (FlxG.random.bool(1))
					phone4.text = "vicholamagamer - Traducciones a el español";
				phone5 = new FlxText(0, 0, 0, "Mo is Loud Asf - Artista de el fondo", 16);
				phone6 = new FlxText(0, 0, 0, "Super Gold Bro - La musica del menu", 16);
			}
			else
			{
				phone = new FlxText(0, 0, 0, "headshotsniper presents", 16);
				phone2 = new FlxText(0, 0, 0, "Additional credits to:", 16);
				phone3 = new FlxText(0, 0, 0, "H-Corp - Fortnite Gamer", 16);
				phone4 = new FlxText(0, 0, 0, "vicholama0 - Spanish Translations", 16);
				if (FlxG.random.bool(1))
					phone4.text = "vicholamagamer - Spanish Translations";
				phone5 = new FlxText(0, 0, 0, "Mo is Loud Asf - Background Artist", 16);
				phone6 = new FlxText(0, 0, 0, "Super Gold Bro - the menu music", 16);
			}
		}
		if (alreadylaunched)
		{
			switch (thing){
				case 0:
					FlxG.camera.y = 795;
				case 1:
					FlxG.camera.y = -795;
			}
		}
		funny = new FlxSprite(0, 0, "assets/images/farmland.png");
		title = new FlxText(0, 0, 0, "Bambi's Corn Adventure", 44);
		version = new FlxText(0, 0, 0, versionagain, 20);
		creditsbutton = new FlxButton(0, 0, "Credits", function()
		{
			alreadylaunched = true;
			if (!alreadypressed)
			{
				statetransition(new Credits());
			}
		});
		play = new FlxButton(0, 0, "Start", function()
		{
			alreadylaunched = true;
			if (!alreadypressed)
			{
				statetransition(new maps.Tutorial(), true);
			}
		});
		language = new FlxButton(0, 0, "Language", function()
		{
			alreadylaunched = true;
			if (!alreadypressed)
			{
				statetransition(new Language(), false);
			}
		});
		if (FlxG.save.data.lang == "spanish")
			language.text = "Idioma";
		
		if (FlxG.save.data.lang == "spanish")
			play.text = "Comenzar";
		if (FlxG.save.data.lang == "spanish")
			creditsbutton.text = "Creditos";
		if (!alreadylaunched)
		{
			phone.setFormat("assets/fonts/koruri.ttf", 27);
			phone2.setFormat("assets/fonts/koruri.ttf", 27);
			phone3.setFormat("assets/fonts/koruri.ttf", 27);
			phone4.setFormat("assets/fonts/koruri.ttf", 27);
			phone5.setFormat("assets/fonts/koruri.ttf", 27);
			phone6.setFormat("assets/fonts/koruri.ttf", 27);
		}
		title.setFormat("assets/fonts/koruri.ttf", 27);
		version.setFormat("assets/fonts/koruri.ttf", 20);
		if (!alreadylaunched)
		{
			phone.screenCenter();
			phone2.screenCenter();
			phone3.screenCenter();
			phone4.screenCenter();
			phone5.screenCenter();
			phone6.screenCenter();
		}
		creditsbutton.screenCenter();
		play.screenCenter();
		language.screenCenter();
		title.screenCenter();
		version.screenCenter();
		if (!alreadylaunched)
		{
			phone.y = 720;
			phone2.y = 720;
			phone3.y = 720;
			phone4.y = 720;
			phone5.y = 720;
			phone6.y = 720;
		}
		creditsbutton.y = 720;
		play.y = 720;
		language.y = 720;
		title.y = -45;
		version.y = -45;	
		if (!alreadylaunched)
		{
			add(phone);
			add(phone2);
			add(phone3);
			add(phone4);
			add(phone5);
			add(phone6);
		}
		add(funny);
		add(creditsbutton);
		add(title);
		add(play);
		add(language);
		add(version);
		funny.visible = false;
		// time - 3.6
		if (!alreadylaunched)
		{
			new FlxTimer().start(8, funnetween
			/*{
				funny.setGraphicSize(Std.int(funny.width / 1.5), Std.int(funny.height / 1.5));
				funny.x = -320;
				funny.y = -180;
				funny.antialiasing = true;
				remove(title);
				title.text = "Bambi's Corn Adventure";
				title.screenCenter();
				title.y = 95;
				add(title);
				creditsbutton.y = 295;
				FlxG.mouse.visible = true;
				canpressenter = true;
				funny.visible = true;
			}*/);
			new FlxTimer().start(1.5, function(amog:FlxTimer)
			{
				FlxTween.tween(phone, {x: phone.x, y: 290}, 0.65, {
					ease: FlxEase.cubeOut,
					onComplete: function(among:FlxTween)
					{
						new FlxTimer().start(1.25, function(amog:FlxTimer)
						{
							FlxTween.tween(phone, {x: phone.x, y: -40}, 0.35, {ease: FlxEase.cubeIn, onComplete: function(imlonely:FlxTween)
							{
								FlxTween.tween(phone2, {x: phone2.x, y: 290}, 0.65, {ease:FlxEase.cubeOut, onComplete: function(byebye:FlxTween)
								{
									FlxTween.tween(phone3, {x: phone3.x, y: 320}, 0.45, {ease: FlxEase.cubeOut});
									FlxTween.tween(phone4, {x: phone4.x, y: 350}, 0.45, {ease: FlxEase.cubeOut});
									FlxTween.tween(phone5, {x: phone5.x, y: 380}, 0.45, {ease: FlxEase.cubeOut});
									FlxTween.tween(phone6, {x: phone6.x, y: 410}, 0.45, {ease: FlxEase.cubeOut});
									new FlxTimer().start(1.5, function(amog:FlxTimer)
									{
										FlxTween.tween(phone2, {x: phone2.x, y: -190}, 0.35, {ease:FlxEase.cubeIn});
										FlxTween.tween(phone3, {x: phone3.x, y: -160}, 0.35, {ease: FlxEase.cubeIn});
										FlxTween.tween(phone4, {x: phone4.x, y: -130}, 0.35, {ease: FlxEase.cubeIn});
										FlxTween.tween(phone5, {x: phone5.x, y: -100}, 0.35, {ease: FlxEase.cubeIn});
										FlxTween.tween(phone6, {x: phone6.x, y: -70}, 0.35, {ease: FlxEase.cubeIn});
									});
								}});
							}});
						});
					}
				});
			});
		}
		else
		{
			new FlxTimer().start(0.2, function(e:FlxTimer)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic("assets/music/mainmenu2.ogg");
				funny.setGraphicSize(Std.int(funny.width / 1.5), Std.int(funny.height / 1.5));
				funny.x = -320;
				funny.y = -180;
				funny.antialiasing = true;
				remove(title);
				title.text = "Bambi's Corn Adventure";
				title.screenCenter();
				title.y = 95;
				add(title);
				version.y = 50;
				play.y = 260;
				creditsbutton.y = 295;
				language.y = 330;
				FlxG.mouse.visible = true;
				canpressenter = true;
				funny.visible = true;
				switch (thing){
					case 0:
						FlxTween.tween(FlxG.camera, {x: FlxG.camera.x, y: FlxG.camera.y - 795}, 0.4, {ease: FlxEase.cubeOut});
					case 1:
						FlxTween.tween(FlxG.camera, {x: FlxG.camera.x, y: FlxG.camera.y + 795}, 0.4, {ease: FlxEase.cubeOut});
				}
			});
		}
		Tutorial.musicplayin = false;
		super.create();
	}

	function funnetween(amoguss:FlxTimer)
	{
		if (!alreadylaunched)
			FlxG.sound.playMusic("assets/music/mainmenu2.ogg");
		funny.setGraphicSize(Std.int(funny.width / 1.5), Std.int(funny.height / 1.5));
		funny.x = -320;
		funny.y = -180;
		funny.antialiasing = true;
		remove(title);
		title.text = "Bambi's Corn Adventure";
		title.screenCenter();
		title.y = 95;
		add(title);
		version.y = 50;
		play.y = 260;
		creditsbutton.y = 295;
		language.y = 330;
		FlxG.mouse.visible = true;
		canpressenter = true;
		funny.visible = true;
		FlxG.camera.y += 795;
		FlxTween.tween(FlxG.camera, {x: FlxG.camera.x, y: FlxG.camera.y - 795}, 0.4, {ease: FlxEase.cubeOut});
	}
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.mouse.justPressed && !alreadylaunched)
		{
			if (FlxG.mouse.overlaps(phone4))
			{
				FlxG.sound.play("assets/sounds/click.ogg");
				FlxG.openURL("https://www.youtube.com/channel/UCArzZv4cpIdDMDEWV-HIHUQ");
			}
			if (FlxG.mouse.overlaps(phone5))
			{
				FlxG.sound.play("assets/sounds/click.ogg");
				FlxG.openURL("https://www.youtube.com/channel/UCjaxnR-uElEMEF1vadnpyyQ");
			}
		}
	}

	public function statetransition(state:FlxState, ?iscoolerstate:Bool = false)
	{
		alreadylaunched = true;
		alreadypressed = true;
		if (iscoolerstate)
		{
			FlxG.sound.music.stop();
			FlxG.sound.play("assets/sounds/start.ogg", 1);
			FlxG.camera.flash(FlxColor.WHITE, 1.2);
			new FlxTimer().start(1, function(coolerthing:FlxTimer){
				FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 1420}, 1.2, {ease: FlxEase.cubeIn, onComplete: function(epic:FlxTween){
					new FlxTimer().start(1, function(getback:FlxTimer)
					{
						FlxG.switchState(state);
					});				
				}});
			});
		}
		else
		{
			FlxTween.tween(FlxG.camera, {y: FlxG.camera.y + 720}, 0.5, {ease: FlxEase.cubeIn});
			new FlxTimer().start(1, function(getback:FlxTimer)
			{
				FlxG.switchState(state);
			});
		}
	}
}