SetTitleMatchMode 1
active_id := WinGetID("A")

Clipboard := "`%INCLUDE `"" A_Args[1] "`";"

Sleep 500
WinActivate "SAS"
WinWaitActive "SAS"
Send "{F3}"

Sleep 1000

; Uncomment to switch back to VS Code
;WinActivate "ahk_id " active_id

Exit

;; Include in VSCode settings (change PATHTOTHISREPO below):
;; Then ctrl-alt-n on highlighted code (or whole file) runs in SAS.
; "code-runner.executorMapByFileExtension": {
;     ".sas": "AutoHotkeyU64.exe C:\\PATHTOTHISREPO\\sas.ahk "
; },
; "code-runner.showExecutionMessage": true,
; "code-runner.showRunCommandInEditorContextMenu": true,
; "code-runner.cwd": "C:\\Temp\\",
;
;; You also must include in the SAS keys file (Tools --> Options --> Keys)
; F3   gsubmit buffer=default;
;; You can change F3 to be whatever, just reflect that change above in: Send "{KEY YOU CHANGE HERE}"
