# VanguardController
It's a batch file that unloads/deletes the Riot Vanguard when you're not playing the game. It's for both Valorant and League of Legends.
It loads Vanguard when the game starts, and unloads when you close your game.

You need to launch the games from the batch files for this fo work as intended.

# How To Use

Copy all the files to "C:\Program Files\Riot Vanguard" path. Then edit the "<RIOT CLIENT PATH" section of the batch file and type your "RiotClientServices.exe"s file path instead of it. After that, you can create a shortcut of the batch files to the desktop. Do not run the batch files with administrator privileges, the batch file itself is going to request it from you. When you close the game, it deletes (unloads) vanguard including the kernel driver.


