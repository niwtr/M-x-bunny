#!/bin/zsh
osascript -e "
set open_window_p to true
if application \"iTerm\" is not running then
	do shell script \"open -a iterm\"
	set open_window_p to false
end if
tell application \"iTerm\"
	if open_window_p then
		set newWindow to (create window with default profile)
		tell current session of newWindow
			write text \"$1\"
		end tell
	else
  tell current session of current window
		write text \"$1\"
  end tell
	end if
end tell
"
