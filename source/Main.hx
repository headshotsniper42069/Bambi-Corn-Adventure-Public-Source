package;

import maps.ThirdBranch;
import maps.SecondBranch;
import maps.Branches;
import maps.LeftAgain;
import maps.Left;
import maps.Funniest;
import maps.MiddleOfNowhere;
import openfl.display.FPS;
import flixel.FlxGame;
import openfl.display.Sprite;
import maps.Tutorial;
import maps.SecondBranch;

class Main extends Sprite
{
	var amongus:Int = 1280; // width
	var inreallife:Int = 720; // height
	var fortnite:Int = 165; // fps
	var thesusussmoggus:Dynamic = BetterSplash; // state
	var no:Bool = true; // skip splash or no
	var secret:Bool = false;
	
	public function new()
	{
		super();
	//	thesusussmoggus = Loader;
	//	thesusussmoggus = Initializer;
		addChild(new FlxGame(amongus, inreallife, thesusussmoggus, 1, fortnite, fortnite, no)); // oh my gee!
	//	addChild(new FPS(10, 3, 0xFFFFFF));
		addChild(new FPSBetterCounter(3, 3, 0xFFFFFF)); // the yes
		addChild(new ProcessorStats(3, 580, 0xFFFFFF)); // processor
		addChild(new GraphicStats(3, 600, 0xFFFFFF)); // graphic
	}
}
