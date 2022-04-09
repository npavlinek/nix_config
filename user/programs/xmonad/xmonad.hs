import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import XMonad.Util.Loggers


-- TODO: Once `xmonad` in Nixpkgs reaches a version > 0.15, use `ewmhFullscreen` instead.
main :: IO ()
main = xmonad . ewmh =<< statusBar "xmobar" myXmobarPP toggleStrutsKey myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig { modMask = m } = (m, xK_b)

myXmobarPP :: PP
myXmobarPP = def
  { ppCurrent = xmobarColor primaryColor ""
  , ppSep = (wrap " " " " . xmobarColor "#504945" "") "•"
  , ppLayout = xmobarColor "#8ec07c" ""
  , ppTitle = xmobarColor "#b8bb26" "" . shorten 100
  }

myConfig = def
  { normalBorderColor = "#1d2021"
  , focusedBorderColor = primaryColor
  , terminal = myTerminal
  , handleEventHook = handleEventHook def <+> fullscreenEventHook
  , modMask = mod4Mask  -- Super "Windows" key
  , borderWidth = 2
  } `additionalKeysP`
  [ ("M-<Return>", spawn myTerminal)
  , ("<XF86MonBrightnessUp>", spawn "brightnessctl s +5%")
  , ("<XF86MonBrightnessDown>", spawn "brightnessctl s 5%-")
  ]

primaryColor :: String
primaryColor = "#b16286"

myTerminal :: String
myTerminal = "urxvt"
