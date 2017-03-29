import XMonad
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.NoBorders
import XMonad.Actions.CopyWindow
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks, docksEventHook)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Minimize
import XMonad.Layout.Spiral
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP)
import System.Directory (getHomeDirectory)
import System.IO (hPutStrLn)

main = do
    homeDir <- getHomeDirectory
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh defaultConfig {
        handleEventHook = mconcat [ docksEventHook, handleEventHook defaultConfig] <+> fullscreenEventHook,
        modMask = mod4Mask,
        terminal = "urxvt",
        workspaces = ["一", "二", "三", "四", "五", "六", "七", "八","九"],
        logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "#CCCCCC" "" . shorten 100,
            ppCurrent = xmobarColor "#4A7781" ""
        },
        layoutHook = avoidStruts $ minimize $ spiral (0.675) ||| noBorders (fullscreenFull Full) ||| layoutHook defaultConfig,
        manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll myManageHook
    } `additionalKeysP` (myKeys homeDir)

myKeys :: FilePath -> [(String, X())]
myKeys homeDir = [
    -- Volume control
    ("<XF86AudioMute>", spawn "amixer sset 'Master' toggle -q"),
    ("<XF86AudioMicMute>", spawn "amixer sset 'Capture' toggle -q"),
    ("<XF86AudioLowerVolume>", spawn "amixer sset 'Master' 3%- -q"),
    ("<XF86AudioRaiseVolume>", spawn "amixer sset 'Master' 3%+ -q"),
    -- etc.
    ("<XF86Launch1>", spawn "systemctl hibernate"),
    ("<XF86ScreenSaver>", spawn "physlock -m"),
    ("<XF86Display>", spawn $ homeDir ++ "/.extmo.sh"),
    {-
        bind <print> to make a screenshot of the whole screen
        bind C-<print> to interactively select a window or rectangle and make a screenshot

        sleep 0.2 is a workaround for a bug in xmonad, see:
        https://unix.stackexchange.com/questions/191973/how-to-create-custom-shortcuts-for-scrot-and-gnome-screenshot-interactive-mode/192757#192757
    -}
    ("<Print>", spawn $ "scrot '" ++ homeDir ++ "/Photos/Screenshots/%Y-%m-%d-%H%M%S_$wx$h.png'"),
    ("C-<Print>", spawn $ "sleep 0.2; scrot -s '" ++ homeDir ++ "/Photos/Screenshots/%Y-%m-%d-%H%M%S_$wx$h.png'"),
    -- minimize
    ("M-m", withFocused minimizeWindow),
    ("M-S-m", sendMessage RestoreNextMinimizedWin),
    -- dmenu
    ("M-p", spawn "dmenu_run -i -fn 'xft:monospace:pixelsize=11'"),
    ("M-c", windows copyToAll),
    ("M-s", killAllOtherCopies)]

myManageHook :: [ManageHook]
myManageHook = [
    isFullscreen --> doFullFloat,
    -- Applications
    className =? "Vlc" --> doCenterFloat,
    className =? "mpv" --> doCenterFloat,
    className =? "Zathura" <&&> title =? "Print" --> doCenterFloat,
    className =? "Worms WMD" --> doCenterFloat,
    -- Thunderbird
    className =? "Thunderbird" <&&> title =? "Thunderbird Preferences" --> doCenterFloat,
    className =? "Thunderbird" <&&> appName =? "Msgcompose" --> doCenterFloat,
    className =? "Thunderbird" <&&> appName =? "Calendar" --> doCenterFloat,
    className =? "Thunderbird" <&&> appName =? "Dialog" --> doCenterFloat,
    -- Steam
    className =? "Steam" <&&> title /=? "Steam" --> doCenterFloat]
