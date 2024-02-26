# AnyConnect Bitwarden Automation

This is a script (AppleScript) that automates password and TOTP authorisation in the Cisco AnyConnect Secure Mobility Client.

## Requirements

- macOS
- Bitwarden Desktop app
- Cisco AnyConnect Secure Mobility Client app

## Preparation

The following constants are used in the [script](src/anyconnect-bitwarden.scpt) and should be modified:

- `ANY_CONNECT_CONFIRMATION_MARKER` is a string that is used to find the AnyConnect Secure Mobility Client window. It is set to "https" as the URL of the VPN server starts with it.
- `ANY_CONNECT_PATH` is the full path to the AnyConnect Secure Mobility Client app. Most likely your path will be the same, but double-check it.
- `BITWARDEN_PATH` is the full path to the Bitwarden Desktop app. The path is also most likely the same.
- `BITWARDEN_VPN_AUTH` is the query, that will be passed to Bitwarden app. The query must be such that after entering it into the search, the entry with the VPN profile is the first in the list.

## Installation

After filling in the required values, you can install the script in two ways. Regardless of the method you choose, when you will first run script, the system will ask you. for permission to input from the application. This permission is required for the script to work.

### Terminal

In the terminal with the project folder, execute the commands. To execute second command, you will have to enter the superuser password

```sh
make build
make install 
```

### Shortcuts

The "app" thus created can be launched from Spotlight, Dock, application list and hotkeys.

1. Open Shortcuts.app
2. Create new shortcut. You can specify a name after creation in the window title bar.
3. Find and double-click "Run AppleScript"
4. Copy the content of [the script](src/anyconnect-bitwarden.scpt) you have edited into the field that appears.
5. Press build (hummer) button.
6. Close shortcut window.
7. In the main Shortcuts.app window, find the Shortcut you created in the list and right-click it.
8. Select "Add to Dock"

After these steps, the created "app" will be displayed in the dock. The file will be located in the `/Users/$USER/Applications` folder 
