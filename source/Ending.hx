import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.FlxSubState;

class Ending extends FlxSubState
{
    var image:FlxSprite;
    override public function create()
    {
        super.create();
        image = new FlxSprite(0, 0, "assets/images/endings/something idk ending.png");
        add(image);
        new FlxTimer().start(1.1, function(back:FlxTimer){
            FlxG.sound.play("assets/sounds/baldi.ogg");
            new FlxTimer().start(0.125, function(getback:FlxTimer){close();});
        });
    }
}