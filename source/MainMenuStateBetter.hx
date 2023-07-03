import Discord.DiscordClient;
import openfl.Lib;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

using StringTools;

class MainMenuStateBetter extends FlxState
{
    var presentstext:FlxText;
    var titletext:FlxText;
    var version:FlxText;
    var buttons:Array<String> = ["Start", "Credits", "Options", "Achievements"];
    var achievement:FlxSprite;
    var mainmenumusic:FlxSound;
    var smallcreditsgroup:FlxTypedGroup<FlxText>;
    var creditsbuttongroup:FlxTypedGroup<FlxText>;
    var buttonsgroup:FlxTypedGroup<FlxSprite>;
    var alreadyplayedthing:Bool = false;
    var background:FlxSprite;
    var randimage:FlxSprite;
    var randimage2:FlxSprite;
    var finishedappearing:Bool = false;
    var creditsfinishedappearing:Bool = false;
    var language:FlxText;
    var epicness:FlxText;
    var frames:FlxText;
    var select:FlxSprite;
    var optiontext:FlxText;
    var start:FlxText;
    var credits:FlxText;
    var options:FlxText;
    var achievementsbutton:FlxText;
    var hoverover:FlxText;
    var optionstext:FlxText;
    var achievementext:FlxText;
    var achievementdescription:FlxText;
    var shifting:Bool = false;
    var current:Int = 0;
    var inoptions:Bool = false;
    var inachievements:Bool = false;
    static var alreadyentered:Bool = false;
    var startposition:Float = 0;
    static var loopingmusic:Bool = false;
    var epicnessarray:Array<Float> = [0, 10, 25, 50, 75, 85, 90, 92, 95, 98, 99, 99.5, 99.9, 99.9999, 100];
    var epicnessarraytext:Array<String> = ["0", "10", "25", "50", "75", "85", "90", "92", "95", "98", "99", "99.5", "99.9", "99.9999", "100"];
    var frameratearray:Array<Int> = [15, 60, 90, 120, 145, 165, 200, 240];
    var frameratearraytext:Array<String> = ["Refresh Rate", "60", "90", "120", "145", "165", "200", "240"];
    var achievements:Array<String> = [];
    var startcredits:Array<String>;
    var gotfanachievement = false;
    var viewed:Array<String> = [];
    var creditslinks:Array<String> = ['https://www.youtube.com/channel/UCjaxnR-uElEMEF1vadnpyyQ', 'https://www.youtube.com/channel/UCTD3S9rT7n0a0atlFhcuKDQ', 'https://www.youtube.com/channel/UCArzZv4cpIdDMDEWV-HIHUQ'];
    override public function create()
    {
        super.create();
        background = new FlxSprite(0, 0, "assets/images/farmland.png");
        background.setGraphicSize(Std.int(background.width / 1.5));
        background.screenCenter();
        background.alpha = 0;
        background.antialiasing = true;
        add(background);
        smallcreditsgroup = new FlxTypedGroup<FlxText>();
        add(smallcreditsgroup);
        buttonsgroup = new FlxTypedGroup<FlxSprite>();
        add(buttonsgroup);
        creditsbuttongroup = new FlxTypedGroup<FlxText>();
        add(creditsbuttongroup);
        if (FlxG.save.data.lang == "spanish")
            startcredits = ['Mo is Loud Asf - Artista principal', 'G-Corp Mania - Aspectos de Bambi', 'vicholama0 - Traducciones a el español'];
        else
            startcredits = ['Mo is Loud Asf - Main Artist', 'G-Corp Mania - Bambi Sprites', 'vicholama0 - Spanish Translations'];
        for (current in 0...FlxG.save.data.achievements.length)
        {
            achievements.push(FlxG.save.data.achievements[current]);
            trace(achievements[current]);
        }
        presentstext = new FlxText(0, 0, 0, "headshotsniper presents", 26);
        if (FlxG.save.data.lang == "spanish") presentstext.text = "headshotsniper presenta";
        presentstext.alpha = 0;
        presentstext.font = "assets/fonts/koruri.ttf";
        presentstext.screenCenter();
        presentstext.y -= 50;
        add(presentstext);
        titletext = new FlxText(-600, 80, 0, "Bambi's Corn Adventure", 32);
        titletext.font = "assets/fonts/koruri.ttf";
        add(titletext);
        version = new FlxText(320, 120, 0, "Alpha 5", 20);
        version.font = "assets/fonts/koruri.ttf";
        FlxG.watch.add(version, "x", "version text x: ");
        FlxG.watch.add(version, "y", "version text y: ");
        version.alpha = 0;
        add(version);
        FlxG.sound.playMusic("assets/music/main menu loop.ogg", 1, true);
        FlxG.sound.music.pause();
        if (!alreadyentered)
        mainmenumusic = FlxG.sound.load("assets/music/main menu.ogg", 0, false, null, false, false, "", function(){
            FlxG.sound.music.play();
            loopingmusic = true;
        });
        else
        {
            FlxG.sound.music.play();
            loopingmusic = true;
            alreadyplayedthing = true;
        }
        for (i in 0...startcredits.length)
        {
            var text:FlxText = new FlxText(0, 0, 0, startcredits[i], 26);
            text.font = "assets/fonts/koruri.ttf";
            text.screenCenter();
            text.y = 200;
            text.y += 60 * i;
            text.alpha = 0;
            text.ID = i;
            trace(i);
            smallcreditsgroup.add(text);
            var creditstext:FlxText = new FlxText(0, 0, 0, startcredits[i], 26);
            creditstext.font = "assets/fonts/koruri.ttf";
            creditstext.screenCenter();
            creditstext.y -= 70;
            creditstext.y += 100 * i;
            creditstext.alpha = 0;
            creditstext.ID = i + 10;
            creditsbuttongroup.add(creditstext);
            FlxG.watch.add(creditstext, "x", "creditstext text x: ");
            FlxG.watch.add(creditstext, "y", "creditstext text y: ");
        }
        for (i in 0...buttons.length)
        {
            var buttonthing:FlxSprite = new FlxSprite(0, 0, "assets/images/buttons/" + buttons[i].toLowerCase() + ".png");
            buttonthing.antialiasing = true;
            buttonthing.setGraphicSize(Std.int(buttonthing.width / 11));
            buttonthing.updateHitbox();
            buttonthing.screenCenter();
            buttonthing.y -= 160;
            buttonthing.y += 120 * i;
            buttonthing.x += 300;
            buttonthing.ID = i;
            buttonthing.alpha = 0;
            buttonsgroup.add(buttonthing);
        }
        hoverover = new FlxText(0, 150, 0, "Hover over a name to go to their channel!", 26);
        if (FlxG.save.data.language == "spanish") hoverover.text = "Pasa el mouse por encima de un nombre para ir a su canal!";
        hoverover.font = "assets/fonts/koruri.ttf";
        hoverover.screenCenter(X);
        hoverover.alpha = 0;
        add(hoverover);
        start = new FlxText(896, 174, 0, "Start", 34);
        start.font = "assets/fonts/koruri.ttf";
        start.color = 0x000000;
        start.ID = 51;
        start.alpha = 0;
        add(start);
        credits = new FlxText(882, 295, 0, "Credits", 34);
        credits.font = "assets/fonts/koruri.ttf";
        credits.color = 0x000000;
        credits.ID = 52;
        credits.alpha = 0;
        add(credits);
        options = new FlxText(872, 415, 0, "Options", 34);
        options.font = "assets/fonts/koruri.ttf";
        options.color = 0x000000;
        options.ID = 53;
        options.alpha = 0;
        add(options);
        achievementsbutton = new FlxText(910, 540, 0, "Achievements", 24);
        achievementsbutton.font = "assets/fonts/koruri.ttf";
        achievementsbutton.color = 0x000000;
        achievementsbutton.ID = 54;
        achievementsbutton.alpha = 0;
        add(achievementsbutton);
        language = new FlxText(0, 0, 0, "Language", 34);
        language.font = "assets/fonts/koruri.ttf";
        language.y -= 75;
        language.alpha = 0;
        add(language);
        epicness = new FlxText(0, 0, 0, "Epicness", 34);
        epicness.font = "assets/fonts/koruri.ttf";
        epicness.y -= 75;
        epicness.alpha = 0;
        add(epicness);
        frames = new FlxText(0, 0, 0, "Framerate", 34);
        frames.font = "assets/fonts/koruri.ttf";
        frames.y -= 75;
        frames.alpha = 0;
        add(frames);
        achievementext = new FlxText(0, 0, 0, "you dont got no achievement", 26);
        achievementext.font = "assets/fonts/koruri.ttf";
        achievementext.screenCenter();
        achievementext.alpha = 0;
        add(achievementext);
        achievementdescription = new FlxText(0, 0, 0, "you dont got no achievement description", 26);
        achievementdescription.font = "assets/fonts/koruri.ttf";
        achievementdescription.screenCenter();
        achievementdescription.y += 250;
        achievementdescription.alpha = 0;
        add(achievementdescription);
        if (FlxG.save.data.lang == "spanish")
        {
            start.text = "Comenzar";
            start.x -= 40;
            credits.text = "Creditos";
            credits.x -= 15;
            options.text = "Opciones";
            options.x -= 10;
            language.text = "Idioma";
            achievementsbutton.text = "Logros";
            achievementsbutton.setPosition(933, 533);
            achievementsbutton.size = 34; 
            epicness.text = "Epicidad";
            frames.text = "Cuadros por segundo";
        }
        language.screenCenter();
        epicness.screenCenter();
        frames.screenCenter();
        select = new FlxSprite(0, 0).loadGraphic("assets/images/buttons/select.png");
        select.antialiasing = true;
        select.setGraphicSize(Std.int(select.width * 0.3));
        select.screenCenter();
        select.y -= 75;
        select.alpha = 0;
        add(select);
        optionstext = new FlxText(0, 0, 0, "if youre seeing this your game broke please report the bug", 34);
        if (FlxG.save.data.lang == "spanish")
            optionstext.text == "Spanish";
        if (FlxG.save.data.lang == "english")
            optionstext.text == "English";
        optionstext.font = "assets/fonts/koruri.ttf";
        optionstext.screenCenter();
        optionstext.alpha = 0;
        optionstext.y += 150;
        add(optionstext);
        FlxG.watch.add(start, "x", "start x");
        FlxG.watch.add(start, "y", "start y");
        FlxG.watch.add(credits, "x", "credits x");
        FlxG.watch.add(credits, "y", "credits y");
        FlxG.watch.add(options, "x", "options x");
        FlxG.watch.add(options, "y", "options y");
        FlxG.watch.add(achievementsbutton, "x", "achievementsbutton x");
        FlxG.watch.add(achievementsbutton, "y", "achievementext y");
        randimage = new FlxSprite(0, 0, "assets/images/rand/" + FlxG.random.int(1, 6) + ".png");
        randimage.alpha = 0;
        add(randimage);
        randimage2 = new FlxSprite(0, 0, "assets/images/rand/" + FlxG.random.int(1, 6) + ".png");
        randimage2.alpha = 0;
        add(randimage2);
        DiscordClient.changePresence("In The Main Menu", null);
        // timers
        if (!alreadyentered)
        {
            new FlxTimer().start(1, function(presetns:FlxTimer){
                FlxTween.tween(presentstext, {y: presentstext.y + 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(timeragain:FlxTween){
                    new FlxTimer().start(1, function(textgone:FlxTimer){
                        FlxTween.tween(presentstext, {y: presentstext.y + 50, alpha: 0}, 0.3, {ease:FlxEase.cubeIn});
                        new FlxTimer().start(0.426, function(helperstext:FlxTimer){
                            presentstext.text = "With help from:";
                            if (FlxG.save.data.lang == "spanish") presentstext.text = "Con ayuda de:";
                            presentstext.screenCenter();
                            presentstext.y -= 50;
                            FlxTween.tween(presentstext, {y: presentstext.y + 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut, onComplete: function(timeragain:FlxTween){
                                new FlxTimer().start(0.5, function(helpers:FlxTimer){
                                    FlxTween.tween(presentstext, {x: 340}, 0.5, {ease:FlxEase.cubeOut});
                                    new FlxTimer().start(0.15, function(appear:FlxTimer){
                                        smallcreditsgroup.forEach(function(texts:FlxText){
                                            texts.x += 240;
                                            texts.y += 40;
                                            new FlxTimer().start(0.2 * texts.ID, function(tween:FlxTimer){
                                                FlxTween.tween(texts, {y: texts.y + 40, alpha: 1}, 0.4, {ease:FlxEase.cubeOut});
                                            });
                                        });
                                        new FlxTimer().start(1.35, function(thing:FlxTimer){
                                            smallcreditsgroup.forEach(function(textsagain:FlxText){
                                                FlxTween.tween(textsagain, {x: 2600}, 0.625, {ease:FlxEase.quartIn});
                                            });
                                            FlxTween.tween(presentstext, {x: -1400}, 0.625, {ease:FlxEase.quartIn});
                                        });
                                    });
                                }); // 3.7 seconds in
                            }});
                        });
                    });
                }});
            });
            new FlxTimer().start(5.75, function(appear:FlxTimer){
                FlxTween.tween(titletext, {x: 30}, 1, {ease:FlxEase.cubeOut});
                FlxTween.tween(background, {alpha: 1}, 0.4, {ease:FlxEase.cubeOut});
                FlxG.mouse.visible = true;
                new FlxTimer().start(0.75, function(buttonsappear:FlxTimer){
                    start.x += 50;
                    credits.x += 50;
                    options.x += 50;
                    buttonsgroup.forEach(function(button:FlxSprite){
                        button.x += 50;
                        FlxTween.tween(button, {x: button.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut, onComplete: function(finish:FlxTween){
                            finishedappearing = true;
                        }});
                    });
                    FlxTween.tween(start, {x: start.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut});
                    FlxTween.tween(credits, {x: credits.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut});
                    FlxTween.tween(options, {x: options.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut});
                    FlxTween.tween(achievementsbutton, {x: achievementsbutton.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut});
                });
            });
            new FlxTimer().start(6.7, function(appear:FlxTimer){
                version.y -= 25;
                FlxTween.tween(version, {y: 120, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            });
            new FlxTimer().start(11.72, function(randomimage:FlxTimer){
                randimage.screenCenter();
                if (finishedappearing)
                {
                    randimage.alpha = 1;
                    FlxTween.tween(randimage, {alpha: 0}, 1.7, {ease:FlxEase.cubeIn});
                }
            });
            new FlxTimer().start(23.42, function(randomimageagain:FlxTimer){
                randimage2.screenCenter();
                if (finishedappearing)
                {
                    randimage2.alpha = 1;
                    FlxTween.tween(randimage2, {alpha: 0}, 1.7, {ease:FlxEase.cubeIn});
                }
            });
            alreadyentered = true;
        }
        else
        {
            new FlxTimer().start(0.25, function(appear:FlxTimer){
                FlxTween.tween(titletext, {x: 30}, 1, {ease:FlxEase.cubeOut});
                FlxTween.tween(background, {alpha: 1}, 0.4, {ease:FlxEase.cubeOut});
                FlxG.mouse.visible = true;
                new FlxTimer().start(0.75, function(buttonsappear:FlxTimer){
                    start.x += 50;
                    credits.x += 50;
                    options.x += 50;
                    buttonsgroup.forEach(function(button:FlxSprite){
                        button.x += 50;
                        FlxTween.tween(button, {x: button.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut, onComplete: function(finish:FlxTween){
                            finishedappearing = true;
                        }});
                    });
                    FlxTween.tween(start, {x: start.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut});
                    FlxTween.tween(credits, {x: credits.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut});
                    FlxTween.tween(options, {x: options.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut});
                    FlxTween.tween(achievementsbutton, {x: achievementsbutton.x - 50, alpha: 1}, 0.3, {ease:FlxEase.cubeOut});
                });
            });
            new FlxTimer().start(0.75, function(appear:FlxTimer){
                version.y -= 25;
                FlxTween.tween(version, {y: 120, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            });
            FlxG.sound.music.play();
        }
        FlxG.keys.enabled = true;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (FlxG.keys.pressed.SHIFT)
            shifting = true;
        else
            shifting = false;
        if (FlxG.keys.justPressed.LEFT)
        {
            if (inoptions)
                optionvalue("left");
            if (inachievements)
                achievementtype("left");
        }
        if (FlxG.keys.justPressed.RIGHT)
        {
            if (inoptions)
                optionvalue("right");
            if (inachievements)
                achievementtype("right");
        }
        if (FlxG.keys.justPressed.ESCAPE)
        {
            if (creditsfinishedappearing)
                exitcredits();
            if (inoptions)
                exitoptions();
            if (inachievements)
                exitachievements();
        }
        if (viewed.contains('g-corp') && viewed.contains('vicholama') && viewed.contains('moisloud') && !gotfanachievement)
        {
            if (!FlxG.save.data.achievements.contains("Number #1 Fan"))
            {
                var achievementnotif:FlxText = new FlxText(0, 0, 0, "Achievement Unlocked: Number #1 Fan", 28);
                if (FlxG.save.data.lang == "spanish")
                    achievementnotif.text = "Logro Desbloqueado: Fan Número 1";
                achievementnotif.font = "assets/fonts/koruri.ttf";
                achievementnotif.y = -50;
                achievementnotif.screenCenter(X);
                add(achievementnotif);
                FlxG.save.data.achievements.push("Number #1 Fan");
                FlxTween.tween(achievementnotif, {y: 20}, 0.25, {ease:FlxEase.cubeOut, onComplete: function(goback:FlxTween){
                    new FlxTimer().start(1.5, function(goback:FlxTimer){
                        FlxTween.tween(achievementnotif, {y: -50}, 0.25, {ease:FlxEase.cubeIn});
                    });
                }});
                FlxG.sound.play("assets/sounds/achievement.ogg");
                gotfanachievement = true;
                achievements = new Array<String>();
                for (current in 0...FlxG.save.data.achievements.length)
                {
                    achievements.push(FlxG.save.data.achievements[current]);
                    trace(achievements[current]);
                }
            }
            else
                gotfanachievement = true;
        }
        buttonsgroup.forEach(function(buttons:FlxSprite){
            if (FlxG.mouse.overlaps(buttons) && finishedappearing)
            {
                switch (buttons.ID)
                {
                    case 0:
                        start.color = 0xFFFFFF;
                        if (FlxG.mouse.justPressed)
                            cooltransition();
                    case 1:
                        credits.color = 0xFFFFFF;
                        if (FlxG.mouse.justPressed)
                            gotocredits();
                    case 2:
                        options.color = 0xFFFFFF;
                        if (FlxG.mouse.justPressed)
                            optionstransition();
                    case 3:
                        achievementsbutton.color = 0xFFFFFF;
                        if (FlxG.mouse.justPressed)
                            gotoachievements();
                }
            }
            if (!FlxG.mouse.overlaps(buttons) && finishedappearing)
            {
                switch (buttons.ID)
                {
                    case 0:
                        start.color = 0x000000;
                    case 1:
                        credits.color = 0x000000;
                    case 2:
                        options.color = 0x000000;
                    case 3:
                        achievementsbutton.color = 0x000000;
                }
            }
        });
        creditsbuttongroup.forEach(function(textsagain:FlxSprite){
            if (FlxG.mouse.overlaps(textsagain) && creditsfinishedappearing)
            {
                textsagain.color = 0xFFE100;
                if (FlxG.mouse.justPressed)
                {
                    FlxG.sound.play("assets/sounds/click.ogg", 0.7);
                    FlxG.openURL(creditslinks[(textsagain.ID - 10)]);
                    switch(textsagain.ID - 10)
                    {
                        case 0:
                            viewed.push('moisloud');
                        case 1:
                            viewed.push('g-corp');
                        case 2:
                            viewed.push('vicholama');
                    }
                }
            }
            if (!FlxG.mouse.overlaps(textsagain) && creditsfinishedappearing)
            {
                textsagain.color = 0xFFFFFF;
            }
        });
        if (!loopingmusic)
            if (!mainmenumusic.playing && !alreadyplayedthing)
            {
                mainmenumusic.time = startposition;
                mainmenumusic.play();
                mainmenumusic.fadeIn(3, 0, 1);
                alreadyplayedthing = true;
            }
    }
    function exitachievements()
    {
        inachievements = false;
        FlxG.sound.play("assets/sounds/back.ogg", 0.7);
        FlxTween.tween(achievementext, {y: achievementext.y - 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(yes:FlxTween){
            FlxTween.tween(start, {x: start.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            FlxTween.tween(credits, {x: credits.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            FlxTween.tween(options, {x: options.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            FlxTween.tween(achievementsbutton, {x: achievementsbutton.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});  
            buttonsgroup.forEach(function(buttons:FlxSprite){
                FlxTween.tween(buttons, {x: buttons.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(finish:FlxTween){
                    finishedappearing = true;
                }});
            });
        }});
        FlxTween.tween(achievementdescription, {y: achievementdescription.y - 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});    
    }
    function gotoachievements()
    {
        FlxG.sound.play("assets/sounds/click.ogg", 0.7);
        FlxTween.tween(start, {x: start.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(credits, {x: credits.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(options, {x: options.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(achievementsbutton, {x: achievementsbutton.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        buttonsgroup.forEach(function(buttons:FlxSprite){
            FlxTween.tween(buttons, {x: buttons.x + 50, alpha: 0}, 0.3, {ease:FlxEase.cubeOut});
        });
        finishedappearing = false;
        new FlxTimer().start(0.55, function(tweens:FlxTimer){
            achievementext.y = 290;
            achievementdescription.y = 540;
            FlxTween.tween(achievementext, {y: achievementext.y + 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(yes:FlxTween){inachievements = true;}});
            FlxTween.tween(achievementdescription, {y: achievementdescription.y + 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            achievementext.text = achievements[current];
            switch (achievements[current])
            {
                case "A True One":
                    achievementdescription.text = "Played the game during the alpha state";
                    if (FlxG.save.data.lang == "spanish")
                    {
                        achievementext.text = "Uno Verdadero";
                        achievementdescription.text = "Jugaste el juego durante la alpha";
                    }
                case "Classic":
                    achievementdescription.text = "Picked up a piece of corn";
                    if (FlxG.save.data.lang == "spanish")
                    {
                        achievementext.text = "Clásico";
                        achievementdescription.text = "Conseguiste un maíz";
                    }
                case "Really?":
                    achievementdescription.text = "Edited one of the assets";
                    if (FlxG.save.data.lang == "spanish")
                    {
                        achievementext.text = "Enserio?";
                        achievementdescription.text = "Editaste uno de los aspectos";
                    }
                case "Number #1 Fan":
                    achievementdescription.text = "Viewed all contributers's channels";
                    if (FlxG.save.data.lang == "spanish")
                    {
                        achievementext.text = "Fan Número 1";
                        achievementdescription.text = "Viste los canales de todos los contribuidores";
                    }
                case "Great Lengths":
                    achievementdescription.text = "Bringed a piece of corn to Dave's Backyard";
                    if (FlxG.save.data.lang == "spanish")
                    {
                        achievementext.text = "Grandes Distancias";
                        achievementdescription.text = "Llevaste un maíz a el patio de Dave";
                    }
                case "Keyboard Disconnected":
                    achievementdescription.text = "Stayed in the tutorial until the music ends";
                    if (FlxG.save.data.lang == "spanish")
                    {
                        achievementext.text = "Teclado Desconectado";
                        achievementdescription.text = "Te quedaste en el tutorial hasta que acabará la música";
                    }
            }
            achievementext.screenCenter(X);
            achievementdescription.screenCenter(X);
        });
    }
    function achievementtype(set:String)
    {
        trace("prev: " + current);
        switch (set)
        {
            case "left":
                if (current != 0)
                    current--;
            case "right":
                if (current != achievements.length - 1)
                    current++;
        }
        achievementext.text = achievements[current];
        switch (achievements[current])
        {
            case "A True One":
                achievementdescription.text = "Played the game during the alpha state";
                if (FlxG.save.data.lang == "spanish")
                {
                    achievementext.text = "Uno Verdadero";
                    achievementdescription.text = "Jugaste el juego durante la alpha";
                }
            case "Classic":
                achievementdescription.text = "Picked up a piece of corn";
                if (FlxG.save.data.lang == "spanish")
                {
                    achievementext.text = "Clásico";
                    achievementdescription.text = "Conseguiste un maíz";
                }
            case "Really?":
                achievementdescription.text = "Edited one of the assets";
                if (FlxG.save.data.lang == "spanish")
                {
                    achievementext.text = "Enserio?";
                    achievementdescription.text = "Editaste uno de los aspectos";
                }
            case "Number #1 Fan":
                achievementdescription.text = "Viewed all contributers's channels";
                if (FlxG.save.data.lang == "spanish")
                {
                    achievementext.text = "Fan Número 1";
                    achievementdescription.text = "Viste los canales de todos los contribuidores";
                }
            case "Great Lengths":
                achievementdescription.text = "Bringed a piece of corn to Dave's Backyard";
                if (FlxG.save.data.lang == "spanish")
                {
                    achievementext.text = "Grandes Distancias";
                    achievementdescription.text = "Llevaste un maíz a el patio de Dave";
                }
            case "Keyboard Disconnected":
                achievementdescription.text = "Stayed in the tutorial until the music ends";
                if (FlxG.save.data.lang == "spanish")
                {
                    achievementext.text = "Teclado Desconectado";
                    achievementdescription.text = "Te quedaste en el tutorial hasta que acabará la música";
                }
        }
        trace("new: " + current);
        achievementext.screenCenter(X);
        achievementdescription.screenCenter(X);
        FlxTween.cancelTweensOf(achievementext);
        FlxTween.cancelTweensOf(achievementdescription);
        achievementext.y = 290;
        achievementdescription.y = 540;
        trace(achievementext.y);
        trace(achievementdescription.y);
        FlxTween.tween(achievementext, {y: achievementext.y + 50}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(achievementdescription, {y: achievementdescription.y + 50}, 0.5, {ease:FlxEase.cubeOut});

    }
    function optionvalue(set:String)
    {
        if (shifting)
        {
            current = 0;
            switch (set)
            {
                case "left":
                    if (epicness.alpha == 1)
                    {
                        epicness.alpha = 0;
                        language.alpha = 1;
                    }
                    if (frames.alpha == 1)
                    {
                        frames.alpha = 0;
                        epicness.alpha = 1;
                        current = 14;
                    }
                case "right":
                    if (epicness.alpha == 1)
                    {
                        epicness.alpha = 0;
                        frames.alpha = 1;
                        switch (FlxG.save.data.framerate)
                        {
                            case 15:
                                current = 0;
                            case 60:
                                current = 1;
                            case 90:
                                current = 2;
                            case 120:
                                current = 3;
                            case 145:
                                current = 4;
                            case 165:
                                current = 5;
                            case 200:
                                current = 6;
                            case 240:
                                current = 7;
                        }
                    }
                    if (language.alpha == 1)
                    {
                        language.alpha = 0;
                        epicness.alpha = 1;
                        current = 14;
                    }
            }
        }
        else
            switch (set)
            {
                case "left":
                    if (language.alpha == 1)
                    {
                        if (language.text != "English / Ingles")
                            current--;
                    }
                    if (epicness.alpha == 1)
                    {
                        // if (current + 1 != 1)
                        //    current--;
                    }
                    if (frames.alpha == 1)
                    {
                        if (current + 1 != 1)
                            current--;
                    }
                case "right":
                    if (language.alpha == 1)
                    {
                        if (language.text != "Spanish / Español")
                            current++;
                    }
                    if (epicness.alpha == 1)
                    {
                        // if (current + 1 <= epicnessarray.length)
                        //    current++;
                    }
                    if (frames.alpha == 1)
                    {
                        if (current + 1 <= frameratearray.length)
                            current++;
                    }
            }
        if (language.alpha == 1)
        {
            if (set == "right") {
                optionstext.text = "Spanish / Español";
                FlxG.save.data.lang = "spanish";
            }
            else {
                optionstext.text = "English / Ingles";
                FlxG.save.data.lang = "english";
            }
        }
        if (epicness.alpha == 1)
        {
            if (set == "right" && current + 1 <= epicnessarray.length)
                optionstext.text = epicnessarraytext[current];
            else if (set == "right")
                current = epicnessarray.length - 1;
        //    if (set == "left" && current != 0)
            if (set == "left" && current >= 0)
                optionstext.text = epicnessarraytext[current];
            else if (set == "left")
                current = 0;
        }
        if (frames.alpha == 1)
        {
            if (set == "right" && current + 1 <= frameratearray.length)
                optionstext.text = frameratearraytext[current];
            else if (set == "right")
                current = frameratearray.length - 1;
            if (set == "left" && current >= 0)
                optionstext.text = frameratearraytext[current];
            else if (set == "left")
                current = 0;
            FlxG.save.data.framerate = frameratearray[current];
            if (current == 0)
            {
                FlxG.drawFramerate = lime.app.Application.current.window.displayMode.refreshRate;
                FlxG.updateFramerate = lime.app.Application.current.window.displayMode.refreshRate;
            }
            else
            {
                FlxG.drawFramerate = FlxG.save.data.framerate;
                FlxG.updateFramerate = FlxG.save.data.framerate;
            }
            if (FlxG.save.data.framerate == 15)
                Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + lime.app.Application.current.window.displayMode.refreshRate + " FPS";
            else
                Lib.application.window.title = "Bambi's Corn Adventure | Alpha 5 on " + FlxG.drawFramerate + " FPS";
        }
        optionstext.screenCenter(X);
        FlxTween.cancelTweensOf(optionstext);
        optionstext.y = 484.5;
        trace(optionstext.y);
        FlxTween.tween(optionstext, {y: optionstext.y + 75, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
        trace(current);
    }
    function languageupdate()
    {
        if (FlxG.save.data.lang == "spanish")
        {
            start.text = "Comenzar";
            start.x = 906;
            credits.text = "Creditos";
            credits.x = 917;
            options.text = "Opciones";
            options.x = 912;
            language.text = "Idioma";
            epicness.text = "Epicidad";
            frames.text = "Cuadros por segundo";
            achievementsbutton.text = "Logros";
            achievementsbutton.size = 34; 
            achievementsbutton.setPosition(933, 533);
            startcredits = ['Mo is Loud Asf - Artista principal', 'G-Corp Mania - Aspectos de Bambi', 'vicholama0 - Traducciones a el español'];
            language.screenCenter();
            epicness.screenCenter();
            frames.screenCenter();
        }
        else
        {
            start.text = "Start";
            start.x = 946;
            credits.text = "Credits";
            credits.x = 932;
            options.text = "Options";
            options.x = 922;
            language.text = "Language";
            epicness.text = "Epicness";
            frames.text = "Framerate";
            achievementsbutton.text = "Achievements";
            achievementsbutton.size = 24;
            achievementsbutton.x = 910;
            achievementsbutton.y = 540;
            startcredits = ['Mo is Loud Asf - Main Artist', 'G-Corp Mania - Bambi Sprites', 'vicholama0 - Spanish Translations'];
            language.screenCenter();
            epicness.screenCenter();
            frames.screenCenter();
        }
    }
    function optionstransition()
    {
        FlxG.sound.play("assets/sounds/click.ogg", 0.7);
        FlxTween.tween(start, {x: start.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(credits, {x: credits.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(options, {x: options.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(achievementsbutton, {x: achievementsbutton.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        buttonsgroup.forEach(function(buttons:FlxSprite){
            FlxTween.tween(buttons, {x: buttons.x + 50, alpha: 0}, 0.3, {ease:FlxEase.cubeOut});
        });
        finishedappearing = false;
        new FlxTimer().start(0.55, function(tweens:FlxTimer){
            FlxTween.tween(language, {y: language.y + 75, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            FlxTween.tween(epicness, {y: language.y + 75}, 0.5, {ease:FlxEase.cubeOut});
            FlxTween.tween(frames, {y: language.y + 75}, 0.5, {ease:FlxEase.cubeOut});
        //    FlxTween.tween(select, {y: select.y + 75, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            FlxTween.tween(optionstext, {y: optionstext.y + 75, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            hoverover.text = "Use the left and right arrow keys to change values (hold down shift for options)";
            if (FlxG.save.data.lang == "spanish") hoverover.text = "Usa la flecha izquierda y derecha para cambiar los valores (manten precionado shift para las opciones)";
            hoverover.screenCenter(X);
            hoverover.y -= 50;
            if (FlxG.save.data.lang == "spanish")
                optionstext.text = "Spanish / Español";
            else
                optionstext.text = "English / Ingles";
            optionstext.screenCenter(X);
            FlxTween.tween(hoverover, {y: 150, alpha: 1}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(yes:FlxTween){inoptions = true;}});
        });
    }
    function cooltransition()
    {
        if (loopingmusic)
            FlxG.sound.music.stop();
        else if (!mainmenumusic.playing)
            FlxG.sound.music.stop();
        else
            mainmenumusic.stop();
        FlxG.camera.flash(0xFFFFFF, 0.5);
        finishedappearing = false;
        FlxTween.cancelTweensOf(randimage);
        FlxTween.cancelTweensOf(randimage2);
        randimage.alpha = 0;
        randimage2.alpha = 0;
        buttonsgroup.forEach(function(buttons:FlxSprite){
            FlxTween.tween(buttons, {x: buttons.x + 50, alpha: 0}, 0.3, {ease:FlxEase.cubeOut});
        });
        FlxTween.tween(start, {x: start.x + 50, alpha: 0}, 0.3, {ease:FlxEase.cubeOut});
        FlxTween.tween(credits, {x: credits.x + 50, alpha: 0}, 0.3, {ease:FlxEase.cubeOut});
        FlxTween.tween(options, {x: options.x + 50, alpha: 0}, 0.3, {ease:FlxEase.cubeOut});
        FlxTween.tween(achievementsbutton, {x: achievementsbutton.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(titletext, {y: -60, alpha: 0}, 0.75, {ease: FlxEase.cubeIn});
        FlxTween.tween(version, {y: -20, alpha: 0}, 0.75, {ease: FlxEase.cubeIn});
        new FlxTimer().start(0.75, function(backgroundgone:FlxTimer){
            FlxTween.tween(background, {alpha: 0}, 0.9, {ease: FlxEase.cubeIn});
            new FlxTimer().start(1.5, function(backgroundgone:FlxTimer){
                FlxG.switchState(new maps.Tutorial());
            });
        });
        FlxG.sound.play("assets/sounds/start.ogg", 0.3);
        FlxG.sound.play("assets/sounds/start layer.ogg");
    }
    function gotocredits()
    {
        FlxG.sound.play("assets/sounds/click.ogg", 0.7);
        buttonsgroup.forEach(function(buttons:FlxSprite){
            FlxTween.tween(buttons, {x: buttons.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        });
        new FlxTimer().start(0.5, function(thing:FlxTimer){
            creditsbuttongroup.forEach(function(texts:FlxText){
                texts.text = startcredits[texts.ID - 10];
                texts.screenCenter(X);
                texts.x -= 50;
                FlxTween.tween(texts, {x: texts.x + 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(thing:FlxTween){
                    creditsfinishedappearing = true;
                }});
            });
            hoverover.text = "Hover over a name to go to their channel!";
            if (FlxG.save.data.lang == "spanish") hoverover.text = "Pasa el mouse por encima de un nombre para ir a su canal!";
            hoverover.screenCenter(X);
            hoverover.y -= 50;
            FlxTween.tween(hoverover, {y: 150, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
        });
        FlxTween.tween(start, {x: start.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(credits, {x: credits.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(options, {x: options.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(achievementsbutton, {x: achievementsbutton.x + 50, alpha: 0}, 0.5, {ease:FlxEase.cubeOut});
        finishedappearing = false;
    }
    function exitcredits()
    {
        creditsfinishedappearing = false;
        FlxG.sound.play("assets/sounds/back.ogg", 0.7);
        FlxTween.tween(hoverover, {y: 100, alpha: 0}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(gobackagain:FlxTween){
            hoverover.y = 150;
        }});
        creditsbuttongroup.forEach(function(texts:FlxText){
            FlxTween.tween(texts, {x: texts.x - 50, alpha: 0}, 0.5, {ease:FlxEase.cubeIn, onComplete: function(thing:FlxTween){
                texts.x += 50;
                buttonsgroup.forEach(function(buttons:FlxSprite){
                    FlxTween.tween(buttons, {x: buttons.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(finish:FlxTween){
                        finishedappearing = true;
                    }});
                });
                FlxTween.tween(start, {x: start.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
                FlxTween.tween(credits, {x: credits.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
                FlxTween.tween(options, {x: options.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
                FlxTween.tween(achievementsbutton, {x: achievementsbutton.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});  
            }});
        });
    }
    function exitoptions()
    {
        inoptions = false;
        FlxG.sound.play("assets/sounds/back.ogg", 0.7);
        FlxTween.tween(hoverover, {y: 100, alpha: 0}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(gobackagain:FlxTween){
            hoverover.y = 150;
        }});
        FlxTween.tween(language, {y: language.y - 75, alpha: 0}, 0.5, {ease:FlxEase.cubeIn});
        FlxTween.tween(epicness, {y: epicness.y - 75, alpha: 0}, 0.5, {ease:FlxEase.cubeIn});
        FlxTween.tween(frames, {y: epicness.y - 75, alpha: 0}, 0.5, {ease:FlxEase.cubeIn});
        FlxTween.tween(optionstext, {y: optionstext.y - 75, alpha: 0}, 0.5, {ease:FlxEase.cubeIn, onComplete: function(getback:FlxTween){
            languageupdate();
            buttonsgroup.forEach(function(buttons:FlxSprite){
                FlxTween.tween(buttons, {x: buttons.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut, onComplete: function(finish:FlxTween){
                    finishedappearing = true;
                }});
            });
            FlxTween.tween(start, {x: start.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            FlxTween.tween(credits, {x: credits.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});
            FlxTween.tween(options, {x: options.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});     
            FlxTween.tween(achievementsbutton, {x: achievementsbutton.x - 50, alpha: 1}, 0.5, {ease:FlxEase.cubeOut});  
        }});
    }
}