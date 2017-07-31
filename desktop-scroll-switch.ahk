; "Back" button
~WheelDown::
  MouseGetPos ,,win_id
  if WinGetTitle("ahk_id " win_id) == "" {
    Send "^#{Left}"
  }
return

; "Forward" button
~WheelUp::
  MouseGetPos ,,win_id
  if WinGetTitle("ahk_id " win_id) == "" {
    Send "^#{Right}"
  }
return
