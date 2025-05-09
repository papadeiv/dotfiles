# KDE Plasma Desktop Environment 

## Kvantum
Install the `kvantum` theme engine and the `?`... 
```bahs
sudo yay -S kvantum 
```

## Configuration
1. Shortcuts
```bash
System Settings > Keyboard > Shortcuts > Applications
```
  - Dolphin
    - Launch: `Meta + E`
    - Toggle Side Bar: `F9` (default)
    - Open New Tab: `Ctrl + T` (default)
    - Walk Through Tabs: `Ctrl + Shift + Tab` (default)

```bash
System Settings > Keyboard > Shortcuts > System Services 
```
  - KWin 
    - Maxe Window Fullscreen: `Meta + Up`
    - Minimize Window: `Meta + Down`
    - Peek at Desktop: `Meta + D`
    - Walk Through Windows: `Alt + Tab`
    - Walk Through Windows (Reverse): `Alt + Shift + Tab`

```bash
System Settings > Keyboard > Shortcuts > Add New > Kitty 
```
  - Kitty
    - Launch: `Ctrl + Alt + T`
    - Open a New Tab: `Ctrl + Shift + T` 
    - Walk Though Tabs: `Ctrl + Shift + Right` and `Ctrl + Shift + Left`

```bash
System Settings > Keyboard > Shortcuts > Add New > Rofi 
```
  - Rofi 
    - Launch: `Alt + Space`

2. Color themes 
  - Kvantum
    - Download the [Utterly Nord Solid for Plasma 6](https://store.kde.org/p/2135623/) theme
    - Extract the zipped content in `~/.config`
    - Launch the Kvantum manager 
    - Install/Update Theme
      - Select a Kvantum Theme folder > `~/.config/Utterly-Nord` > Install this theme
    - Change/Delete Theme
      - Select a theme > Utterly-Nord
    - System Settings
```bash
System Settings > Global Theme > Get New > Utterly Nord for Plasma 6 by himdek 
System Settings > Colors > Get New > Utterly Nord (autoinstalled from previous step) 
System Settings > Application Style > kvantum-dark 
System Settings > Plasma Style > Get New > Utterly Round (autoinstalled from previous step) 
System Settings > Window Decorations > Utterly Round Dark (autoinstalled from previous step) > Edit Theme (stencil icon on bottom right corner) > Button size: Very Large 
System Settings > Icons > Get New > Tela Circle Dark or Zafiro Nord Dark by zayronXIO or Buuf-Plasma 
System Settings > Cursors > Get New > Nordic-cursors 
System Settings > System Sounds > Get New > Ocean 
System Settings > Splash Screen > Get New > Utterly Nord 
System Settings > Login Screen > Get New > Nordic 
```

3. Text fonts
```bash
System Settings > Text & Fonts > Fonts > Adjust All Fonts > Font: GeistMono Nerd Font Mono > Font style: Medium > Size: 10.75
```

4. Default Applications  
```bash
System Settings > Default Applications > Image viewer: 
System Settings > Default Applications > Music player: 
System Settings > Default Applications > Video player: VLC 
System Settings > Default Applications > Text editor: Kate 
System Settings > Default Applications > PDF viewer: 
System Settings > Default Applications > File manager: Dolphin 
System Settings > Default Applications > Terminal emulator: kitty 
```

5. Window Management
```bash
System Settings > Window Management > Task Switcher > Visualization > Large icons
System Settings > Window Management > Desktop Effects > Hide Cursor > Tick 
System Settings > Window Management > Desktop Effects > Background Contrast > Tick 
System Settings > Window Management > Desktop Effects > Blur > Tick > Click on gear icon to change noise and blur strength (both of them on 5th to last tick) 
System Settings > Window Management > Desktop Effects > Translucency > Tick 
System Settings > Window Management > Desktop Effects > Magic Lamp > Tick > Configure > 350 milliseconds 
System Settings > Window Management > Window Rules > Application settings for systemsettins > Edit (pencil icon) > Match whole window class: Yes, Window types: All selected  
System Settings > Window Management > Window Rules > Window settings for systemsettins > Edit (pencil icon) > Match whole window class: Yes, Window types: All selected  
```

6. Task manager (bottom bar)
```bash
Left click on bar > Show Panel Configuration > Position: Right > Alignment: Center > Height: Fit Content > Visibility: Auto Hide > Opacity: Translucent > Style: Floating > Panel Width: 74 
Left click on bar > Show Panel Configuration > Hoover over System Tray > Remove
```

7. Status bar (top bar)
```bash
Left click on left bar (Task manager) > Show Panel Configuration > Add Panel > Application Menu Bar > Exit Edit Mode 
Left click on top bar (Status bar) > Add or Manage Widgets > System Tray, Trashcan, Digital Clock > Exit Edit Mode  
Left click on top bar > Show Panel Configuration > Panel Settings > Add Spacer > Right clik on System Tray, Trashcan and Digital Clock and drag them to the RHS of the Spacer > Leave Global Menu on the LHS 
Left click on top bar > Show Panel Configuration > Panel Settings > Add Spacer > Place the spacer between the Clock and the Trashcan + Tray block so that the Clock now sits in the middle of the status bar 
Left click on top bar > Show Panel Configuration > Panel Settings > Add Spacer > Place the spacer on the RHS of the Tray and untogle Flexible Size > Spacer Width: 10  
Left click on top bar > Show Panel Configuration > Panel Settings > Visibility: Dodge windows, Opacity: Translucent, Panel Height: 34 
```

8. File manager (Dolphin)
```bash
Left click on Toolbar > Configure Toolbars > Current actions: Back, Forward, Open Menu, Location Bar, Split, Search
Right click on Open Menu icon > Configure > Configure Dolphin > Interface > Folders & Tabs > Show on startup: /home/papadeiv
Right click on Open Menu icon > Configure > Configure Dolphin > Interface > Status & Location bars > Status Bar: Show status bar (tick), Location Bar: Show full path inside location bar (tick) 
Right click on Open Menu icon > Configure > Configure Dolphin > View > Icons > Default icon size: 32 pixels, Preview icon size: 64 pixels 
Right click on Open Menu icon > Configure > Configure Keyboard Shortcuts > Close Tab > Custom > Ctrl + W 
```

9. Miscellanea 
```bash
System Settings > General Behaviour > Clicking files or folders > Opens them 
System Settings > Screen Locking > Lock screen automatically > Never 
System Settings > Screen Locking > Keyboard shortuct > Meta + L 
System Settings > Power Management > On AC Power > When inactive: Do nothing, Dim automatically: Never, Turn off screne: Never 
System Settings > Power Management > On Battery > When inactive: Do nothing, Dim automatically: Never, Turn off screne: Never 
System Settings > Power Management > On Low Battery > When inactive: Do nothing, Dim automatically: Never, Turn off screne: Never 
Google Chrome > Left click on menu bar > Use system title bar and borders 
Google Chrome > Left click on title bar > More Actions > Configure Special Application Settings > Add Property > Titlebar color scheme: Utterly-Nord, Active opacity: 92%, Inctive opacity: 92%
```
