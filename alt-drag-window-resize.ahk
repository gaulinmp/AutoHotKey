; Depending on your preferences, you may want to raise or lower this value.
; Lower is smoother resize, higher is more 'jumpy'
SetWinDelay 100

CoordMode "Mouse", "Screen"

!LButton::
  ; Get the initial mouse position and window id
  MouseGetPos mouse_x1,mouse_y1,win_id

  ; Abort if maximized
  WinGetMinMax is_maxed,"ahk_id " win_id
  If is_maxed
    return

  ; Get the initial window position.
  WinGetPos win_x1,win_y1,,,"ahk_id " win_id

    ; While mouse is pressed down
  While GetKeyState("LButton", "P")
  {
    ; Get current mouse position.
    MouseGetPos mouse_x2,mouse_y2 ; Current mouse position.

    ; Move X and Y coordinate by difference between new and old mouse position
    WinMove( win_x1 + (mouse_x2 - mouse_x1)   ; X + offset
            ,win_y1 + (mouse_y2 - mouse_y1)   ; Y + offset
            ,,                                ; No width or height change
            ,"ahk_id " win_id)                ; Window ID
  }
return

!RButton::
  ; Get the initial mouse position and window id
  MouseGetPos mouse_x1,mouse_y1,win_id

  ; Abort if maximized.
  WinGetMinMax is_maxed,"ahk_id " win_id
  If is_maxed
      return

  ; Get the initial window position and size.
  WinGetPos win_x1,win_y1,win_w1,win_h1,"ahk_id " win_id

  ; Define the window region the mouse is currently in: Left half, and top half
  left_half := (mouse_x1 < win_x1 + win_w1 / 2)
  top_half  := (mouse_y1 < win_y1 + win_h1 / 2)

  ; While mouse is pressed down
  While GetKeyState("RButton", "P")
  {
    ; Get current mouse position.
    MouseGetPos mouse_x2,mouse_y2

    ; Resize window. X/Y only change if mouse is on left/top half respectively.
    ; Width/height decrease if mouse starts in left/top region respectively.
    WinMove( win_x1 + (mouse_x2 - mouse_x1)*left_half         ; X + offset if on left side
            ,win_y1 + (mouse_y2 - mouse_y1)*top_half          ; Y + offset if on top side
            ,win_w1 - (mouse_x2 - mouse_x1)*(2*left_half - 1) ; W - offset if left half, W + offset otherwise
            ,win_h1 - (mouse_y2 - mouse_y1)*(2*top_half  - 1) ; W - offset if top half,  H + offset otherwise
            ,"ahk_id " win_id)                                ; Window ID
  }
return
