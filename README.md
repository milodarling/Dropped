Dropped
=======

Activator events for dropping your phone.

Useful for logging drops (maybe if you lend your phone to someone),  funny jokes (like screaming or text-to-speech), or maybe locking your phone when it hits your bed or desk.

Please note that it may take 30 seconds at most after enabling for tweak to take effect (this is hopefully temporary and is in place as a way to save battery until I find the correct way to do it).

The code was based a lot off of FreeFall. Thanks to Steve Rolfe for [FreeFall](https://github.com/srolfe/tweaks/tree/master/freefall), as well as the [iPhoneDevWiki](http://iphonedevwiki.net/) for all of the help and resources there, and uroboro for his [example Activator event code](https://github.com/uroboro/UnlockEvents) and his help on IRC.

Please note that the preference bundle uses [SettingsKit](https://github.com/mlnlover11/SettingsKit/), so you’ll need that installed if you want to compile/mess with this project. In the makefile for the preference bundle, I disabled ARC (even though I should probably use it) because I have SettingsKit set up to work this way. You’ll probably want to uncomment that line in the makefile and re-enable ARC, though (unless you have it set up like me).

Licensed under the MIT License (do whatever you want with it :)