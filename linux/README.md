# Arfan's Linux configuration.

## Fonts
1. Download any [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts).
2. Move the folder to `/usr/share/fonts` for the system or `~/.local/share/fonts` for the user only.
3. Install font `JoyPixels` from your package manager for emoji support.
4. Refresh the font cache.

```
fc-cache -vf
```

Extras:
1. `ttf-vlgothic` for Japanese characters.
2. `ttf-baekmuk` for Korean characters.
3. `noto-fonts-cjk` for Chinese, Japanese and Korean characters combined.
4. `noto-fonts` for some Latin characters.
5. `awesome-terminal-fonts` for some more icons.

## X Terminal
1. Install `xterm`.
2. Copy .Xresources file into the `$HOME` directory.

## VIM
1. Install `vim`.
2. Copy `.vimrc` file into `$HOME` directory.

## Display Power Management Signaling

> In case you're not using a desktop environment, you're most likely had Xorg [DPMS](https://wiki.archlinux.org/title/Display_Power_Management_Signaling) default settings (if you're using X11) and there is no GUI settings for it. Paste the script below into `/etc/X11/xorg.conf.d/10-monitor.conf` (need root permission), and change the values accordingly.

```
Section "Monitor"
	Identifier "LVDS0"
	Option "DPMS" "false"
EndSection

Section "ServerFlags"
	Option "StandbyTime" "0"
  Option "SuspendTime" "0"
  Option "OffTime" "0"
  Option "BlankTime" "0"
EndSection

Section "ServerLayout"
	Identifier "ServerLayout0"
EndSection
```

## Touchpad

> If you're using a window manager on a laptop, your touchpad might don't have tap-to-click and the two finger scrolling isn't natural (e.g: swipe up to scroll up instead of swipe up to scroll down and vice versa). Paste the script below into `/etc/X11/xorg.conf.d/40-libinput.conf`.
*Make sure `xf86-input-libinput is installed`*

```
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
		Option "Tapping" "on"
		Option "NaturalScrolling" "true"
EndSection
```

## Additionals
Additional applications to install on Linux depending on which distro you're using.

- alsa *(soundcard driver)*
- alsa-utils *(alsa's command-line utilizer/controller)*
- [apt-transport-https](https://manpages.ubuntu.com/manpages/bionic/man1/apt-transport-https.1.html) *(if you're on Debian distro)*
- autojump *(change directory with fewer keystroke)*
- betterlockscreen *(minimal and fast lock screen)*
- curl *(to transfer data to/from a web server)*
- dhcpd *(allows you to be in the internet highway with a plate number (IP))*
- eww *(for customizable widgets and menus in window manager)*
- feh *(minimal terminal image viewer and background setter)*
- fuse2 *(to mount/modify/format securely a virtual filsesystem)*
- fzf *(to find file you want with just keywords you remember)*
- gnupg *(encryption for your data and communications)*
- htop *(command-line task manager)*
- imagemagick *(terminal based simple image manipulator and viewer)*
- [iwctl](https://wiki.archlinux.org/title/iwd) *(in case your distro does not support your wifi card)*
- lightdm *(lightweight display manager)*
- [lf](https://github.com/gokcehan/lf) *(faster file manager than ranger)*
- [ly](https://github.com/fairyglade/ly) *(nerdy minimal display manager)*
- nemo *(a fork of Nautilus GUI file manager)*
- neofetch *(Linux ricer's fav command to show off their distro especially Arch user. I use Arch btw...)*
- ntfs-3g *(to be able to read/write ntfs file system)*
- pacman-contrib *(for shell usage to see available updates, i.e: polybar)*
- parted *(partition manipulation program)*
- perl-image-exiftool *(music/image exif previewer)*
- pipewire *(multimedia handler)*
- polybar *(easy to configure status bar)*
- pulse-pipewire *(for easier transition using pulseaudio tools with pipewire)*
- ranger *(terminal file explorer)*
- rofi-emoji *(emoji selection plugin in rofi)*
- rofi-greenclip *(clipboard manager plugin in rofi)*
- starship *(cross-platform terminal prompt customizer)*
- sxhkd *(for bspwm keybinding)*
- sxiv *(less bloated image viewer)*
- [the-silver-searcher](https://archlinux.org/packages/community/x86_64/the_silver_searcher/) *(alternative to fzf default command)*
- timeshift *(if you bricked your Linux system, you can always rollback to your last system backup)*
- ueberzug *(if w3m doesn't work (need to change the default image preview [ranger config](https://wiki.archlinux.org/title/ranger#Configuration))*
- unzip *(simple unzipper .zip files)*
- w3m *(optional to have image preview in ranger)*
- xclip *(needed for clipboard on non DE)*
- youtube-dl *(download youtube videos)*
- zathura *(vim-like minimal pdf viewer)*
- zathura-pdf-poppler *(in case zathura needs support)*
- zip *(simple zipper .zip files)*
