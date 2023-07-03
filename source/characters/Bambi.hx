package characters;

import flixel.system.FlxSound;
import maps.Funniest;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;

class Bambi extends FlxSprite // the funny
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
    public var hascorn:Bool = false;
    public var knockedback:Bool = false;
    public var previousy:Float = 0;
    var snipermain:FlxSound;
    var sniperlayer:FlxSound;
    public var attr:String = "";
    public function new()
    {
        super();
        hascorn = Inventory.corn;
        frames = AssetPaths.getSparrowAtlas("bambi again");
		animation.addByPrefix("idle", "idle", 24, true);
		animation.addByPrefix("walk", "walking", 14, true);
        animation.addByIndices("jump", "jump", [0], "", 14, true);
        animation.addByPrefix("jumpdown", "jumpdown", 14, true);
        animation.addByPrefix("cornidle", "cornidle", 24, true);
        animation.addByPrefix("about to", "about to", 14, false);
        animation.addByIndices("the funny", "the funny", [1, 0], "", 14, true);
        animation.addByPrefix("done", "done", 14, false);
        animation.addByPrefix("cornwalk", "cornwalking", 14, true);
        animation.addByIndices("cornjump", "cornjump", [0], "", 14, true);
        animation.addByPrefix("cornjumpdown", "cornjumpdown", 14, true);
		animation.play("idle", false);
		setGraphicSize(Std.int(width / 2));
        antialiasing = true;
        ybottom = new FlxObject(0, 0);
        ybottom.y = y;
        snipermain = FlxG.sound.load("assets/sounds/sniper/main.ogg");
        sniperlayer = FlxG.sound.load("assets/sounds/sniper/layer.ogg");
        previousy = y;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (hascorn)
            attr = "corn";
        else
            attr = "";
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
                FlxG.sound.play("assets/sounds/walk.ogg", 0.5);
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
                trace("so true 1");
            }
            if (!FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.A && !FlxG.keys.pressed.D)
            {
                if (!jumping)
                    animation.play(attr + "idle", true);
                presses = false;
                trace("so true 2");
            }
            if ((FlxG.keys.pressed.LEFT && FlxG.keys.pressed.RIGHT) || (FlxG.keys.pressed.A && FlxG.keys.pressed.D) || (FlxG.keys.pressed.LEFT && FlxG.keys.pressed.D) || (FlxG.keys.pressed.A && FlxG.keys.pressed.RIGHT)) // extra measure
            {
                if (!jumping)
                    animation.play(attr + "idle", true);
                presses = false;
                trace("so true 3");
            }
            if (FlxG.keys.justPressed.X && !jumping && hascorn && animation.curAnim.name != "cornwalk")
            {
                FlxG.keys.enabled = false;
                eatcorn();
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
        if (animation.curAnim.name == "about to" && animation.curAnim.finished)
        {
            animation.play("the funny", true);
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
    public function noclip()
    {
        jumping = true;
        jumpingdown = true;
        forcedown = true;
        hascorn = false;
        Inventory.corn = false;
        animation.play(attr + "jumpdown", true);
        FlxTween.tween(this, {y: ybottom.y + 5750 * 2}, 2, {ease: FlxEase.cubeIn});
        FlxG.sound.play("assets/sounds/what the what.ogg");
        new FlxTimer().start(0.51720, function(uhh:FlxTimer){
            if (!Funniest.insidefarm)
            {
                FlxTween.cancelTweensOf(this);
                forcedown = false;
                jumping = false;
                jumpingdown = false;
                stopmovements = false;
                y = previousy;
                FlxG.sound.music.volume = 1;
                FlxG.keys.enabled = true;
                FlxG.sound.music.play();
            }
        });
    }
    public function getdown()
    {
        jumping = true;
        jumpingdown = true;
        animation.play(attr + "jumpdown", true);
        FlxTween.tween(this, {y: ybottom.y + 5750}, 2.55, {ease: FlxEase.cubeIn});
    }
    public function knockback()
    {
        FlxTween.cancelTweensOf(this);
        jumping = true;
        jumpingdown = true;
        snipermain.play(true);
        sniperlayer.play(true);
        animation.play(attr + "jumpdown", true);
        knockedback = true;
        FlxTween.tween(this, {y: y - 290}, 0.75, {ease: FlxEase.cubeOut, onComplete:function(again:FlxTween){
            new FlxTimer().start(0.225, function(awhat:FlxTimer){animation.play(attr + "jumpdown", true);jumpingdown = true;});
            knockedback = false;
            FlxTween.tween(this, {y: ybottom.y + 5750}, 2.55, {ease: FlxEase.cubeIn, onComplete:function(y:FlxTween){
                jumping = false;
                jumpingdown = false;
                animation.play(attr + "idle", true);
            }});
        }});
        if (flipX)
            FlxTween.tween(this, {x: x + 1690}, 1.25, {ease: FlxEase.cubeOut});
        else
            FlxTween.tween(this, {x: x - 1690}, 1.25, {ease: FlxEase.cubeOut});
    }
    public function knockbackaftermath(way:String)
    {
        jumping = true;
        jumpingdown = true;
        animation.play(attr + "jumpdown", true);
        if (way == "right") { // this looks so basic i stg
            FlxTween.tween(this, {x: x - 840}, 1, {ease: FlxEase.cubeOut});
            flipX = false;
        }
        if (way == "left") {
            FlxTween.tween(this, {x: x + 840}, 1, {ease: FlxEase.cubeOut});
            flipX = true;        
        }
        y = this.y - 60;
        new FlxTimer().start(0.5, function(getdownTHERESASNIPERONTHEohnevermind:FlxTimer){
        FlxTween.tween(this, {y: ybottom.y + 5750}, 2.55, {ease: FlxEase.cubeIn});           
        });
    }
    public function eatcorn()
    {
        stopmovements = true;
        animation.play("about to", true);
        previousy = y;
        new FlxTimer().start(1.5, function(done1:FlxTimer){
			animation.play("done", true);
            hascorn = false;
            Inventory.corn = false;
			new FlxTimer().start(0.5, function(done:FlxTimer){
                FlxG.sound.music.fadeOut(0.75, 0, function(whatu:FlxTween){
                    new FlxTimer().start(1.75, function(done2:FlxTimer){
                        if (!Funniest.insidefarm)
                            noclip();
                    });
                });
            });
        });
    }
}