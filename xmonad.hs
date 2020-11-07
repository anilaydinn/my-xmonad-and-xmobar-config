import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageHelpers(isDialog, doCenterFloat)
import XMonad.Hooks.DynamicLog
import XMonad.Actions.SpawnOn
import Data.Map    (fromList)
import Data.Monoid (mappend)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeysP)

--------------------------------------------------------------------
-------------- General Configs
--------------------------------------------------------------------

myTerminal    = "terminator"
myModMask     = mod4Mask -- Win key or Super_L

-- width of border around windows
myBorderWidth = 1

-- color of focused border
myFocusedBorderColor = "#ff0000"

-- color of inactive border
myNormalBorderColor = "#00ff00"

myWorkspaces =  ["1","2","3","4","5","6","7","8","9"] ++ (map snd myExtraWorkspaces)

myExtraWorkspaces = [(xK_0, "term")] -- list of (key, name)

--------------------------------------------------------------------
-------------- Xmobar
--------------------------------------------------------------------

-- -- Command to launch the bar.
myBar = "xmobar"
--
-- -- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppTitle = xmobarColor "#00ff00" "" . shorten 50,
                  ppCurrent = xmobarColor "#00ff00" "" . wrap "<" ">" }
--
-- -- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

--------------------------------------------------------------------
-------------- Shortcuts
--------------------------------------------------------------------

shortcuts = [
        ("M-<Return>", spawn myTerminal),
        ("M-p", spawn "dmenu_run -fn 'Cascadia Code:pixelsize=13' -nb '#000000' -sf '#000000' -sb '#00ff00' -nf '#00ff00'"),
        ("M-w", spawn "google-chrome-stable --force-dark-mode")
      ]

--------------------------------------------------------------------
-------------- Window Manipulations
--------------------------------------------------------------------

myManageHook :: ManageHook 
myManageHook = composeAll . concat $ [ [isDialog -->  doCenterFloat] ]
 
--------------------------------------------------------------------
-------------- Main Function
--------------------------------------------------------------------

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myConfig = defaultConfig
      { terminal    = myTerminal
      , modMask     = myModMask
      , borderWidth = myBorderWidth
      , focusedBorderColor = myFocusedBorderColor
      , normalBorderColor = myNormalBorderColor
      , workspaces = myWorkspaces
      , layoutHook = smartSpacing 10 $ smartBorders $ layoutHook defaultConfig
      , manageHook = manageHook defaultConfig <+> myManageHook
      }`additionalKeysP`
      shortcuts
