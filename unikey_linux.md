`https://www.reddit.com/r/Vietnamese/comments/1lz84ky/guide_for_using_unikey_on_linux_fcitx5/`

`sudo apt install fcitx5 fcitx5-configtool fcitx5-unikey`

Then Right-click on "Input Method" (Keyboard icon on the right of the Taskbar)

Choose "Configure"

In "Available Input Method", search for "unikey". Move it to the first column "Current Input Method" by pressing "Add" (left arrow icon)

Apply and Close.

Default Toggle is Ctrl+Space.

Using your distro's package manager, install fcitx5, fcitx5-gtk (ONLY ON GNOME) / fcitx5-qt (ONLY ON KDE), fcitx5-configtool, and fcitx5-unikey. Please make sure it is fcitx5 and not fcitx, as the latter is an older and unmaintaned version.

For GNOME, run this command to start fcitx5:

mkdir -p ~/.config/autostart && cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart

(Note: This comes from the fcitx5 wiki, but I have not personally tested it).

For KDE, go into Settings, then Keyboard, then Virtual Keyboard, and select Fcitx 5. Press Apply.

3. In your terminal, type fcitx5-configtool. This will launch the GUI for fcitx5. If you're on KDE, don't be alarmed if it opens in system settings, that is the correct GUI.

4. (Note: These next steps are specific to the KDE GUI, but they should be similar for GNOME). Select "Add Input Method". Search for "UniKey" and select "Add".

5. If you would like to change the input (Telex, VNI, VIQR, etc.), go into "Configure addons", search for UniKey and go into its options. Then you can change it from there.

6. Go into "Configure global options", and in the first box change the shortcut for turning on UniKey. The default is Ctrl + Space, which is what I use.

7. Press Apply. Now you should be able to enjoy typing in Vietnamese!
