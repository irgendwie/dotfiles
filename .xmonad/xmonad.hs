import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts)
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
		handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook,
		modMask = mod4Mask,
		terminal = "urxvt",
		workspaces = ["1'www", "2'new", "3'irc", "4'mus", "5'mov", "6'cod", "7'uni", "8'pir","9'mis"],
		logHook = dynamicLogWithPP $ xmobarPP {
			ppOutput = hPutStrLn xmproc,
			ppTitle = xmobarColor "#CCCCCC" "" . shorten 100,
			ppCurrent = xmobarColor "#4A7781" ""
		},
		layoutHook = avoidStruts $ minimize $ spiral (0.675) ||| layoutHook defaultConfig,
		manageHook = manageHook defaultConfig <+> composeAll myManageHook
	} `additionalKeysP` (myKeys homeDir)

myKeys :: FilePath -> [(String, X())]
myKeys homeDir = [
	-- Volume control
	("<XF86AudioMute>", spawn "amixer sset 'Master' toggle -q"),
	("<XF86AudioLowerVolume>", spawn "amixer sset 'Master' 3%- -q"),
	("<XF86AudioRaiseVolume>", spawn "amixer sset 'Master' 3%+ -q"),
	-- etc.
	("<XF86Launch1>", spawn "systemctl hibernate"),
	("<XF86ScreenSaver>", spawn "physlock"),
	("<XF86Display>", spawn $ homeDir ++ "/.extmo.sh"),
	("<Print>", spawn $ "scrot '" ++ homeDir ++ "/Pictures/Screenshots/%Y-%m-%d-%H%M%S_$wx$h.png'"),
	-- minimize
	("M-m", withFocused minimizeWindow),
	("M-S-m", sendMessage RestoreNextMinimizedWin),
	-- dmenu
	("M-p", spawn "dmenu_run -i")]

myManageHook :: [ManageHook]
myManageHook = [
	isFullscreen --> doFullFloat,
	-- Applications
	className =? "Vlc" --> doCenterFloat,
	className =? "mpv" --> doCenterFloat,
	className =? "Zathura" <&&> title =? "Drucken" --> doCenterFloat,
	-- Thunderbird
	className =? "Thunderbird" <&&> title =? "Thunderbird-Einstellungen" --> doCenterFloat,
	className =? "Thunderbird" <&&> appName =? "Msgcompose" --> doCenterFloat,
	className =? "Thunderbird" <&&> appName =? "Calendar" --> doCenterFloat,
	className =? "Thunderbird" <&&> appName =? "Dialog" --> doCenterFloat,
	className =? "Steam" <&&> title /=? "Steam" --> doCenterFloat]
