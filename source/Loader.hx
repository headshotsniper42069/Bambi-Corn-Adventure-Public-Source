package;

import sys.io.File;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.ColorTween;
import flixel.addons.util.FlxAsyncLoop;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
#if desktop
import sys.FileSystem;
#end

using StringTools;

class Loader extends FlxState
{
	var loadingassets:FlxGroup;
	var loadedsounds:FlxGroup;
	var loadedassets:FlxGroup;
	var loadedsoundtracks:FlxGroup;
	var loader:FlxAsyncLoop;
	var soundloader:FlxAsyncLoop;
	var soundtrackloader:FlxAsyncLoop;
	var _barText:FlxText;
    var imagearray:Array<String> = [];
	var soundarray:Array<String> = [];
	var musicarray:Array<String> = [];
    var folders:Array<String> = ["backyard", "dialogue", "endings", "forest", "secondforest"];
	var soundfolders:Array<String> = [];
    var current:Int = 0;
	var done:FlxSound;
	#if sys
	var filecheck:sys.FileStat;
	#end
	var string:String = "";

	override public function create():Void
	{
		// Show the mouse (in case it hasn't been disabled)
		FlxG.mouse.visible = true;

		// set up our groups - one will show a progress bar, the other will hold all the things we're loading
		loadingassets = new FlxGroup();
		loadedassets = new FlxGroup();
		loadedsounds = new FlxGroup();
		loadedsoundtracks = new FlxGroup();
		checkfiles();

        for (file in FileSystem.readDirectory(Sys.getCwd() + "assets/images/"))
        {
            if (file.contains(".png"))
            {
                trace(file);
                imagearray.push(file);
                trace(imagearray.length);
            }
        }
        for (folder in folders)
        {
            for (file in FileSystem.readDirectory(Sys.getCwd() + "assets/images/" + folder))
            {
                trace(folder);
                if (file.contains(".png"))
                {
                    trace(folder + "/" + file);
                    imagearray.push(folder + "/" + file);
                    trace(imagearray.length);
                }
            }
        }
		for (sound in FileSystem.readDirectory(Sys.getCwd() + "assets/sounds/"))
		{
			if (sound.contains(".ogg"))
			{
				trace(sound);
				soundarray.push(sound);
				trace(soundarray.length);
			}
		}
		for (soundfolder in soundfolders)
		{
			for (file in FileSystem.readDirectory(Sys.getCwd() + "assets/sounds/" + soundfolder))
			{
				trace(soundfolder);
				if (file.contains(".ogg"))
				{
					trace(soundfolder + "/" + file);
					soundarray.push(soundfolder + "/" + file);
					trace(soundarray.length);
				}
			}
		}
		for (music in FileSystem.readDirectory(Sys.getCwd() + "assets/music/"))
		{
			if (music.contains(".ogg"))
			{
				trace(music);
				musicarray.push(music);
				trace(musicarray.length);
			}
		}
		done = FlxG.sound.load("assets/sounds/loading done.ogg", 0.5);
		add(done);

		// setup our loop
		loader = new FlxAsyncLoop(imagearray.length, addItem, 1);
		soundloader = new FlxAsyncLoop(soundarray.length, addSound, 1);
		soundtrackloader = new FlxAsyncLoop(musicarray.length, addSoundtrack, 1);

		// only our progress bar group should be getting draw() and update() called on it until the loop is done
		loadedassets.visible = false;
		loadedassets.active = false;
		loadedsounds.visible = false;
		loadedsounds.active = false;
		loadedsoundtracks.visible = false;
		loadedsoundtracks.active = false;

		add(loadingassets);
		add(loadedassets);
		add(loadedsounds);
		add(loadedsoundtracks);

		// add our loop, so that it gets updated
		add(loader);
		add(soundloader);
		add(soundtrackloader);

        _barText = new FlxText(0, 0, 0, "Loading...", 20);
        _barText.font = "assets/fonts/koruri.ttf";
        add(_barText);

		super.create();
		for (i in soundarray)
		{
			trace(i);
		}
	}

	public function addItem()
	{
		_barText.text = "Loading image " + (loadedassets.members.length + 1) + " out of " + imagearray.length + "...";
        _barText.screenCenter();
		var sprite = new FlxSprite(-100000, -100000, "assets/images/" + imagearray[current]);
		loadedassets.add(sprite);
		trace(current);
        current++;
		if (Sys.args().contains("-pastedata"))
		{
			if (imagearray[current] != null)
			{
				string += "checkfile('" + imagearray[current] + "', " + sys.FileSystem.stat("assets/images/" + imagearray[current]).size + ');\n';
				trace(string);
				trace(FileSystem.exists(Sys.getCwd() + "assets/data.txt"));
				File.saveContent(Sys.getCwd() + "assets/data.txt", string);
			}
		}
		trace(imagearray[current]);
	}
    
    public function addSound()
    {
		_barText.text = "Loading sound file " + (loadedsounds.members.length + 1) + " out of " + soundarray.length + "...";
        _barText.screenCenter();
        var sound:FlxSound = FlxG.sound.load("assets/sounds/" + soundarray[current - loadedassets.members.length], 0);
        loadedsounds.add(sound);
		trace("assets/sounds/" + soundarray[current - loadedassets.members.length]);
		trace(current);
		sound.play();
		current++;
    }

	public function addSoundtrack()
	{
		_barText.text = "Loading soundtrack " + (loadedsoundtracks.members.length + 1) + " out of " + musicarray.length + "...";
		_barText.screenCenter();
		var music:FlxSound = FlxG.sound.load("assets/music/" + musicarray[current - loadedsounds.members.length - loadedassets.members.length], 0);
		loadedsoundtracks.add(music);
		music.play();
		trace(current - loadedsounds.members.length - loadedassets.members.length);
		current++;
		if (Sys.args().contains("-pastedata"))
		{
			if (musicarray[current] != null)
			{
				string += "checkfile(" + musicarray[current] + ", " + sys.FileSystem.stat("assets/music/" + musicarray[current]).size + '"", "music");\n';
				trace(string);
				trace(FileSystem.exists(Sys.getCwd() + "assets/data.txt"));
				File.saveContent(Sys.getCwd() + "assets/data.txt", string);
			}
		}
	}

	override public function update(elapsed:Float):Void
	{
		trace(current);
		// If my loop hasn't started yet, start it
		if (!loader.started)
		{
			loader.start();
		}
		else
		{
			// if the loop has been started, and is finished, then we swich which groups are active
			if (loader.finished)
			{
			//	loadedassets.visible = true;
			//	loadingassets.visible = false;
			//	loadedassets.active = true;
			//	loadingassets.active = false;
			//	current = 0;
				loader.destroy();
				soundloader.start();
			}
		}
		if (soundloader.finished)
		{
		//	current = 0;
			soundloader.destroy();
			soundtrackloader.start();
		}
		if (soundtrackloader.finished && current == (loadedassets.members.length + loadedsounds.members.length + loadedsoundtracks.members.length))
		{
			done.play();
			soundtrackloader.destroy();
			move();
			current++;
		}
		super.update(elapsed);
	}
	function move()
	{
		_barText.text = "Done!";
		_barText.screenCenter();
		FlxTween.cancelTweensOf(_barText);
		FlxTween.tween(_barText, {y: _barText.y + 25}, 0.75, {ease:FlxEase.cubeOut});
		new FlxTimer().start(1.5, function(move:FlxTimer){
			FlxTween.tween(_barText, {y: _barText.y - 2005}, 0.75, {ease:FlxEase.cubeIn, onComplete: function(bruh:FlxTween){
				FlxG.switchState(new Initializer());
			}});
		});
	}

	public function checkfiles()
	{
		#if sys
		if (!Sys.args().contains("-tadghermyladgherifuckedmyownladder"))
		{
			checkfile('awesomest', 323704);
			checkfile('bambi again', 1392238);
			checkfile('Cooler Dave', 282274);
			checkfile('dave house', 3770420);
			checkfile('farm', 1570667);
			checkfile('farmland', 2358445);
			checkfile('night sky', 9604439);
			checkfile('oh whats that at the left', 222674);
			checkfile('out', 694389);
			checkfile('sky', 956191);
			checkfile('the funny middle of nowhere', 182952);
			checkfile('wait what', 232762);
			checkfile('whats up my hell calling you', 156775);
			checkfile('backyard/1', 390214);
			checkfile('backyard/2', 128189);
			checkfile('backyard/3', 173180);
			checkfile('dialogue/Down', 19514);
			checkfile('dialogue/Left', 19640);
			checkfile('dialogue/me when the funnies', 19398);
			checkfile('dialogue/what0001', 17335);
			checkfile('endings/something idk ending', 26170);
			checkfile('forest/1', 340326);
			checkfile('forest/2', 183212);
			checkfile('forest/3', 393973);
			checkfile('forest/4', 165548);
			checkfile('forest/5', 72735);
			checkfile('secondforest/1', 347140);
			checkfile('secondforest/2', 333978);
			checkfile('secondforest/3', 259040);
			checkfile('secondforest/4', 277115);
			checkfile('secondforest/5', 78490);
			checkfile("corn", 1266269, "Peaceful Encounters", "music");
			if (FlxG.save.data.tutorialdone)
				trace("tutorial: tutorial already done, file check not necessary");
			else
				checkfile("tutorial", 5382353, "Beginnings", "music");
			checkfile("forest", 3392975, "Thing That Plays When You're In The Forest", "music");
			checkfile("forest post", 4164175, "Thing That Plays When You're Right Outside Dave's Backyard", "music");
			checkfile("forest post pre loop", 421585, "Thing That Plays When You're In The Forest", "music");
			checkfile("backyard", 522710, "good ending music", "music");
			checkfile("backyardRARE", 171244, "Dave Dialogue", "music");
			trace("file check passed");
		}
		else
			trace("oh wait he put the code");
		checkfile("holy mami", 396083, "Confused Mami");
		#end
	}
	public function checkfile(image:String = "", size:Float = 0, cheattitle:String = "", type:String = "image")
	{
		#if sys
		switch (type)
		{
			case "image":
				if (!FileSystem.exists("assets/images/" + image + ".png"))
				{
					if (cheattitle == "Confused Mami")
					{
						trace(image + ": missing, but still better than actual salvation mami");
					}
					else
					{
						FlxG.switchState(new CheatersGamers(cheattitle, image + ".png"));
						trace(image + ": well shit");
					}
				}
				else
				{
					filecheck = sys.FileSystem.stat("assets/images/" + image + ".png");
		
					if (filecheck.size != size)
						FlxG.switchState(new CheatersGamers(cheattitle, image + ".png"));
					trace(image.toLowerCase() + ": " + filecheck.size);
				}
			case "music":
				if (!FileSystem.exists("assets/music/" + image + ".ogg"))
				{
					{
						FlxG.switchState(new CheatersGamers(cheattitle, image + ".ogg"));
						trace(image + ": well shit");
					}
				}
				else
				{
					filecheck = sys.FileSystem.stat("assets/music/" + image + ".ogg");
		
					if (filecheck.size != size)
						FlxG.switchState(new CheatersGamers(cheattitle, image + ".ogg"));
					trace(image.toLowerCase() + ": " + filecheck.size);
				}
		}
		#end
	}
}