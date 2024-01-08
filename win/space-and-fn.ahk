; 2022.03.07 autohotkey v1.1 script
; ChangeKey 
;   - CapsLock::F13

;#InstallKeybdHook true, true
#UseHook
#SingleInstance Force



global space_and_fn := 0.0
/*
*Space::{
  global space_and_fn := A_TickCount
}
*Space Up::{
  ds := A_TickCount - space_and_fn
  MsgBox(ds)
  if ds > 200 {
    MsgBox("%ds%")
    return
  }
  if GetKeyState("Alt") {
    SendInput "{vkF3sc029}"
  }
  else {
    SendInput "{Blind}{Space}"
  }
  return
}
*/


; AutoHotKey -> F13::Ctrl
F13::Ctrl

*Space::return
*Space Up::{
  if A_TimeSincePriorHotkey > 200 {
    return
  }

  if GetKeyState("Alt") {
    SendInput "{vkF3sc029}"
  }
  else {
    SendInput "{Blind}{Space}"
  }
  return
}

Space & s::Space

/*
fn_move_distance() {
  if GetKeyState("Alt") and GetKeyState("Ctrl") and GetKeyState("Shift")
    return 1
  if GetKeyState("Alt") and GetKeyState("Ctrl")
    return 5
  if GetKeyState("Alt") and GetKeyState("Shift")
    return 100
  if GetKeyState("Alt")
    return 25
  return 0
}

Space & h::{
  dis := fn_move_distance()
  if 0 < dis {
    MouseMove -dis,0,0,"R"
  }
  else{
    Send "{Blind}{Left}"
  }
  return
}
Space & j::{
  dis := fn_move_distance()
  if 0 < dis {
    MouseMove 0,dis,0,"R"
  }
  else{
    Send "{Blind}{Down}"
  }
  return
}
Space & k::{
  dis := fn_move_distance()
  if 0 < dis {
    MouseMove 0,-dis,0,"R"
  }
  else{
    Send "{Blind}{Up}"
  }
  return
}
Space & l::{
  dis := fn_move_distance()
  if 0 < dis {
    MouseMove dis, 0,0,"R"
  }
  else{
    Send "{Blind}{Right}"
  }
  return
}
*/

Space & m::Enter
Space & n::BackSpace
Space & d::Del
Space & y::SendInput "^{Insert}"
Space & p::SendInput "+{Insert}"
Space & u::SendInput "^{z}"
Space & r::SendInput "^{y}"
Space & [::Esc
Space & f::PgDn
Space & b::PgUp
Space & <::Home
Space & >::End
Space & 1::F1
Space & 2::F2
Space & 3::F3
Space & 4::F4
Space & 5::F5
Space & 6::F6
Space & 7::F7
Space & 8::F8
Space & 9::F9
Space & 0::F10

{
	global space_and_fn := false

	#inputlevel 2
	$Space::{
	    SetMouseDelay -1
	    Send "{Blind}{F15 DownR}"
	    KeyWait "Space"
	    Send "{Blind}{F15 up}"
	    ; MsgBox, %A_ThisHotkey%-%A_TimeSinceThisHotkey%
	    if(A_ThisHotkey="$Space" and A_TimeSinceThisHotkey<300)
	        Send "{Blind}{Space DownR}"
	    return
	}
	#inputlevel 1

	F15 & s::Space
}
	Space::{
		Send "{Blind}{F15 down}"
		global space_and_fn := true
		return
	}
	Space up::{
		Send "{Blind}{F15 up}"
		global space_and_fn := false
		return
	}

	F15 & s::Space

	#HotIf space_and_fn
	s::Space
}

{
	global three_fingers_dragging := false

	+^#F22::{
	  if (three_fingers_dragging)
	    Click "up"
	  else
	    Click "down"
	  global three_fingers_dragging := !three_fingers_dragging
	  return
	}

	#HotIf three_fingers_dragging
	LButton::{
	  Click "up"
	  global three_fingers_dragging := false
	  return
	}
}


