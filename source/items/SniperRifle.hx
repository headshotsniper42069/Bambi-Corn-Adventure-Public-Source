package items;

import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

class SniperRifle extends FlxSprite
{
    public var shot:Bool = false;
    public function new()
    {
        super();
        frames = AssetPaths.getSparrowAtlas("sniper rifle");
        animation.addByPrefix("shoot", "sniper", 26, false);
        animation.addByIndices("idle", "sniper", [7], "", 26, false);
        animation.play("idle");
        setGraphicSize(889, 500);
        updateHitbox();
        setGraphicSize(Std.int(this.width / 1.75));
        updateHitbox();
        antialiasing = true;
    }
    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
    public function shoot()
    {
        animation.play("shoot");
        shot = true;
        FlxTween.tween(this, {y: y - 1090}, 1.75, {ease: FlxEase.cubeOut});
        if (flipX)
            FlxTween.tween(this, {x: x + 10690}, 4.25, {ease: FlxEase.cubeOut});
        else
            FlxTween.tween(this, {x: x - 10690}, 4.25, {ease: FlxEase.cubeOut});
        FlxTween.angle(this, this.angle, 840, 1.5, {ease: FlxEase.cubeOut});
    }
}