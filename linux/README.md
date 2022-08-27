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

- [apt-transport-https](https://manpages.ubuntu.com/manpages/bionic/man1/apt-transport-https.1.html) *(if you're on Debian distro)*
- [preload](https://wiki.archlinux.org/title/Preload)
- [the-silver-searcher](https://archlinux.org/packages/community/x86_64/the_silver_searcher/) *(alternative to fzf default command)*
- alsa *(soundcard driver)*
- alsa-utils *(alsa's command-line utilizer/controller)*
- autojump
- curl *(some distros don't have it pre-installed)*
- feh *(minimal terminal image viewer and background setter)*
- fzf
- gnupg
- htop
- neofetch *(Linux ricer's fav command)*
- pipewire
- pulse-pipewire *(for easier transition using pulseaudio tools with pipewire)*
- ranger *(terminal file explorer)*
- sxiv *(less bloated image viewer)*
- ueberzug *(in case w3m doesn't work (need to change the default image preview [ranger config](https://wiki.archlinux.org/title/ranger#Configuration) a bit)*
- w3m *(needed to have image preview in ranger)*
- xclip *(needed for clipboard on non DE)*
