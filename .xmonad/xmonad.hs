import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig (additionalKeysP)

main = xmonad =<< xmobar (defaultConfig {
		modMask = mod4Mask,
		terminal = "urxvt",
		workspaces = ["main","chat","web"]
	} `additionalKeysP` myKeys)

myKeys :: [(String, X())]
myKeys = [
	("<XF86AudioMute>", spawn "amixer sset 'Master' toggle -q"),
	("<XF86AudioLowerVolume>", spawn "amixer sset 'Master' 3%- -q"),
	("<XF86AudioRaiseVolume>", spawn "amixer sset 'Master' 3%+ -q"),
	--("<XF86AudioMicMute>", spawn ""),
	("<XF86Launch1>", spawn "systemctl hibernate")]
