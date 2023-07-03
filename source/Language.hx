import lime.app.Application;
import openfl.Lib;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxState;

using StringTools;


class Language extends FlxState
{
    var textors:FlxText;
    var engles:FlxButton;
    var spanishe:FlxButton;
    override public function create()
    {
        FlxG.mouse.visible = true;
        textors = new FlxText(0, 0, 0, "Which language do you want to play on?\n", 22);
        textors.text += "En que idioma quieres jugar?\n";
        textors.setFormat("assets/fonts/koruri.ttf", 22);
        textors.screenCenter();
        textors.y = -100;
        engles = new FlxButton(0, 0, "English / Ingles", function(){
            tr();
        });
        spanishe = new FlxButton(0, 0, "Spanish / Español", function(){
           tr(true);
        });
        engles.screenCenter();
        spanishe.screenCenter();
        spanishe.label.size = 6;
        engles.y += 25;
        spanishe.y += 25;
        engles.x -= 1360;
        spanishe.x += 1360;
        add(engles);
        add(spanishe);
        add(textors);
        FlxTween.tween(textors, {y: textors.y + 250}, 0.325, {ease: FlxEase.cubeOut});
        FlxTween.tween(engles, {x: engles.x + 1300}, 0.525, {ease: FlxEase.cubeOut});
        FlxTween.tween(spanishe, {x: spanishe.x - 1300}, 0.525, {ease: FlxEase.cubeOut});
        Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + Application.current.window.displayMode.refreshRate + " FPS";
    }
    function tr(?espanis:Bool = false, ?russian:Bool = false)
    {
        if (espanis && !MainMenuState.alreadylaunched)
            FlxG.sound.play("assets/sounds/spanes.ogg");
        FlxG.sound.play("assets/sounds/click.ogg");
        FlxTween.tween(FlxG.camera, {y: FlxG.camera.y + 750}, 0.625, {ease: FlxEase.cubeIn});
        if (espanis && !MainMenuState.alreadylaunched)
            new FlxTimer().start(2.25, function(thetsdfnkjbsdjfhkgsfd:FlxTimer){
                FlxG.save.data.lang = "spanish";
                FlxG.switchState(new Initializer());
            });
        else if (espanis)
            new FlxTimer().start(0.85, function(thetsdfnkjbsdjfhkgsfds:FlxTimer){
                FlxG.save.data.lang = "spanish";
                if (!MainMenuState.alreadylaunched)
                    FlxG.switchState(new Initializer());
                else
                    FlxG.switchState(new MainMenuState());
            });
        else
            new FlxTimer().start(0.85, function(thetsdfnkjbsdjfhkgsfds:FlxTimer){
                FlxG.save.data.lang = "english";
                if (!MainMenuState.alreadylaunched)
                    FlxG.switchState(new Initializer());
                else
                    FlxG.switchState(new MainMenuState());
            });
        FlxG.mouse.visible = false;
    }
}