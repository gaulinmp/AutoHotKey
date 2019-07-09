# AutoHotKey2 scripts

Some convenient Auto Hot Key scripts I've assembled/written for making Windows a little easier to use.
Credit due to original sources cited in comments.

AHK Documentation: [https://lexikos.github.io/v2/docs/AutoHotkey.htm](https://lexikos.github.io/v2/docs/AutoHotkey.htm)


## Install

AHK Installation (get latest version): [https://www.autohotkey.com/download/2.0/](https://www.autohotkey.com/download/2.0/)

Clone repo to a semi-permenant location, and make sure AutoHotkey is in your path.

Run [open_startup_folder.bat](https://github.com/gaulinmp/AutoHotKey/blob/master/open_startup_folder.bat) 
  and create a shortcut to [start.bat](https://github.com/gaulinmp/AutoHotKey/blob/master/start.bat)
  in this folder (right click drag into Startup folder).
If you have other scripts you want to run, just add them to `start.bat`.

An alternative method would be copy all the scripts into one big `.ahk` file.

# SAS / Stata runner for VS Code

If you use VS Code to edit SAS/Stata programs, the two scripts herein allow for running code directly from VSCode.
This uses [Code Runner](https://github.com/formulahendry/vscode-code-runner) extension, so install that extension too.

## Setup

In your [`settings.json`](https://code.visualstudio.com/docs/getstarted/settings) file, add the following (note the escaped quotes around the .ahk full-paths):

```json
"code-runner.executorMapByFileExtension": {
        ".do": "AutoHotkeyU64.exe \"C:/[PATH TO THIS REPO]/stata.ahk\"",
        ".ado": "AutoHotkeyU64.exe \"C:/[PATH TO THIS REPO]/stata.ahk\"",
        ".sas": "AutoHotkeyU64.exe \"C:/[PATH TO THIS REPO]/sas.ahk\""
    }
```

To get SAS working, you have one more step.
Open SAS, and edit your Keys file (Tools --> Options --> Keys).
Add the following to your Keys file for F3: `gsubmit buffer=default;`
You can add it to any key command, just make sure to change `sas.ahk` as well to reflect the key you choose (change the `Send "{F3}"` line).
