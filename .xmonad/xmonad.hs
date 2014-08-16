import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP)
import System.IO (hPutStrLn)
import XMonad.Hooks.ManageHelpers

main = do
	xmproc <- spawnPipe "xmobar"
	xmonad $ defaultConfig {
		modMask = mod4Mask,
		terminal = "urxvt",
		workspaces = ["1'www", "2'new", "3'irc", "4'mus", "5'mov'", "6'cod", "7'uni", "8'pir","9'mis"],
		logHook = dynamicLogWithPP $ xmobarPP {
			ppOutput = hPutStrLn xmproc,
			ppTitle = xmobarColor "#CCCCCC" "" . shorten 100,
			ppCurrent = xmobarColor "#4A7781" ""
		},
		layoutHook = avoidStruts $ layoutHook defaultConfig,
		manageHook = manageHook defaultConfig <+> composeAll myManageHook
	} `additionalKeysP` myKeys

myKeys :: [(String, X())]
myKeys = [
	("<XF86AudioMute>", spawn "amixer sset 'Master' toggle -q"),
	("<XF86AudioLowerVolume>", spawn "amixer sset 'Master' 3%- -q"),
	("<XF86AudioRaiseVolume>", spawn "amixer sset 'Master' 3%+ -q"),
	("<XF86Launch1>", spawn "systemctl hibernate"),
	("<XF86ScreenSaver>", spawn "slimlock"),
	("<Print>", spawn "scrot '/home/alex/Pictures/Screenshots/%Y-%m-%d-%H%M%S_$wx$h.png'") ]

myManageHook :: [ManageHook]
myManageHook = [
	className =? "Vlc" --> doCenterFloat,
	className =? "mpv" --> doCenterFloat,
	isFullscreen --> doFullFloat ]
