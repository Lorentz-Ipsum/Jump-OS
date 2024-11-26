; https://github.com/JuanmaMenendez/AutoHotkey-script-Open-Show-Apps
; This AutoHotkey script is to Open, Restore or Minimize the desires Apps using the configured shortcuts key (hotkeys) you want.
; There are three functions you can use for this: 
;
;
; a) OpenOrShowAppBasedOnExeName(AppAddress) //Useful for regular Window Apps

; b) OpenOrShowAppBasedOnWindowTitle(WindowTitleWord, AppAddress)  //Specially useful for Chrome Apps and Chrome Shortcuts 

; c) OpenOrShowAppBasedOnAppModelUserID(AppTitle, AppModelUserID) //Useful for Windows Store Apps (contained in the "shell:AppsFolder\")


; Additionally, pressing Alt + ` (key above Tab key) you can switch between open Windows of the same "type" and same App (.exe)
; The "type" checking is based on the App's Title convention that stipulates that the App name should be at the end of the Window title (Eg: New Document - Word )



/* ;
*****************************
***** UTILITY FUNCTIONS *****
*****************************
*/


#WinActivateForce ; Prevent task bar buttons from flashing when different windows are activated quickly one after the other.



; AppAddress: The address to the .exe (Eg: "C:\Windows\System32\SnippingTool.exe")

OpenOrShowAppBasedOnExeName(AppAddress)
{


	AppExeName := SubStr(AppAddress, InStr(AppAddress, "\", false, -1) + 1)
		

	IfWinExist ahk_exe %AppExeName%
	{
	
		IfWinActive
		{
			WinMinimize
			Return
		}
		else
		{
			WinActivate
			Return
		}
				
	}
	else
	{	
	
		Run, %AppAddress%, UseErrorLevel
        If ErrorLevel
        {
            Msgbox, File %AppAddress% Not Found
            Return
        }
		else
		{
			WinWait, ahk_exe %AppExeName%
			WinActivate ahk_exe %AppExeName%			
			Return
		}			
		
	}
}


; WindowTitleWord: Usually the word at the end of the app window title (Eg: in: "New Document - Word" will be "Word")
; AppAddress: The address to the .exe (Eg: "C:\Windows\System32\SnippingTool.exe")

OpenOrShowAppBasedOnWindowTitle(WindowTitleWord, AppAddress)
{

	SetTitleMatchMode, 2
	

    IfWinExist, %WindowTitleWord%
    {    

		IfWinActive
		{
			WinMinimize
			Return
		}
		else
		{
			WinActivate
			Return
		}
	
	}
    else
    {
        Run, %AppAddress%, UseErrorLevel
        If ErrorLevel
        {
            Msgbox, File %AppAddress% Not Found
            Return
        }
		else
		{
			WinActivate
			Return
		}
    }
}



; AppTitle: Usually the word at the end of the app window title(Eg: in: "New Document - Word" will be "Word")
; AppModelUserID: A comprehensive guide on how to find the AppModelUserID of a windows store app can be found here: https://jcutrer.com/windows/find-aumid

OpenOrShowAppBasedOnAppModelUserID(AppTitle, AppModelUserID)
{

	SetTitleMatchMode, 2

    IfWinExist, %AppTitle%
    {    

		IfWinActive
		{
			WinMinimize
			Return
		}
		else
		{
			WinActivateBottom %AppTitle%
		}
		
	}
    else
    {

        Run, shell:AppsFolder\%AppModelUserID%, UseErrorLevel
        If ErrorLevel
        {
            Msgbox, File %AppModelUserID% Not Found
            Return
        }
		
    }
}


ExtractAppTitle(FullTitle)
{
	AppTitle := SubStr(FullTitle, InStr(FullTitle, " ", false, -1) + 1)
	Return AppTitle
}


/* ;
***********************************
***** SHORTCUTS CONFIGURATION *****
***********************************
*/




; KeePass
#q::OpenOrShowAppBasedOnExeName("C:\Program Files\KeePass Password Safe 2\KeePass.exe")
; Terminal
#Enter::Send #1
; Obsidian
#v::OpenOrShowAppBasedOnExeName("C:\Users\Manu Arroyo\AppData\Local\Obsidian\Obsidian.exe")
; Firefox
#w::OpenOrShowAppBasedOnExeName("C:\Program Files\Mozilla Firefox\firefox.exe")

; Chrome
#!w::OpenOrShowAppBasedOnExeName("C:\Program Files\Google\Chrome\Application\chrome.exe")

; Brave
#^w::OpenOrShowAppBasedOnExeName("C:\Users\Manu Arroyo\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe")


; TouchDesigner
;#s::OpenOrShowAppBasedOnExeName("C:\Program Files\Derivative\TouchDesigner\bin\TouchDesigner.exe")
#s::OpenOrShowAppBasedOnExeName("C:\Users\manuf\AppData\Local\slack\slack.exe")

; ResolPume
;#a::OpenOrShowAppBasedOnExeName("C:\Program Files\Resolume Arena\Arena.exe")

; VS Code
#+v::OpenOrShowAppBasedOnExeName("C:\Users\manuf\AppData\Local\Programs\Microsoft VS Code\Code.exe")
; Notepad++
#z::OpenOrShowAppBasedOnExeName("C:\Program Files\Notepad++\notepad++.exe")
; Spotify
#f::OpenOrShowAppBasedOnExeName("C:\Users\manuf\AppData\Roaming\Spotify\Spotify.exe")
; Steam
#6::OpenOrShowAppBasedOnExeName("C:\Program Files (x86)\Steam\steam.exe")



/*

; KeePass
#q::OpenOrShowAppBasedOnExeName("C:\Program Files\KeePass Password Safe 2\KeePass.exe")
; Word
#w::OpenOrShowAppBasedOnExeName("C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE")
; DoubleCmd
#f::OpenOrShowAppBasedOnExeName("C:\Program Files\Double Commander\doublecmd.exe")
; Terminal
#a::OpenOrShowAppBasedOnExeName("C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.11.3471.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe")
; Slack
#s::OpenOrShowAppBasedOnExeName("C:\Users\ManuelFernandez\AppData\Local\slack\slack.exe")
; Notepad++
#z::OpenOrShowAppBasedOnExeName("C:\PortableApps\npp.8.1.4.portable.x64\notepad++.exe")
; Outlook
#c::OpenOrShowAppBasedOnExeName("C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE")
; Obsidian
#b::OpenOrShowAppBasedOnExeName("C:\Users\ManuelFernandez\AppData\Local\Obsidian\Obsidian.exe")

*/




/*
; F7 - Open||Show "SnippingTool"
F7:: OpenOrShowAppBasedOnExeName("C:\Windows\System32\SnippingTool.exe")
; F8 - Open||Show "Gmail as Chrome App"
F8:: OpenOrShowAppBasedOnWindowTitle("Gmail", "C:\Program Files\Google\Chrome\Application\chrome.exe --app=https://mail.google.com/mail/")
/*
 Use this if you have your chrome in the "Program Files (x86)" folder
 F8:: OpenOrShowAppBasedOnWindowTitle("Gmail", "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --app=https://mail.google.com/mail/")
 */
; F9 - Open||Show "Windows store Calculator app"
F9:: OpenOrShowAppBasedOnAppModelUserID("Calculator", "Microsoft.WindowsCalculator_8wekyb3d8bbwe!App")
*/

; Alt + ` -  Activate NEXT Window of same type (title checking) of the current APP
!`::
WinGet, ActiveProcess, ProcessName, A
WinGet, OpenWindowsAmount, Count, ahk_exe %ActiveProcess%

If OpenWindowsAmount = 1  ; If only one Window exist, do nothing
    Return

Else
	{
		WinGetTitle, FullTitle, A
		AppTitle := ExtractAppTitle(FullTitle)

		SetTitleMatchMode, 2
		WinGet, WindowsWithSameTitleList, List, %AppTitle%

		If WindowsWithSameTitleList > 1 ; If several Window of same type (title checking) exist
		{
			WinActivate, % "ahk_id " WindowsWithSameTitleList%WindowsWithSameTitleList%	; Activate next Window
		}
	}
Return


