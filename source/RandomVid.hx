import flixel.FlxG;
import flixel.FlxState;
import vlc.MP4Handler;

class RandomVid extends FlxState
{
    var video:MP4Handler;
    var randomvids:Array<String> = ['Last Cutscene Cutoff', 'oh my gee', 'bambi takeover', 'Society', 'BALDI HES DEAD!', 'hey every'];
    override public function create()
    {
        playCutscene(randomvids[FlxG.random.int(0, 5)]);
    }

    function playCutscene(name:String)
    {
    	video = new MP4Handler();
    	video.finishCallback = function()
    	{
            if (FlxG.save.data.lang == null)
    		    FlxG.switchState(new Language());
            else
                FlxG.switchState(new Loader());
    	}
    	video.playVideo('assets/videos/$name.mp4');
    }
}