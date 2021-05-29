# BloxExecutor v1
An very old, archived version of BloxExecutor v1 (BEv1) that was made back at the early days at August 2020.

![](https://i.imgur.com/67qO1vj.png)
BEv1 UI ^

You are free to use this code for educational purposes, such as learning it, etc. However if you're gonna make your own executor then please make one from scratch instead of basing it with BEv1, BEv1 is quite unoptimized in my opinion.

# Compiling the project to a Roblox place file
The original version of BEv1 did not use Rojo, so I have converted it into using Rojo.
Make sure you have Rojo installed and added to your PATH.

In order to compile it to a Roblox place file, execute the following command below on the project's root directory:
```
rojo build -o BEv1_Rojo.rbxlx
```

# History of BloxExecutor
Back at 2020, I was interested in script builder games, so I used leaked script hubs out there to play them.
However overtime, I was frustated with the fact that the scripts would be broken, UI would be bloated, etc, at this point I had decided to create myself a private executor that allows running code on both server-side and client-side, and also has a script hub with working scripts.
BEv1's development started around July 2020 - August 2020, at that time my vision was to create an operator-level, powerful executor, unfortunately since I had limited time at that time, I was forced to create it basic and simple.

Around December 2020, I had decided to do a major change, which would be BloxExecutor v2 (BEv2), BloxExecutor v2 introduced an rewrite to the code, this also implemented custom function environments to the executor and introduced multiple components such as BEProtect, BEMusicPlayer, BERawStringExecutor, and 2 more components that were not directly tied to the executor, which was BEAS (BloxExecutor Admin Suite, an administration utility based on Adonis, I had to modify almost the entire core part to make it different that Adonis and to prevent conflicts), and BEDex (A fork of Dark Dex v3, which I heavily modified to implement back almost all features that originally existed on Dex Explorer v2 and an addition FE compability + ability to view ServerStorage and ServerScriptService), BEv2 was **partially** an operator-level executor, it's partial because it's unfortunately weak to script deletion and scripts such as Lighting Canon, Anti-IL, HyperSkidded Canon, etc.

BEv2 UI, notice theres a lot of changes
![](https://i.imgur.com/2f8pj7V.png)

At May 28 2021, I have decided to begin development of BEv3, BEv3 forced me to go back to the drawing board and redesign how it works completely (how it handles the ui, remotfunctions, etc), however the rewrite was much better, as it now allows enchanced protection feature and it is no longer weak towards the weaknesses that BEv2 had, until now BEv3's development is still in progress and is currently still unstable.
