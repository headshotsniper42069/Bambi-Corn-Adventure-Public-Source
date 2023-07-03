package characters;

import flixel.FlxSprite;

class BambiHesDead extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;

	public function new()
	{
		super();
        animOffsets = new Map<String, Array<Dynamic>>();
        frames = AssetPaths.getSparrowAtlas('after corn');
        animation.addByPrefix('idle', 'Idle', 18, false);
        animation.addByPrefix('down', 'Down', 27, false);
        animation.addByPrefix('up', 'Up', 27, false);
        animation.addByPrefix('left', 'Left', 27, false);
        animation.addByPrefix('right', 'Right', 27, false);
                    
        addOffset('idle');
        addOffset("up", -24, 15);
        addOffset("right", -34, -6);
        addOffset("left", -3, 6);
        addOffset("down", -20, -10);
    
        antialiasing = true;

		setGraphicSize(Std.int(width / 1.5));
        playanimation("down");
    //    visible = false;
        alpha = 0;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function playanimation(name:String)
	{
		animation.play(name, true);
	
		var offsets = animOffsets.get(name);

        if (animOffsets.exists(name))
			offset.set(offsets[0], offsets[1]);
        else
            offset.set(0, 0);
	}

    public function addOffset(name:String, x:Float = 0, y:Float = 0)
    {
        animOffsets[name] = [x, y];
    }
}