; Depending on your preferences, you may want to raise or lower this value.
; Lower is smoother resize, higher is more 'jumpy'
SetWinDelay 100

CoordMode "Mouse", "Screen"

WINROTATE := 0

!LButton::
{
  ; Get the initial mouse position and window id
  MouseGetPos &mouse_x1,&mouse_y1,&win_id

  ; Abort if maximized
  is_maxed := WinGetMinMax("ahk_id " win_id)
  If is_maxed
    return

  ; Get the initial window position.
  WinGetPos &win_x1,&win_y1,,,"ahk_id " win_id

    ; While mouse is pressed down
  While GetKeyState("LButton", "P")
  {
    ; Get current mouse position.
    MouseGetPos &mouse_x2, &mouse_y2 ; Current mouse position.

    ; Move X and Y coordinate by difference between new and old mouse position
    WinMove( win_x1 + (mouse_x2 - mouse_x1)   ; X + offset
            ,win_y1 + (mouse_y2 - mouse_y1)   ; Y + offset
            ,,                                ; No width or height change
            ,"ahk_id " win_id)                ; Window ID
  }
}


!RButton::
{
  ; Get the initial mouse position and window id
  MouseGetPos &mouse_x1,&mouse_y1,&win_id

  ; Abort if maximized
  is_maxed := WinGetMinMax("ahk_id " win_id)
  If is_maxed
    return

  ; Get the initial window position and size.
  WinGetPos &win_x1, &win_y1, &win_w1, &win_h1,"ahk_id " win_id

  ; Define the window region the mouse is currently in: Left half, and top half
  left_half := (mouse_x1 < win_x1 + win_w1 / 2)
  top_half  := (mouse_y1 < win_y1 + win_h1 / 2)

  ; While mouse is pressed down
  While GetKeyState("RButton", "P")
  {
    ; Get current mouse position.
    MouseGetPos &mouse_x2, &mouse_y2

    ; Resize window. X/Y only change if mouse is on left/top half respectively.
    ; Width/height decrease if mouse starts in left/top region respectively.
    WinMove( win_x1 + (mouse_x2 - mouse_x1)*left_half         ; X + offset if on left side
            ,win_y1 + (mouse_y2 - mouse_y1)*top_half          ; Y + offset if on top side
            ,win_w1 - (mouse_x2 - mouse_x1)*(2*left_half - 1) ; W - offset if left half, W + offset otherwise
            ,win_h1 - (mouse_y2 - mouse_y1)*(2*top_half  - 1) ; W - offset if top half,  H + offset otherwise
            ,"ahk_id " win_id)                                ; Window ID
  }
}


; 888       888 d8b               888                             8888888b.                   d8b 888    d8b
; 888   o   888 Y8P               888                             888   Y88b                  Y8P 888    Y8P
; 888  d8b  888                   888                             888    888                      888
; 888 d888b 888 888 88888b.   .d88888  .d88b.  888  888  888      888   d88P .d88b.  .d8888b  888 888888 888  .d88b.  88888b.
; 888d88888b888 888 888 "88b d88" 888 d88""88b 888  888  888      8888888P" d88""88b 88K      888 888    888 d88""88b 888 "88b
; 88888P Y88888 888 888  888 888  888 888  888 888  888  888      888       888  888 "Y8888b. 888 888    888 888  888 888  888
; 8888P   Y8888 888 888  888 Y88b 888 Y88..88P Y88b 888 d88P      888       Y88..88P      X88 888 Y88b.  888 Y88..88P 888  888
; 888P     Y888 888 888  888  "Y88888  "Y88P"   "Y8888888P"       888        "Y88P"   88888P' 888  "Y888 888  "Y88P"  888  888

getWinStats() {
  global WINROTATE

  ; Get the initial mouse position and window id
  active_id := WinGetID("A")

  ; Get the initial window position and size.
  WinGetPos &win_x, &win_y, &win_w, &win_h, "ahk_id " active_id
  center_x := win_x + win_w / 2
  center_y := win_y + win_h / 2


  MonitorCount := MonitorGetCount()
  MonitorPrimary := MonitorGetPrimary()
  Loop MonitorCount
  {
    MonitorGet A_Index, &mon_left, &mon_top, &mon_right, &mon_bottom
    mon_num := A_Index
    if ((center_x > mon_left) & (center_x < mon_right) &
        (center_y > mon_top) & (center_y < mon_bottom) )
        break
  }

  MonitorGetWorkArea mon_num, &mon_left, &mon_top, &mon_right, &mon_bottom
  ret := {}
  ret.mon_num := mon_num
  ret.mon_left := mon_left
  ret.mon_top := mon_top
  ret.mon_right := mon_right
  ret.mon_bottom := mon_bottom
  ret.mon_width := mon_right - mon_left
  ret.mon_height := mon_bottom - mon_top
  ret.active_id := active_id
  ret.win_x := win_x
  ret.win_y := win_y
  ret.win_w := win_w
  ret.win_h := win_h
  ret.w_pct := win_w / ret.mon_width
  ret.h_pct := win_h / ret.mon_height

  ret.pct_width := (WINROTATE+3)/10
  WINROTATE := Mod(WINROTATE + 1, 8)

  return ret
}

; 1 is bottom left, half height
#1::
#Numpad1::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_left
  new_height := win.mon_height / 2
  new_y := win.mon_top + new_height

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}

; 2 is bottom, alternate between half and 66%
#2::
#Numpad2::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_left + (win.mon_width - new_width)/2
  new_height := win.mon_height / 2
  new_y := win.mon_top + new_height

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}

; 3 is bottom right, half height
#3::
#Numpad3::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_right - new_width
  new_height := win.mon_height / 2
  new_y := win.mon_top + new_height

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}

; 4 is full left side, alternate between 25% & 33%
#4::
#Numpad4::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_left
  new_height := win.mon_height
  new_y := win.mon_top

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}

; 5 Is middle full height, alternate between 50% & 66%
#5::
#Numpad5::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_left + (win.mon_width - new_width)/2
  new_height := win.mon_height
  new_y := win.mon_top

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}


; 6 is full right side, alternate between 25% & 33%
#6::
#Numpad6::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_right - new_width
  new_height := win.mon_height
  new_y := win.mon_top

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}


; 7 is top left, half height
#7::
#Numpad7::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_left
  new_height := win.mon_height / 2
  new_y := win.mon_top

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}

; 8 is top, alternate between half and 66%
#8::
#Numpad8::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_left + (win.mon_width - new_width)/2
  new_height := win.mon_height / 2
  new_y := win.mon_top

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}

; 9 is bottom right, half height
#9::
#Numpad9::
{
  ; Get window stats from above
  win := getWinStats()

  new_width := Round(win.pct_width*win.mon_width)
  new_x := win.mon_right - new_width
  new_height := win.mon_height / 2
  new_y := win.mon_top

  WinMove( new_x, new_y, new_width, new_height, "ahk_id " win.active_id)
}


; 9 is bottom right, half height
;#Numpad0::
;  Send "`t`t`t`t{Space}"
;return
