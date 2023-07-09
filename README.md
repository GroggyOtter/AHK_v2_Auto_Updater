# AHK_v2_Auto_Updater

Class object that will notify you of AHKv2 updates and ask if you'd like to download the new version.

To use it, put the class anywhere in your script and it should auto-start when the script starts.

## Properties:

### `check_freq_in_min` [Integer]  
How often, in minutes, you want the script to check for an update.

### `disable_checker` [Integer]  
Setting this to true disables auto-checking until it's enabled again.  
If you want to do a 1-time check for updates, call the `v2_Auto_Updater.RunOnce()` method.

## Methods:

### `RunOnce()`
Does a single check for an update.  
Can be used as a hotkey bind.
