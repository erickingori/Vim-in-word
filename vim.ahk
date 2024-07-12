; Initialize a variable vkMode to false (Meaning we start in Insert mode)
vkMode := false

; Toggle normal mode with "jk" (This is my main difference), i use jk to enter normal mode
~j:: ; Use tilde (~) to let key passthrough
; Wait for single key press within 0.3 seconds
    Input, SingleKey, L1 T0.3 
    if (SingleKey = "k") { ; If the next key is "k"
        vkMode := !vkMode ; Toggle vkMode
        ToolTip, % vkMode ? "Normal Mode" : "" ; Show tooltip for mode
        SetTimer, RemoveToolTip, -1000 ; Set timer to remove tooltip after 1 second
        return
    }
return

; Function to remove the tooltip
RemoveToolTip:
ToolTip
return

; Normal mode key mappings (active when vkMode is true)
#If vkMode
; Movement keys
j::Send, {Down} ; j moves down
k::Send, {Up} ; k moves up
h::Send, {Left} ; h moves left
l::Send, {Right} ; l moves right

; Enter Insert mode with i
i::
    vkMode := false ; Set vkMode to false (Insert mode)
    ToolTip, Insert Mode ; Show tooltip
    SetTimer, RemoveToolTip, -1000 ; Remove tooltip after 1 second
    return

; Enter Append mode with a (insert after the cursor)
a::
    vkMode := false ; Set vkMode to false (Insert mode)
    Send, {Right} ; Move cursor right
    ToolTip, Append Mode ; Show tooltip
    SetTimer, RemoveToolTip, -1000 ; Remove tooltip after 1 second
    return

; Backspace with x
x::Send, {BS}

; Delete with d
d::Send, {Del}

; Yank (copy) with y
y::Send, ^c

; Paste with p
p::Send, ^v

; Undo with u
u::Send, ^z

#If ; End of vkMode condition
