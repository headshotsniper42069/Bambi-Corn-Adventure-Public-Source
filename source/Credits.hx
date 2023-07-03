import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxState;

class Credits extends FlxState // the funne subscrbiers
{
	var thefunny:FlxText;
	var thefunny2:FlxText;
	var thefunny3:FlxText;
	var thefunny4:FlxText;
	var thefunny5:FlxText;
	var thefunny6:FlxText;
	var thefunny7:FlxText;
	var thefunny8:FlxText;
	var thefunny9:FlxText;
	var thefunny10:FlxText;
	var thefunny11:FlxText;
	var subscribers:Array<String> = [
	"G-Corp Mania", 
	"Mo is Loud Asf",
	"tadhg",
	"Super Gold Bro",
	"SayakaMiki",
	"CereaInABowl",
	"vicholama0",
	"Thedoorofhell666",
	"Sky's zeta"
	];
	var subsreasons:Array<String> = [
	"the reason why bambi takeover 1.5 and onwards is a thing", 
	"did the tutorial background",
	"The great nation of Ireland im jk",
	"did the main menu music",
	"made a mami tetris chart LOL",
	"attempted Single Handed mobile port",
	"did the spanish translation of the game",
	"tried to translate the game to russian (but the game engine's text doesnt support it)",
	"upgraded from FL studio 9 to FL 20 :trolled:"
	];
	var canescape:Bool = true;
	override public function create()
	{
		if (FlxG.save.data.lang == "spanish")
		{
			subsreasons = [
				"la razón porque bambi takeover 1.5 y más existen",
				"hizo el fondo de el tutorial",
				"Ta gran nacion de irlanda estoy de joda",
				"hizo la musica del menú",
				"hizo un chart de mami tetris Lol",
				"intento hacer un port para celular de Single handed",
				"hizo la traducción en español del juego",
				"intento traducir el juego a ruso (pero el engine de el juego no lo soporta)",
				"mejoro de FL estudio 9 a FL 20 :troleado:",
			];
		}
		MainMenuState.thing = 0;
		FlxG.camera.y -= 720;
		thefunny = new FlxText(0, 0, 0, subscribers[0] + " - " + subsreasons[0], 22);
		thefunny2 = new FlxText(0, 0, 0, subscribers[1] + " - " + subsreasons[1], 22);
		thefunny3 = new FlxText(0, 0, 0, subscribers[2] + " - " + subsreasons[2], 22);
		thefunny4 = new FlxText(0, 0, 0, subscribers[3] + " - " + subsreasons[3], 22);
		thefunny5 = new FlxText(0, 0, 0, subscribers[4] + " - " + subsreasons[4], 22);
		thefunny6 = new FlxText(0, 0, 0, subscribers[5] + " - " + subsreasons[5], 22);
		thefunny7 = new FlxText(0, 0, 0, subscribers[6] + " - " + subsreasons[6], 22);
		thefunny8 = new FlxText(0, 0, 0, subscribers[7] + " - " + subsreasons[7], 22);
		thefunny9 = new FlxText(0, 0, 0, subscribers[8] + " - " + subsreasons[8], 22);
		thefunny.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny2.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny3.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny4.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny5.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny6.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny7.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny8.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny9.setFormat("assets/fonts/koruri.ttf", 22);
		thefunny.screenCenter();
		thefunny2.screenCenter();
		thefunny3.screenCenter();
		thefunny4.screenCenter();
		thefunny5.screenCenter();
		thefunny6.screenCenter();
		thefunny7.screenCenter();
		thefunny8.screenCenter();
		thefunny9.screenCenter();
	/*	thefunny.y -= 180;
		thefunny2.y -= 150;
		thefunny3.y -= 120;
		thefunny4.y -= 90;
		thefunny5.y -= 60;
		thefunny6.y -= 30;
		thefunny8.y += 30;
		thefunny9.y += 60; */
		thefunny.y -= 180;
		thefunny2.y -= 140;
		thefunny3.y -= 100;
		thefunny4.y -= 60;
		thefunny5.y -= 20;
		thefunny6.y += 20;
		thefunny7.y += 60;
		thefunny8.y += 100;
		thefunny9.y += 140;
		add(thefunny);
		add(thefunny2);
		add(thefunny3);
		add(thefunny4);
		add(thefunny5);
		add(thefunny6);
		add(thefunny7);
		add(thefunny8);
		add(thefunny9);
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y + 720}, 0.35, {ease: FlxEase.cubeOut});
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.justPressed)
		{
			if (FlxG.mouse.overlaps(thefunny))
				openthefunny("https://www.youtube.com/channel/UCTD3S9rT7n0a0atlFhcuKDQ");
			if (FlxG.mouse.overlaps(thefunny2))
				openthefunny("https://www.youtube.com/channel/UCjaxnR-uElEMEF1vadnpyyQ");
			if (FlxG.mouse.overlaps(thefunny5))
				openthefunny("https://www.youtube.com/channel/UCx1hklFZWa2bdqWLVMas-7Q");
			if (FlxG.mouse.overlaps(thefunny6))
				openthefunny("https://www.youtube.com/channel/UC7Rgev6Frs0L8bJeT8NtQBg");
			if (FlxG.mouse.overlaps(thefunny7))
				openthefunny("https://www.youtube.com/channel/UCArzZv4cpIdDMDEWV-HIHUQ");
			if (FlxG.mouse.overlaps(thefunny8))
				openthefunny("https://www.youtube.com/channel/UCl36tnI0youCefE0xZ73TWg");
			if (FlxG.mouse.overlaps(thefunny9))
				openthefunny("https://www.youtube.com/channel/UCq4Gkx_ekyg8LH_Y-50D9vw");
		}
		if (FlxG.mouse.overlaps(thefunny))
			thefunny.color = 0xFFE100;
		else
			thefunny.color = 0xFFFFFF;
		if (FlxG.mouse.overlaps(thefunny2))
			thefunny2.color = 0xFFE100;
		else
			thefunny2.color = 0xFFFFFF;
		if (FlxG.mouse.overlaps(thefunny5))
			thefunny5.color = 0xFFE100;
		else
			thefunny5.color = 0xFFFFFF;
		if (FlxG.mouse.overlaps(thefunny6))
			thefunny6.color = 0xFFE100;
		else
			thefunny6.color = 0xFFFFFF;
		if (FlxG.mouse.overlaps(thefunny7))
			thefunny7.color = 0xFFE100;
		else
			thefunny7.color = 0xFFFFFF;
		if (FlxG.mouse.overlaps(thefunny8))
			thefunny8.color = 0xFFE100;
		else
			thefunny8.color = 0xFFFFFF;
		if (FlxG.mouse.overlaps(thefunny9))
			thefunny9.color = 0xFFE100;
		else
			thefunny9.color = 0xFFFFFF;
		if (FlxG.keys.justPressed.ESCAPE && canescape || FlxG.keys.justPressed.ENTER && canescape)
		{
			FlxG.sound.play("assets/sounds/back.ogg");
			statetransition(new MainMenuStateBetter());
			canescape = false;
		}
		super.update(elapsed);
	}
	public function statetransition(state:FlxState)
	{
		new FlxTimer().start(0.6, function(getback:FlxTimer)
		{
			FlxG.switchState(state);
		});
		FlxTween.tween(FlxG.camera, {y: FlxG.camera.y - 720}, 0.375, {ease:FlxEase.cubeIn});
	}
	function openthefunny(theyes:String)
	{
		FlxG.sound.play("assets/sounds/click.ogg");
		FlxG.openURL(theyes);
	}
}