; Creator: GroggyOtter
; Created: 20230708
; Website: https://github.com/GroggyOtter/AHK_v2_Auto_Updater
; License: GNU (Please keep these comments with the code)
class v2_Auto_Updater {
    ; User properties
    static check_freq_in_min := 120    ; How often to check for updates (in minutes)
        ,  disable_checker   := 0      ; When set to true, checking is disabled 
    
    #Requires AutoHotkey 2.0+
    static __New() => this.run()
    static run() => (this.disable_checker ? 0 : this.run_once(), SetTimer((*) => this.run(), Abs(this.check_freq_in_min) * -60000))
    static run_once() {
        try web := ComObject('WinHttp.WinHttpRequest.5.1'), web.Open('GET', 'https://www.autohotkey.com/download/2.0/version.txt'), web.Send(), ver := (web.StatusText() = 'OK') ? web.ResponseText() : 0, this.is_new_ver(A_AhkVersion, ver) ? this.run_updater(ver) : 0
    }
    static is_new_ver(sys, web) {
        web := StrSplit(web, '.'), sys := StrSplit(sys, '.'), iterations := (web.Length < sys.Length ? web.Length : sys.Length)
        loop iterations
            if (web[A_Index] > sys[A_Index])
                return 1
        return 0
    }
    static run_updater(ver) {
        if (MsgBox('A new version of AHK is available.`nWould you like to download it?:`nInstalled: ' A_AhkVersion '`nAvailable: ' ver, 'Install ' ver '?', 0x4) != 'Yes')
            return 0
        save := A_Desktop '\' (new_ahk := 'AutoHotkey_' ver '_setup.exe'), url := 'https://www.autohotkey.com/download/2.0/' new_ahk, Download(url, save), FileExist(save) ? (RunWait(save), WinWaitActive('AutoHotkey Dash ahk_exe AutoHotkeyUX.exe'), Run(A_AhkPath ' ' A_ScriptFullPath)) : TrayTip('Could not download file:`nurl: ' url '`nsave path: ' save, A_ScriptName)
    }
}
