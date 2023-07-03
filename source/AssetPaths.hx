package;

import flixel.graphics.frames.FlxAtlasFrames;

class AssetPaths {
    inline static public function getSparrowAtlas(image:String)
    {
        return FlxAtlasFrames.fromSparrow('assets/images/$image.png', 'assets/images/$image.xml');
    }
}