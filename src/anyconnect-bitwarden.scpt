global ANY_CONNECT_CONFIRMATION_MARKER
global ANY_CONNECT_PATH
global BITWARDEN_PATH
global BITWARDEN_VPN_AUTH
global ANY_CONNECT_APP_NAME

-- User settings
set ANY_CONNECT_CONFIRMATION_MARKER to "https"
set ANY_CONNECT_PATH to "/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app"
set BITWARDEN_PATH to "/Applications/Bitwarden.app"
set BITWARDEN_VPN_AUTH to "VPN"

-- Script constants
set ANY_CONNECT_APP_NAME to "Cisco AnyConnect Secure Mobility Client"

-- Open app
on openApp(path)
    do shell script "open \"" & path & "\""
end openApp

-- Close active app
on closeApp()
    tell application "System Events" to keystroke "w" using command down
end closeApp

-- Open AnyConnect app
on openAnyConnect()
    openApp(ANY_CONNECT_PATH)
    delay 0.5
end openAnyConnect

-- Presses "Connect" button and waits for confirmation dialog
on connectVPN()
    tell application "System Events"
        keystroke return
    end tell
	repeat
		tell application "System Events"
			tell application process ANY_CONNECT_APP_NAME
				set anyConnectWindows to name of every window
			end tell
		end tell
		set isConfirmationExists to false
		repeat with windowName in anyConnectWindows
			if (windowName contains ANY_CONNECT_CONFIRMATION_MARKER) then
				set isConfirmationExists to true
				exit repeat
			end if
		end repeat
		if isConfirmationExists then
			exit repeat
		end if
		delay 0.1
	end repeat
end waitAnyConnectConfirmation

-- Fill authorization values to AnyConnect confirmation dialog
on authorizeVPN(authPassword, authTOTP)
    tell application "System Events" to keystroke authPassword
    delay 0.05
    tell application "System Events" to key code 48 -- Tab key
    delay 0.05
    tell application "System Events" to keystroke authTOTP
    delay 0.05
    tell application "System Events" to keystroke return
end authorizeVPN

-- Open Bitwarden app
on openBitwarden()
    openApp(BITWARDEN_PATH)
    delay 0.1
end openBitwarden

-- Find and select entry by search request
on openBitwardenEntry(request)
    tell application "System Events" to keystroke "f" using command down
    delay 0.1

    tell application "System Events" to keystroke request
    delay 0.1

    repeat 2 times
        tell application "System Events" to key code 48 -- Tab key
        delay 0.05
    end repeat

    tell application "System Events" to keystroke return
    delay 0.1
end openBitwardenEntry

-- Perform keystroke cmd + hotkey and return clipboard value
to getBitwardenClipboard(hotkey)
    tell application "System Events" to keystroke hotkey using command down
    delay 0.1
    set clipboardValue to the clipboard
    delay 0.1
    return clipboardValue
end getValueFromBitwarden

openAnyConnect()
connectVPN()

openBitwarden()
openBitwardenEntry(BITWARDEN_VPN_AUTH)
set authPassword to getBitwardenClipboard("p")
set authTOTP to getBitwardenClipboard("t")
closeApp()

openAnyConnect()
authorizeVPN(authPassword, authTOTP)
