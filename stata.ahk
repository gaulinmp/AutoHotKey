SetTitleMatchMode 1
active_id := WinGetID("A")

WinActivate "Stata"
WinWaitActive "Stata"
Send "do `"" A_Args[1] "`"{enter}"
Sleep 1000 

;WinActivate "ahk_id " active_id

Exit
