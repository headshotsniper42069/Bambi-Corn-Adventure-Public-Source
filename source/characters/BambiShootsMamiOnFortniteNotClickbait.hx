package characters;

import flixel.system.FlxSound;
import maps.Funniest;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;

class BambiShootsMamiOnFortniteNotClickbait extends FlxSprite // the funny
{
    public var xoffse:Float;
    public var xoffse2:Float;
    var fuck:Float;
    public var stopmovements:Bool = false;
    public var forcemovement:Bool = false;
    public var forcemovement2:Bool = false;
    public var ybottom:FlxObject;
    public var jumping:Bool = false;
    public var jumpingdown:Bool = false;
    public var forcedown:Bool = false;
    public var presses:Bool = false;
    var attr:String = "";
    public function new()
    {
        super();
        frames = AssetPaths.getSparrowAtlas("you can now kill mami in bambi's corn adventure!!! finally");
		animation.addByPrefix("idle", "idle", 24, true);
		animation.addByPrefix("walk", "walking", 14, true);
        animation.addByIndices("jump", "jump", [0], "", 14, true);
        animation.addByPrefix("jumpdown", "jumpdown", 14, true);
		animation.play("idle", false);
		setGraphicSize(Std.int(width / 2));
        antialiasing = true;
        ybottom = new FlxObject(0, 0);
        ybottom.y = y;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (jumping && !jumpingdown)
        {
            animation.play(attr + "jump", true); // forcing
        }
        if (!stopmovements)
        {
            if (animation.curAnim.name == attr + "walk")
                fuck += elapsed;
            if (animation.curAnim.name == attr + "walk" && fuck >= (0.0714285714285714 * 2))
            {
                fuck = 0;
            }
            if ((FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A) && !PlayState.destroyed && animation.curAnim.name != attr + "walk" && !jumping)
            {
                animation.play(attr + "walk", true);
                flipX = true;
            }
            if ((FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D) && !PlayState.destroyed && animation.curAnim.name != attr + "walk" && !jumping)
            {
                animation.play(attr + "walk", true);
                flipX = false;
            }
            if ((FlxG.keys.pressed.LEFT|| FlxG.keys.pressed.A) && !PlayState.destroyed && x >= xoffse)
            {
                x -= 2 / FlxG.updateFramerate * 75 * 4;
                if (animation.curAnim.name != attr + "walk" && !jumping)
                    animation.play(attr + "walk", true);
                presses = true;
                flipX = true;
            }
            if ((FlxG.keys.pressed.RIGHT|| FlxG.keys.pressed.D) && !PlayState.destroyed && x <= xoffse2 || forcemovement)
            {
                x += 2 / FlxG.updateFramerate * 75 * 4;
                if (animation.curAnim.name != attr + "walk" && !jumping)
                    animation.play(attr + "walk", true);
                presses = true;
                flipX = false;
            }
            if ((FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.RIGHT || FlxG.keys.justReleased.A || FlxG.keys.justReleased.D) && !(FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.A || FlxG.keys.pressed.D))
            {
                if (!jumping)
                    animation.play(attr + "idle", true);
                presses = false;
            }
            if (!FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.A && !FlxG.keys.pressed.D)
            {
                if (!jumping)
                    animation.play(attr + "idle", true);
                presses = false;
            }
            if ((FlxG.keys.pressed.LEFT && FlxG.keys.pressed.RIGHT) || (FlxG.keys.pressed.A && FlxG.keys.pressed.D) || (FlxG.keys.pressed.LEFT && FlxG.keys.pressed.D) || (FlxG.keys.pressed.A && FlxG.keys.pressed.RIGHT)) // extra measure
            {
                if (!jumping)
                    animation.play(attr + "idle", true);
                presses = false;
            }
            if (FlxG.keys.anyJustPressed([LEFT, RIGHT, A, D]))
            {
                fuck = 0.8;
            }
            if (FlxG.keys.anyJustPressed([UP, W, SPACE]) && !jumping)
            {
                jump();
            }
        }
        if (forcemovement)
        {
            x += 2 / FlxG.updateFramerate * 75 * 4;
            if (animation.curAnim.name != attr + "walk")
                animation.play(attr + "walk", true);
            presses = true;
            flipX = false;
        }
        if (forcemovement2)
        {
            x -= 2 / FlxG.updateFramerate * 75 * 4;
            if (animation.curAnim.name != attr + "walk")
                animation.play(attr + "walk", true);
            presses = true;
            flipX = true;
        }
        if (jumpingdown && y >= ybottom.y && !forcedown)
        {
            FlxTween.cancelTweensOf(this);
            jumping = false;
            jumpingdown = false;
            animation.play(attr + "idle", true);
            y = ybottom.y;
        }
    }

    public function setOffsets(xt:Float, xt2:Float) // map offsets not anims
    {
        xoffse = xt;
        xoffse2 = xt2;
    }
    public function jump()
    {
        jumping = true;
        animation.play(attr + "jump", true);
        FlxTween.tween(this, {y: y - 290}, 0.55, {ease: FlxEase.cubeOut, onComplete:function(again:FlxTween){
            new FlxTimer().start(0.225, function(awhat:FlxTimer){animation.play(attr + "jumpdown", true);jumpingdown = true;});
            FlxTween.tween(this, {y: ybottom.y + 5750}, 2.55, {ease: FlxEase.cubeIn, onComplete:function(y:FlxTween){
                jumping = false;
                jumpingdown = false;
                animation.play(attr + "idle", true);
            }});
        }});
    }
}