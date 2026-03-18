# Coffee

A minimal macOS status bar app that prevents your system from sleeping.

## Features

- Lives in the menu bar — no Dock icon
- Toggle caffeination on/off with one click
- Optional: prevent disk sleep as well
- Auto-stops `caffeinate` if the app crashes (`-w PID`)

## Requirements

- macOS 13+
- Xcode command-line tools (`xcode-select --install`)

## Build & Run

```sh
./build.sh         # debug build
./build.sh release # optimized build
open Coffee.app
```

## How it works

Wraps macOS's built-in `caffeinate` command. Always passes `-i` (prevent idle sleep), with optional `-d` (display) and `-m` (disk) flags based on your settings. The process exits cleanly when the app quits or crashes.
