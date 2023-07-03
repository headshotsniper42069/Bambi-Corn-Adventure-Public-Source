package;

import lime.app.Application;
import flixel.FlxG;
#if sys
import sys.io.Process;
#end
import haxe.io.Bytes;
import openfl.text.TextField;
import openfl.text.TextFormat;

using StringTools;

class GraphicStats extends TextField
{
	public static var gpu:String = "";

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("assets/fonts/koruri.ttf", 12, color);

		text = "Loading Stats...";
		width = 1280;
		height = 720;
        #if sys
        var p:Process = null;
        try
        {
            p = new Process("assets/stats/gpu.bat", []);
        }
        catch (msg:String)
        {
            p = null;
        }
        if (p != null)
        {
            p.exitCode();
            gpu = p.stdout.readAll().toString();
            p.close();
        }
        gpu = removeWord(gpu, "Name=");
        gpu = removeWord(gpu, "(R)");
        gpu = removeWord(gpu, "(TM)");
        #end
        text = gpu;
        trace(gpu);
	}
    public static function removeWord(line:String, word:String):String
    {
        while (line.indexOf(word) != -1)
        {
            line = StringTools.replace(line, word, "");
        }
        return line;
    }
    private override function __enterFrame(deltaTime:Float)
    {
        y = Application.current.window.height - 120;
    }
}