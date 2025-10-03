#SingleInstance, force
Menu,Tray,NoStandard
Menu,Tray,Add,Reload RobloxAutoUDP,Reload
Menu,Tray,Add,Suspend Hotkeys,Suspend
Menu,Tray,Add,Exit,Exit
full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

commandstring = "powershell -command "$ErrorActionPreference= 'silentlycontinue'; $udpVar = netstat -anob | Where-Object{$_ -match 'LISTENING|UDP|Roblox'} | Select-String -Pattern "RobloxPlayerBeta.exe" -Context 1,0 | findstr "UDP"; $udpVar = $udpVar.Substring(0, [System.Math]::Min(24, $udpVar.Length)); $clumsyUDP = $udpVar.Substring(19)"; $clumsyUDP = Write-Host "udp and '('udp.DstPort == ($clumsyUDP) or udp.SrcPort == ($clumsyUDP)')'""
nullcommandstring = "powershell -command "$ErrorActionPreference= 'silentlycontinue'; $udpVar = netstat -anob | Where-Object{$_ -match 'LISTENING|UDP|Roblox'} | Select-String -Pattern "RobloxPlayerBeta.exe" -Context 1,0 | findstr "NULL"; $udpVar = $udpVar.Substring(0, [System.Math]::Min(24, $udpVar.Length)); $clumsyUDP = $udpVar.Substring(19)"; $clumsyUDP = Write-Host "udp and '('udp.DstPort == ($clumsyUDP) or udp.SrcPort == ($clumsyUDP)')'""
Var := 0
sVar := 0
oldclip = %A_Clipboard%
RunWait, %comspec% /c %nullcommandstring% | clip,, hide
nullError := clipboard
clipboard = %oldclip%

IniRead, keyname, config.ini, settings, clumsyToggle, %A_Space%
if (keyname = "")     ; no keyname defined or no ini file 
{
	; display GUI asking for what hotkey to use
	Gui, Add, Text,, Not hotkey detected! Please choose Clumsy 3.0 toggle key:
	Gui, Add, Hotkey, vUserChosenKey
	Gui, Add, Button,, Save
	Gui, Show
	SoundPlay, *16
}
else
{
   Hotkey, %keyname%, Button
}
return

ButtonSave:
Gui, Submit
IniWrite, %UserChosenKey%, config.ini, settings, clumsyToggle
Reload

Suspend:
if (sVar = 0)
{
	sVar := 1
	Hotkey, %keyname%, off
	Menu, Tray, Check, Suspend Hotkeys
}
else
{
	sVar := 0
	Hotkey, %keyname%, on
	Menu, Tray, Uncheck, Suspend Hotkeys
	WinActivate, clumsy 0.3
	WinMinimize, clumsy 0.3
	WinActivate, Roblox
}
return

Exit:
Process, Exist, clumsy.exe
If ErrorLevel = 0
{
ExitApp
}
else
{
WinClose, clumsy 0.3
ExitApp
}

Reload:
WinClose, clumsy 0.3
Reload
return

Button:
Process, Exist, clumsy.exe
If ErrorLevel = 0
{
	run %a_scriptdir%\clumsy-0.3-win64-a\clumsy.exe
	click
	sleep 100
	WinMinimize, clumsy 0.3
	WinActivate, Roblox
	ControlClick, Button28, clumsy 0.3
	ControlSetText, Edit11, 1, clumsy 0.3
	Var := 0
	Process, Exist, RobloxPlayerBeta.exe
	If ErrorLevel = 0
	{
		SoundPlay, *16
		MsgBox, 48, Warning, RobloxPlayerBeta.exe not found.`n`nRoblox must be active!,
		Var := 0
		return
	}
	else
	{
		If (Var = 0)
		{
			Var := 1
			ControlSetText, Edit1, %localUDPFilter%, clumsy 0.3
			ControlClick, Button2, clumsy 0.3
			SoundPlay, %a_scriptdir%\sounds\activateSound.wav
			oldclip = %A_Clipboard%
			RunWait, %comspec% /c %commandstring% | clip,, hide
			localUDPFilter := clipboard
			clipboard = %oldclip%
			If (localUDPFilter = nullError)
			{
				SoundPlay, *16
				MsgBox, 48, Warning, RobloxPlayerBeta.exe was found but not in-game.`n`nMust be in-game!,
				Var := 0
				return
			}
			else
			{
				if (OldUDPFilter != localUDPFilter)
				{
					OldUDPFilter := localUDPFilter
					ControlClick, Button2, clumsy 0.3
					ControlSetText, Edit1, %localUDPFilter%, clumsy 0.3
					ControlClick, Button2, clumsy 0.3
					SoundPlay, %a_scriptdir%\sounds\udpSound.wav
				}	
				return
			}
		return
		}
	}
}
else
{
	Process, Exist, RobloxPlayerBeta.exe
	If ErrorLevel = 0
	{
		SoundPlay, %a_scriptdir%\sounds\activateSound.wav
		sleep 300
		SoundPlay, *16
		MsgBox, 48, Warning, RobloxPlayerBeta.exe not found.`n`nRoblox must be active!,
		Var := 0
		return
	}
	else
	{
		If (Var = 0)
		{
			Var := 1
			ControlSetText, Edit1, %localUDPFilter%, clumsy 0.3
			ControlClick, Button2, clumsy 0.3
			SoundPlay, %a_scriptdir%\sounds\activateSound.wav
			oldclip = %A_Clipboard%
			RunWait, %comspec% /c %commandstring% | clip,, hide
			localUDPFilter := clipboard
			clipboard = %oldclip%
			If (localUDPFilter = nullError)
			{
				SoundPlay, *16
				MsgBox, 48, Warning, RobloxPlayerBeta.exe was found but not in-game.`n`nMust be in-game!,
				Var := 0
				return
			}
			else
			{
				if (OldUDPFilter != localUDPFilter)
				{
					OldUDPFilter := localUDPFilter
					ControlClick, Button2, clumsy 0.3
					ControlSetText, Edit1, %localUDPFilter%, clumsy 0.3
					ControlClick, Button2, clumsy 0.3
					SoundPlay, %a_scriptdir%\sounds\udpSound.wav
				}	
				return
			}
		}
	else
		{
			Var := 0
			SoundPlay, %a_scriptdir%\sounds\deactivateSound.wav
			sleep, 540 ; 1000 = 1 second
			ControlClick, Button2, clumsy 0.3
			return
		}
	}
}