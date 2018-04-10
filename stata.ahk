SetTitleMatchMode 1
active_id := WinGetID("A")

WinActivate "Stata"
WinWaitActive "Stata"
Send "do `"" A_Args[1] "`"{enter}"
Sleep 1000 

;WinActivate "ahk_id " active_id

Exit

;; Include in VSCode settings (change PATHTOTHISREPO below):
;; Then ctrl-alt-n on highlighted code (or whole file) runs in Stata.
; "code-runner.executorMapByFileExtension": {
;     // ".do": "\"C:\\Program Files (x86)\\Stata14\\StataSE-64.exe\" /e do"
;     ".do": "AutoHotkeyU64.exe C:\\PATHTOTHISREPO\\stata.ahk ",
;     ".ado": "AutoHotkeyU64.exe C:\\PATHTOTHISREPO\\stata.ahk "
; },
; "code-runner.showExecutionMessage": true,
; "code-runner.showRunCommandInEditorContextMenu": true,
; "code-runner.cwd": "C:\\Temp\\",
;;
;; Note: Stata needs newline before and after code. 
;; So select end of line above, and beginning of line
;; below to run a selection.
