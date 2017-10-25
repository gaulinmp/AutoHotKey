desktop_win_id := -1

; "Back" button
~WheelDown::
  MouseGetPos ,,win_id
  winname := WinGetTitle("ahk_id " win_id)
  if (desktop_win_id == win_id) | ((desktop_win_id < 0) & (winname == "")) {
    Send "^#{Left}"
  }
  sleep 200
return

; "Forward" button
~WheelUp::
  MouseGetPos ,,win_id
  winname := WinGetTitle("ahk_id " win_id)
  if (desktop_win_id == win_id) | ((desktop_win_id < 0) & (winname == "")) {
    Send "^#{Right}"
  }
  sleep 200
return

~!^MButton::
  MouseGetPos ,,win_id
  desktop_win_id := win_id
return
