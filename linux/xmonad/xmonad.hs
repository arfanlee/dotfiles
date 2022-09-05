-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.

-- Base
import XMonad
import qualified XMonad.StackSet as W

-- Data
import Data.Monoid
import Data.Maybe(fromJust)
import qualified Data.Map as M

-- System
import System.Exit
import Graphics.X11.ExtraTypes.XF86

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks(avoidStruts)

-- Layout
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier(ModifiedLayout)
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowNavigation
import XMonad.Layout.SubLayouts
import XMonad.Layout.Simplest
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.Spiral

import XMonad.Util.SpawnOnce
import XMonad.Util.Run
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "st"
myBrowser = "firefox"
myScrot = "scrot ~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"
soundPlayer = "ffplay -nodisp -autoexit"
shutterSound = " /opt/sys-sounds/cam-shutter.wav"

-- To get number of windows in current workspace
windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Gaps between windows

-- No gaps for a single windows
myWindowGaps = 3    :: Integer
mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing i = spacingRaw False(Border i i i i) True (Border i i i i) True

full = renamed [Replace "Full"]
	$ smartBorders
    $ mySpacing myWindowGaps
	$ windowNavigation
    $ Full
grid = renamed [Replace "Grid"]
	$ limitWindows 9
	$ smartBorders
	$ windowNavigation
	$ subLayout [] (smartBorders Simplest)
	$ mySpacing myWindowGaps
	$ mkToggle (single MIRROR)
	$ Grid (16/10)
spirals  = renamed [Replace "Spirals"]
	$ limitWindows 9
	$ smartBorders
	$ windowNavigation
	$ subLayout [] (smartBorders Simplest)
	$ mySpacing myWindowGaps
	$ spiral (6/7)
tall = renamed [Replace "Tall"]
	$ smartBorders
    $ mySpacing myWindowGaps
    $ ResizableTall 1 (3/100) (1/2) []
wide = renamed [Replace "Wide"]
	$ smartBorders
    $ mySpacing myWindowGaps
    $ Mirror (Tall 1 (3/100) (1/2))

myLayoutHook =
    avoidStruts myDefaultLayout
    where
        myDefaultLayout = full 
			||| grid
			||| spirals
            ||| tall
            ||| wide

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#1F1F28"
myFocusedBorderColor = "#739CD8"

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf),

	-- launch web browser
    ((modm, xK_b), spawn "firefox"),

	-- screenshot
    ((modm, xK_Print), spawn (myScrot ++ " && " ++ soundPlayer ++ shutterSound)),
    
    -- volume keys
    ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%"),
    ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%"),

    -- launch dmenu
    ((modm, xK_p), spawn "rofi -show drun"),

    -- launch greenclip
    ((modm, xK_g), spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'"),

    -- close focused window
    ((modm, xK_q), kill),

     -- Rotate through the available layout algorithms
    ((modm, xK_space), sendMessage NextLayout),

    --  Reset the layouts on the current workspace to default
    ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),

    -- Resize viewed windows to the correct size
    ((modm, xK_n), refresh),

    -- Move focus to the next window
    ((modm, xK_Tab), windows W.focusDown),

    -- Move focus to the next window
    ((modm, xK_j), windows W.focusDown),

    -- Move focus to the previous window
    ((modm, xK_k), windows W.focusUp),

    -- Move focus to the master window
    ((modm, xK_m), windows W.focusMaster),

    -- Swap the focused window and the master window
    ((modm .|. controlMask, xK_Return), windows W.swapMaster),

    -- Swap the focused window with the next window
    ((modm .|. shiftMask, xK_j), windows W.swapDown),

    -- Swap the focused window with the previous window
    ((modm .|. shiftMask, xK_k), windows W.swapUp),

    -- Shrink the master area
    ((modm, xK_h), sendMessage Shrink),

    -- Expand the master area
    ((modm, xK_l), sendMessage Expand),

    -- Push window back into tiling
    ((modm, xK_t), withFocused $ windows . W.sink),

    -- Increment the number of windows in the master area
    ((modm , xK_comma ), sendMessage (IncMasterN 1)),

    -- Deincrement the number of windows in the master area
    ((modm , xK_period), sendMessage (IncMasterN (-1))),

    -- Quit xmonad
    ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)),

    -- Restart xmonad
    ((modm .|. controlMask, xK_r), spawn "xmonad --restart"),

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N

    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3

    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster)),

    -- mod-button2, Raise the window to the top of the stack
    ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),

    -- mod-button3, Set the window to floating mode and resize by dragging
    ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
	[title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 ),
     className =? "MPlayer"        --> doFloat,
     className =? "Gimp"           --> doFloat,
     resource  =? "desktop_window" --> doIgnore,
     resource  =? "kdesktop"       --> doIgnore]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
	spawnOnce "$HOME/.fehbg &"  -- set last saved feh wallpaper
	spawnOnce "greenclip daemon"

------------------------------------------------------------------------
-- Command to launch the bar.
myBar = "xmobar $HOME/.config/xmonad/xmobarrc"
-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP {ppCurrent = xmobarColor "#7E9CD8" "" . wrap
                      ("<box type=Bottom width=2 mb=2 color=#7E9CD8>") "</box>",
				 ppVisible = xmobarColor "#1F1F28" "",-- need to set in xmobar
				 ppUrgent = xmobarColor "#C34043" "",
				 ppExtras  = [windowCount]
				}

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask .|. shiftMask, xK_b)

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
    xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'super key'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch terminal",
    "mod-p            Launch rofi",
    "mod-q            Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-Control-r        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
