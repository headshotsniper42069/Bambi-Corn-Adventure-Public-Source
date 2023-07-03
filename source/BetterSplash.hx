package;
#if windows
import Discord.DiscordClient;
#end
import lime.app.Application;
import flixel.system.FlxAssets;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.Lib;
import openfl.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flixel.FlxG;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class BetterSplash extends FlxState
{
	public static var nextState:Class<FlxState>;

	/**
	 * @since 4.8.0
	 */
	public static var muted:Bool = #if html5 true #else false #end;

	var _sprite:Sprite;
	var _gfx:Graphics;
	var _text:TextField;

	var _times:Array<Float>;
	var _colors:Array<Int>;
	var _functions:Array<Void->Void>;
	var _curPart:Int = 0;
	var _cachedBgColor:FlxColor;
	var _cachedAutoPause:Bool;
	var titles:Array<String> = [
		"Stop Bullying Dave- OH HES DEAD! BALDI HES DEAD!",
		"you fu- I KNEW IT! MOLDY YOU TROLLED I KNEW IT!",
		"Bambi's Among Us Adventure",
		"Dave's Adventure",
		"Cool video I'd be happy if you give me a subwoofer",
		"this isnt supposed to be a platformer or a puzzle game jesus fucking christ its not a generic mobile game holy fucking shit",
		"Stop Stop Bullying Dave OH HE HES DEAD DEA DEA D D E E D D E E A A E E A A E E BALDI HES DEAD D D D D D D D D D D E E D D E E Stop Stop Bullying Dave OH",
		"The Great Nation Of Ireland",
		"there is literally just single frames can someone please remaster bambi"
	];
	var alreadyseencoolanimation:Bool = false;

	override public function create():Void
	{
		#if windows
		DiscordClient.initialize();
		#end
		if (FlxG.save.data.lang == "spanish")
		{
			titles = [
			"Para de hacerle bullying a Dave- OH EL ESTA MUERTO! BALDI EL ESTA MUERTO",
			"you jodi- LO SABIA! MOLDY TU TROLEASTE LO SABIA",
			"La aventura Among Us de bambi",
			"La aventura de dave",
			"gran video estaría feliz si me dieras una suscripción",
			"esto no se supone que es un plataformero o un juego puzzle santa mierda no es un juego generico de celulares santa jodida mierda",
			"Para para de hacerle Bullying a Dave OH EL ESTA MUERTO MUER MUER MU MU ER ER TT OO BALDI EL ESTA MUERTO MU MU MU MU MU MU MU MU MU MU TO TO MU MU Para para de hacerle bullying a Dave OH",
			"The gran nacion de irlanda"
			];
		}
		persistentUpdate = false;
		persistentDraw = false;
	//	openSubState(new FunneSound());
		if (FlxG.save.data.framerate == null)
		{
			FlxG.drawFramerate = Application.current.window.displayMode.refreshRate;
			FlxG.updateFramerate = Application.current.window.displayMode.refreshRate;
			FlxG.save.data.framerate = 15;
		}
		else
		{
			if (FlxG.save.data.framerate == 15)
			{
				FlxG.drawFramerate = Application.current.window.displayMode.refreshRate;
				FlxG.updateFramerate = Application.current.window.displayMode.refreshRate;
			}
			else
			{
				FlxG.drawFramerate = FlxG.save.data.framerate;
				FlxG.updateFramerate = FlxG.save.data.framerate;
			}
		}
		if (FlxG.save.data.achievements == null)
			FlxG.save.data.achievements = new Array<String>();
		if (FlxG.save.data.lang == "spanish")
			Lib.application.window.title = titles[FlxG.random.int(0, 7)];
		else
			Lib.application.window.title = titles[FlxG.random.int(0, 8)];
		_cachedBgColor = FlxG.cameras.bgColor;
		FlxG.cameras.bgColor = FlxColor.BLACK;
		FlxG.mouse.visible = false;
		
		FlxG.fixedTimestep = false; // best thing this syncs the main menu music finally

		_times = [0.041, 0.184, 0.334, 0.495, 0.636];
		_colors = [0x00b922, 0xffc132, 0xf5274e, 0x3641ff, 0x04cdfb];
		_functions = [drawGreen, drawYellow, drawRed, drawBlue, drawLightBlue];

		for (time in _times)
		{
			new FlxTimer().start(time, timerCallback);
		}

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		_sprite = new Sprite();
		FlxG.stage.addChild(_sprite);
		_gfx = _sprite.graphics;

		_text = new TextField();
		_text.selectable = false;
		_text.embedFonts = true;
		var dtf = new TextFormat(FlxAssets.FONT_DEFAULT, 16, 0xffffff);
		dtf.align = TextFormatAlign.CENTER;
		_text.defaultTextFormat = dtf;
		_text.text = "HaxeFlixel 4.9";
		FlxG.stage.addChild(_text);

		onResize(stageWidth, stageHeight);

		#if FLX_SOUND_SYSTEM
		if (!muted)
		{
			FlxG.sound.load(FlxAssets.getSound("flixel/sounds/flixel")).play();
		}
		#end
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.P)
		{
			FlxG.save.data.lang = null;
		}
		if (FlxG.keys.justPressed.R)
		{
			FlxG.save.data.achievements = null;
			FlxG.save.data.achievements = new Array<String>();
		}
	}

	override public function destroy():Void
	{
		_sprite = null;
		_gfx = null;
		_text = null;
		_times = null;
		_colors = null;
		_functions = null;
		super.destroy();
	}

	override public function onResize(Width:Int, Height:Int):Void
	{
		super.onResize(Width, Height);

		_sprite.x = (Width / 2);
		_sprite.y = (Height / 2) - 20 * FlxG.game.scaleY;

		_text.width = Width / FlxG.game.scaleX;
		_text.x = 0;
		_text.y = _sprite.y + 80 * FlxG.game.scaleY;

		_sprite.scaleX = _text.scaleX = FlxG.game.scaleX;
		_sprite.scaleY = _text.scaleY = FlxG.game.scaleY;
		
		if (!alreadyseencoolanimation)
		{
			_sprite.y += 720;
			_text.y += 720;

        	FlxTween.tween(_sprite, {y: 340}, 0.495, {ease: FlxEase.cubeOut}); 
			FlxTween.tween(_text, {y: 420}, 0.495, {ease: FlxEase.cubeOut, onComplete: function(the:FlxTween)
        	{
				alreadyseencoolanimation = true;
        	    new FlxTimer().start(1.85, function(thepart2:FlxTimer)
        	    {
					FlxTween.tween(_sprite, {y: -1240}, 0.895, {ease: FlxEase.cubeIn});
					FlxTween.tween(_text, {y: -1160}, 0.895, {ease: FlxEase.cubeIn, onComplete: function(hidethething:FlxTween){
						_sprite.visible = false;
						_text.visible = false;
					}});
        	    });
        	}});
		}
	}

	function timerCallback(Timer:FlxTimer):Void
	{
		_functions[_curPart]();
		_text.textColor = _colors[_curPart];
		_text.text = "HaxeFlixel 4.9";
		_curPart++;

		if (_curPart == 5)
		{
			// Make the logo a tad bit longer, so our users fully appreciate our hard work :D
			FlxTween.tween(_sprite, {alpha: 1}, 3.0, {ease: FlxEase.quadOut, onComplete: onComplete});
			FlxTween.tween(_text, {alpha: 1}, 3.0, {ease: FlxEase.quadOut});
		}
	}

	function drawGreen():Void
	{
		_gfx.beginFill(0x00b922);
		_gfx.moveTo(0, -37);
		_gfx.lineTo(1, -37);
		_gfx.lineTo(37, 0);
		_gfx.lineTo(37, 1);
		_gfx.lineTo(1, 37);
		_gfx.lineTo(0, 37);
		_gfx.lineTo(-37, 1);
		_gfx.lineTo(-37, 0);
		_gfx.lineTo(0, -37);
		_gfx.endFill();
	}

	function drawYellow():Void
	{
		_gfx.beginFill(0xffc132);
		_gfx.moveTo(-50, -50);
		_gfx.lineTo(-25, -50);
		_gfx.lineTo(0, -37);
		_gfx.lineTo(-37, 0);
		_gfx.lineTo(-50, -25);
		_gfx.lineTo(-50, -50);
		_gfx.endFill();
	}

	function drawRed():Void
	{
		_gfx.beginFill(0xf5274e);
		_gfx.moveTo(50, -50);
		_gfx.lineTo(25, -50);
		_gfx.lineTo(1, -37);
		_gfx.lineTo(37, 0);
		_gfx.lineTo(50, -25);
		_gfx.lineTo(50, -50);
		_gfx.endFill();
	}

	function drawBlue():Void
	{
		_gfx.beginFill(0x3641ff);
		_gfx.moveTo(-50, 50);
		_gfx.lineTo(-25, 50);
		_gfx.lineTo(0, 37);
		_gfx.lineTo(-37, 1);
		_gfx.lineTo(-50, 25);
		_gfx.lineTo(-50, 50);
		_gfx.endFill();
	}

	function drawLightBlue():Void
	{
		_gfx.beginFill(0x04cdfb);
		_gfx.moveTo(50, 50);
		_gfx.lineTo(25, 50);
		_gfx.lineTo(1, 37);
		_gfx.lineTo(37, 1);
		_gfx.lineTo(50, 25);
		_gfx.lineTo(50, 50);
		_gfx.endFill();
	}

	function onComplete(Tween:FlxTween):Void
	{
		FlxG.cameras.bgColor = _cachedBgColor;
	//	FlxG.fixedTimestep = _cachedTimestep;
	//	FlxG.autoPause = _cachedAutoPause;
	//	#if FLX_KEYBOARD
	//	FlxG.keys.enabled = true;
	//	#end
		if (FlxG.save.data.lang == null)
			FlxG.switchState(new Language());
		else
			FlxG.switchState(new Loader());
		#if (neko || web)
		#else
		FlxG.switchState(new RandomVid());
		#end
	}
}