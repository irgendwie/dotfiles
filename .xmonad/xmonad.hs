import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP)
import System.IO (hPutStrLn)

main = do
	xmproc <- spawnPipe "xmobar"
	xmonad $ defaultConfig {
		modMask = mod4Mask,
		terminal = "urxvt",
		workspaces = ["www", "chat", "office", "prog"] ++ map show [5..9],
		logHook = dynamicLogWithPP $ xmobarPP {
			ppOutput = hPutStrLn xmproc,
			ppTitle = xmobarColor "#CCCCCC" "" . shorten 100,
			ppCurrent = xmobarColor "#4A7781" ""
		},
		layoutHook = avoidStruts $ layoutHook defaultConfig
	} `additionalKeysP` myKeys

myKeys :: [(String, X())]
myKeys = [
	("<XF86AudioMute>", spawn "amixer sset 'Master' toggle -q"),
	("<XF86AudioLowerVolume>", spawn "amixer sset 'Master' 3%- -q"),
	("<XF86AudioRaiseVolume>", spawn "amixer sset 'Master' 3%+ -q"),
	--("<XF86AudioMicMute>", spawn ""),
	("<XF86Launch1>", spawn "systemctl hibernate")
]
