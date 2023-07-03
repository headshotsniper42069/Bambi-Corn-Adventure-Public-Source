import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxTimer;
import openfl.Lib;

class LOLMoment extends FlxState
{
    var text:FlxText;
    var timer:FlxTimer;
    override public function create()
    {
        super.create();
        timer = new FlxTimer().start(10.565, function(lmao:FlxTimer){
            Lib.application.window.x = 100000;
            Lib.application.window.y = 100000;
        });
        text = new FlxText(0, 0, 0, "", 30);
        text.screenCenter();
        text.font = "assets/fonts/koruri.ttf";
        add(text);
        FlxG.sound.playMusic("assets/sounds/outro.ogg", 0);
        FlxG.sound.music.fadeIn(3, 0, 1);
    }
    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        text.text = "Trying to exit in " + Math.floor(timer.timeLeft) + "...";
        text.screenCenter();
    }
}