RobloxAutoUDP is an autohotkey script that automatically creates a Roblox only filter using netstat.
THIS MAY NOT WORK ON WINDOWS 11!
Please let me know if there are any issues on Windows 11.
It also serves as a Clumsy toggle with on/off sounds and a chime for when a new filter is created, and will start Clumsy with bandwidth at 1kb/s upon using the assigned toggle. 
The toggle may be changed by deleting the .ini and reloading the script from your system tray, or by editing the .ini itself with a valid AHK hotkey. 
All three sounds can be changed in the sounds folder by swapping the .wav files with any other .wav files of your choice, all of which must share an identical name to the respective .wavs being replaced. 
You do not need AutoHotKey V1 installed to use this. Closing this script will also close Clumsy. 
u may replace the .exe with the provided source .ahk if you have AutoHotkey V1 installed. 
This script must be run as admin to work properly.

If RobloxAutoUDP does not work (Which will likely happen on Windows 11), please try RobloxAutoIP instead. 
It obtains the last/current Roblox server ip address you were connected to from the Roblox logs instead of the current UDP. 
This will not work if immediately used after Roblox has an update, I am aware of this issue and will try fixing it, for now leaving and rejoining the game fixes this. 

Later on I will merge AutoUDP and AutoIP, and make obtaining the server IP the default, with the ability to change back to UDP from the .ini, if you wish to do that for any reason.

Enjoy!
