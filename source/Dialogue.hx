package;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;

class Dialogue extends FlxState
{
    var dialoguestest:Array<String> = ['Are you cording?', 'My game?', 'Marcello full gamings demo?', '...', 'The'];
    var dialogues1:Array<String> = ['Down', 'Down', 'Left', 'me when the funnies', 'what0001'];
    var sprite:FlxSprite;
    var text:FlxText;
    public function new(dialogues:Array<String> = ['you forgot text'], dialogueorder:Array<String> = ['bambi3'])
    {
        super();
        dialoguestest = dialogues;
        dialogues1 = dialogueorder;
    }
    override public function create()
    {
        super.create();
        sprite = new FlxSprite();
        sprite.screenCenter();
        add(sprite);
    }
    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
    function popup(text:String, character:String)
    {
        sprite.loadGraphic(character);
        sprite.screenCenter;
        sprite.y -= 30;
        FlxTween.tween(sprite, {y: sprite.y + 30}, 0.25, {ease:FlxEase.cubeOut});
    }
}