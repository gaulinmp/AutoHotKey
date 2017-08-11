desktop_win_id := -1

; "Back" button
~WheelDown::
  MouseGetPos ,,win_id
  winname := WinGetTitle("ahk_id " win_id)
  if (desktop_win_id == win_id) | ((desktop_win_id < 0) & (winname == "")) {
    Send "^#{Left}"
  }
return

; "Forward" button
~WheelUp::
  MouseGetPos ,,win_id
  winname := WinGetTitle("ahk_id " win_id)
  if (desktop_win_id == win_id) | ((desktop_win_id < 0) & (winname == "")) {
    Send "^#{Right}"
  }
return

~!^MButton::
  MouseGetPos ,,win_id
  desktop_win_id := win_id
return