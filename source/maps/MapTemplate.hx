package maps;

import flixel.FlxState;

class MapTemplate extends FlxState
{
    // LOL GET TROLLED NO TEMPLATE FOR YOU EHEHEHEHEHEHEHEH
    /*
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(.&@@#.&@@@@@@&,.#@@,/@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#,@@@@@@&.@&@(,@@@@@@@/%&&%%&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/(@@@@@@@&/@/&@@&&&&&@*%&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%,@(*%@@@@(%@@@@@@&&@(,@&&&&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/*@/&@@#(@(*(&&. &@@@&.%@&&&&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#@@@@@@@@@(****(((%@./@(@@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*.#@%.*@@/****((((#@/(@&/(@@&&&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#.&&.    .@@&((((((##@%*@@/*@@,(@&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/.@        ,@@@@@&&@@#//@&***@@@%.@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@..*%@@%#(///%@@@#,/#@@%.***%@(,@.@......................(@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*. .(&@@@@&%,@/%@  .@/%((@(**(@@/@.(@...........................&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&*,            @.#%  ,@(/@/@(.*&@@*./@*..............#.... ...........%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#*, .*    .,    %(,@ ,(@.,@*****@@@@/,....................*@, ............,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@&**,**.  .**, ,*. ,@.#%%@*.&@****%@@/...........&...............(@  ...  ......*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@#*****,.*****,,,******@/,,(@&****@@@/............./@@@#.............*#       ...   &@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@#,*********,,,*********************&@@@*...........*@@@@@(*#@@#.......     *....         %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*****************&@@@@/...........,@@@&********@@@            ...... .     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&@@@@@@@@@*#&@@@@@@((%.... ......&@@%***,..,,*****@@@ .....*@@( ....&@....  (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&#(*.....*@ .    ....&@@,              .**(@@#.........,.....(#...  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*,........@%        *@@(                    *%@@.......(*............@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@**,.*#.....@..  ....%@@.  .&#                  ,@@...@.*@@(...........%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@****@#....., . ....%@@             ./(,         &@%@@&@@*@@.........(@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ .........../@@   @@      &@@*            *@@/%@(  ****@&.......#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     (@(...........@@.   *@@@@@@@@@@@@@@@.      (@@@@@(.  @@***@@#.... %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@. (@@@@@@ ..%%.....(@#  .@@  @@@@@@@.             @@@@@@@@@@# **@@@@ ...@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  .**@,*@%..@@.... @@        @@@@@@@@            .@@@@@@@   %  *#@@@@*,/@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@. ,%@@#@**@@%....@@        @@@@@@@@            @@@@@@@@      .@@@@@@@@@@&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%   (@@,@@@...*@#        *@@@@@@#            @@@@@@@@    /@@@%%@&@@#****@@#&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*(@@@@&*&@@@@@ .(@/                             @@@@@@   (@@&&@@%#####%@%@#/#@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%..@&**%@@@@&@@(#@((@@ #@(                                     @@@@@&&@######@@#@###%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&....%@&&@@@@@@@@@@@***@@@*@(                                    *@@@@&%%#@%#&@#####&@%@#&@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@....../@@@/*@/(@@@@@@@@@*@/@@@@@@@@,          @@((((@@              /@@&@@%%&@%@%#######@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&.......@@%********&@@@@@#@@@@@@@@@@@@/    /((((@@@(               @@@@@@&%%###@&##&@##@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@....   @@&************&@@@@@@@@@@@@@@&@@@@@@@&,              ./@@@@@@@@%%@&%%%%%@@@###@@@#@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.     .@@@@@@#*********%@@@@@@@@@@@%*, .,**%&@@@@@@@@@@@@@@@@@@%(@@@@@@@@@@&%%%%%@@@&@@@/*@@      *@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&    ...%@@@@@@@%*******#@@  ,@@@@@@%         @&**@%.   @@@@@@@@/......,@@@@&&@@@@@@@%*##%@%        ,@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@.@@@@@@@@. ......@@@@@@@@******@@&  ./@@  .&@@#.   @@@/@@@*  &@@#***,(@@@@@@@&@@@@&##########@@.          %@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@.&@@@@@@@@,........,@@@@@&#/*(@@(@(   **@@.     &@@@&&@%@@@@@@*   &@&**, &@@&@@@***#@@@@@@@@(              @@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@&  @@&#&@@@@@............*(%&%,.@@*    ,*,@@.   @@..*,&@@@@@%/.*@,    %@@*,.@@@@%****&@****,       %@%.       @@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@&*@@,  %@@*****#@@@*...........,&@&       ****@%   &@*@/@@#@%(@&(@@%@,      (@@* (@@@&****&@(*****,#@&            .@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@&@@@@/@@@@. ..&@@@@@%***#@@@@@@@@@@@*         ,****(@.    *&%*&@ *,@#,%& ,*******&@/* #@@%@******@@@@%*               @@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@,@@@@@@@@#.....&@@@@#****@@@@              ,******@#,***@,./@/,,./@/@@********(@&**,@@%&@@*****&@/***              .@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@# &@@@@@@@@@(.......,/#&@@@@@@            ,*******#@(****@@@@@***((&@@********&@%***@@    @@****@@*****   .&@@@@     @@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@@&&@@@@@@@@@@@@@#      .,********&@#************@(/((*******@@#****@@.      *#%&%*@@@&@@&/*,        .@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@&.#@@@@@@@@@@@@@@@@@@@@@@@@@@@@       .****@@@@@@%************((((****@&@@@*****@@               *@&****         @@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@%#@@@@@@@@@@@@@@@@@@@@@@@@@%/@@@@@@@@@@@@@@@@(*%@@@@@@%/**(//#%@@@&,.@@/##&@@@                 @@*****,    (@@&#@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#     ,*****@@@@&&&//&@@@#*.       .#@@&%@@@****(/                   %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@. (@@@@@@@@@@@@@@&&&%,.%%#%@@%%%(,.,%%@%%%@@@@@@#                          ,@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%        ,*****@@@&&&&,.*%%%#@%%%%/%@@@%@%@@@@**.                       *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         ,*****@@@&&&&(..%%%%@#///////#@%%@@@@%*.                  .%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*         ******&@&&&&&//.%%%%@@&&&#((#&@%%@@@@@%*.            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&          ******%@&&&&%//(%%%%%@@@@@@@&/%@%%@@@@@@@@/ .,(%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          .******(@@&&&(//&%%%%%@@@@@&&@@@@%%&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           ********@&/&@%#%%#%%@@&&&#/(/&%@@* /@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.          .********@@@@@@%/  ,/%@@@@@@%&&, .&@@@%/(@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            *********@@////#&@@@@@@@%(**./@@@@&///*,....,&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%            **********%@///////////%,,/%@@%,.................*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.            ***********(@/..////%@#............%&/,..............%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             ************@@,.../#@&................/@&/*..............%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            .**************@@,...#@#...................,@@#/*..............%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@(            ***************@@,..(@#,/(((((((((((/((((((,..@@%//,.............,&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/..&@(            **************&@@../@@@@@@@@@@@@@@@@@@@&%(((((((@@%//*........,****,/@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@*  %@&/@&            *************&@@%.,@@///////&@/@@********@/%@@@@&(#@@(//*...*(((((((((((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@   *&@@&#.&@@            ,**********&@@@@...&@&//////%@(*@@**********@@//&@@@@&////(&@@@@#(%@@@@@%%@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@#((/*@/*.  %@@/    .*************%@@@@@@,...*@/@@%////(@/ /@@**********@%////&@@@/(%@@@&///////////#@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@%@@/ ...          .%@@@&(,,,,*****%@%**@@@@#((((%%%#@@@//#@@#,%@@**********@(////(@@/%@@@(////////////////&@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@#     .*&%(*.   ,   ,(&@@@@@@@&***@@@@@@@@@@@@@@@@@@@@&(%@@@@@&(/,     %&////%@@/@@%/////////////////@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#/#@(#@@@@(          %@@@***&@@@@%%%%#@@//////@@#///#@(@@&@@@@@@@,*@//@@@@((@@&//////////////%@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&*..       ,..,/&@#//&@@@@@%&@@%%##/%@&//////@@(///@@%@@//#@@(&@@@@@@@@&@@@@@%////////%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@(///&@,     %@@///////////(@@@%%#%@@%%#//&@#/////(@@///#@(@@%#@@/////@@@@@@@&/%@((%@@@@@@@#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@&@@&/////(&@@&#////////////////@@@%%%%@@%#///@@//////@@(///@@#@@@@/////@@(/(@@@///(%##%%@@@@@&#&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&#(//////////////////(@@@%%%@@&%(//@@#/////#@%///@@/@@@////(@@///@@@////////////////(&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@&&%###%@@@%%%%@@%#(/&@#/////(@@///@@/@@@/////@@//(@@%(##%@@@@@@@@@@@@&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%//(@@@@@@@@&#%%#@@#//(%%%@@#%%@@@@@@&/(//(@&//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@%//(@@%****%@@@@@&@@//////@@&%#@@%@@/&@%////(@#&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@(*.   (@@@@@%((@@%@@@@@@#//&@%/#@@@@@%.&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&%%&@@@@%.    .#@@@(.  @@@(//&@@@@@,  (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&%%%%%%%%%%&@@@@%,   /@@@@@@@@@@(*** #@@@@@%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&%%%%%%#%%%%%%%%%%%&@@@@&&@@/******(@@@@@%#%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&%%%%%%%#%%%%%%%%%%%##%%#%@@@&@@@@@@@&%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&%%%%%%%%#%%%%%%%%%%%%%%%%&@@@&&&&&&&&%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%%#%%%%%%%%%%%%%%%%@@@@&&&&&&&&%%%#%%%%%%%%%%%&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%%#%%%%%%%%%%%%%%%@@@@@@&&&&&&&%##%%%%%%%%%%%#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%%#%%%%%%%%%%%%%%%@@@@@@@&&&&&&%%%#%%%%%%%#%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%%#%%%%%%%&@@@@@&&@@@@@@@&&&&&%%#%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&%%%%%%%%#%%%%@@@@(,,,/@@@@@@@@@@@@@@@@@#%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%#%%%@@,,..,,,,,,@@@@@@%//////(@@@%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&%%%%%%%%#%%@@,,,,,.....,,%@@@@//////////#@@%%#%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%%%%@@@,,,,,.....,,,(@@#////////////@@&%%%%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%%%%%%%@@@*..........,,,,,@@@/////////////@@%%%%%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(///%@@@@@@@@@/,...........,,,,,,%@@@//////////,/&@@@&@@@@%,,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(///////////*@/*.,.,.,.,...........,.%@@@(///////,////*,.,.,,,,(@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(((&@@@@@@@@@%*,,.,,,,,,,........,,,,,,@@@%///%&@@@@@@(,,..,,.,@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#######%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    */
}