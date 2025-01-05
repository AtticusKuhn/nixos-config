import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog (shorten, dynamicLogWithPP, xmobarPP, xmobarColor,wrap ,PP(..))
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Maybe (fromJust)

import XMonad.Hooks.WindowSwallowing
import XMonad
import XMonad.Actions.Volume (lowerVolume, raiseVolume, toggleMute)
import XMonad.Util.Dzen
import Data.Map    (fromList)
import Data.Monoid (mappend)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)
import System.IO (hPutStrLn)
import XMonad.Hooks.ManageDocks (docks, avoidStruts, manageDocks , ToggleStruts)
import XMonad.Util.Hacks (windowedFullscreenFixEventHook, javaHack, trayerAboveXmobarEventHook, trayAbovePanelEventHook)--,  --trayerPaddingXmobarEventHook) --  trayPaddingXmobarEventHook, trayPaddingEventHook)
import XMonad.Util.NamedActions
-- import Colors

-- Colors
color0="#151313"
color1="#748DAA"
color2="#7A9BC7"
color3="#A3A2A3"
color4="#D2AC9E"
color5="#D4CCAE"
color6="#AEBCCB"
color7="#dfdfde"
color8="#9c9c9b"
color9="#748DAA"
color10="#7A9BC7"
color11="#A3A2A3"
color12="#D2AC9E"
color13="#D4CCAE"
color14="#AEBCCB"
color15="#dfdfde"


alert = dzenConfig centered . show . round
centered =
        onCurr (center 150 66)
    >=> font "-*-helvetica-*-r-*-*-64-*-*-*-*-*-*-*"
    >=> addArgs ["-fg", "#80c0ff"]
    >=> addArgs ["-bg", "#000040"]
myEmacs :: String
myEmacs = "emacsclient -c -a 'doom run' "  -- Makes emacs keybindings easier to type


myKeyBindings :: [(String, X () )]
myKeyBindings =    [
        ("<XF86AudioLowerVolume>", lowerVolume 4 >>= alert),
        ("<XF86AudioRaiseVolume>", raiseVolume 4 >>= alert),
        ("<XF86AudioMute>",  (const ()) <$> toggleMute),
        ("<XF86MonBrightnessUp>", spawn "light -A 1"),
        ("<XF86MonBrightnessDown>", spawn "light -U 1"),
        ("M-f", spawn "$BROWSER"),
        ("M-b", spawn "firefox"),
        ("M-w p" , spawn "~/scripts/wallpaper.sh"),
        ("M-m" , spawn "~/scripts/monitors.sh"),
        ("M-t b" , spawn "thunderbird"),
        ("M-w a" , spawn "whatsapp-for-linux"),
        ("M-v c" , spawn "code ."),
        ("M-d c" , spawn "dissent"),
        ("M-g p" , spawn "gimp"),
        ("M-e g", spawn "st -e $EDITOR")
        , ("M-v", spawn "$VISUAL")
--        ("M-r", spawn "st -e ranger")
      -- , ((modMask x, xK_b     ), sendMessage ToggleStruts)
        ,("M-e e",   spawn (myEmacs))
  -- ("M-e e",   spawn (myEmacs ++ ("--eval '(dashboard-refresh-buffer)'")))
  , ("M-e a",   spawn (myEmacs ++ "--eval '(emms)' --eval '(emms-play-directory-tree \"~/Music/\")'"))
  , ("M-e b",   spawn (myEmacs ++ "--eval '(ibuffer)'"))
  , ("M-e d",   spawn (myEmacs ++ "--eval '(dired nil)'"))
  , ("M-e i",   spawn (myEmacs ++ "--eval '(erc)'"))
  , ("M-e n",   spawn (myEmacs ++ "--eval '(elfeed)'"))
  , ("M-e s",   spawn (myEmacs ++ "--eval '(eshell)'"))
  , ("M-e v",   spawn (myEmacs ++ "--eval '(+vterm/here nil)'"))
  , ("M-e w",   spawn (myEmacs ++ "--eval '(doom/window-maximize-buffer(eww \"distro.tube\"))'"))]



myTerminal :: String
myTerminal = "st"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- clickable :: String -> String
-- clickable ws = "<action=xdotool key super+1>"++ws++"</action>"
    -- where i = fromJust $ M.lookup ws myWorkspaceIndices



main :: IO ()
main = do
  -- [color0, color1, color2, color3, color4, color5, color6, color7, color8, color9, color10, color11, color12, color13, color14, color15] <- lines <$> (readFile "/home/atticusk/.cache/wal/colors")
  xmobar_process <- spawnPipe ("xmobar")
  xmonad $ docks $ (def { terminal = myTerminal
	, modMask = mod4Mask
  , handleEventHook    = windowedFullscreenFixEventHook <> swallowEventHook (className =? "Alacritty"
                                                                             <||> className =? "st-256color"
                                                                             <||> className =? "St"
                                                                             <||> className =? "st"
                                                                             <||> className =? "XTerm"
                                                                             -- <||> className =? "emacsclient"
                                                                             -- <||> className =? "*doom* – Doom Emacs"
                                                                             -- <||> className =? "Emacs"
                                                                             <||> className =? "sxiv"
                                                                             <||> className =? "org.pwmt.zathura") (return True) -- <> trayerPaddingXmobarEventHook
     , layoutHook=avoidStruts $ layoutHook def
    , manageHook=manageHook def <+> manageDocks
	, borderWidth = 3
    , logHook = dynamicLogWithPP $ xmobarPP
 { ppOutput = hPutStrLn xmobar_process
                        , ppCurrent = xmobarColor color4 "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor color1 "" . wrap "(" ")"               -- Visible but not current workspace
                        , ppHidden = xmobarColor color2 "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor color3 ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor color4 ""  . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=" ++ color6 ++ "> | </fc>"                     -- Separators in xmobar
                        , ppUrgent = xmobarColor color5 ""  . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }

    --   { ppOutput = hPutStrLn xmobar_process
    --   , ppCurrent = xmobarColor "#c792ea" "" . wrap "<box type=Bottom width=2 mb=2 color=#c792ea>" "</box>"         -- Current workspace
    --   , ppVisible = xmobarColor "#c792ea" "" . clickable              -- Visible but not current workspace
    --   , ppHidden = xmobarColor "#82AAFF" "" . wrap "<box type=Top width=2 mt=2 color=#82AAFF>" "</box>" . clickable -- Hidden workspaces
    --   , ppHiddenNoWindows = xmobarColor "#82AAFF" ""  . clickable     -- Hidden workspaces (no windows)
    --   , ppTitle = xmobarColor "#b3afc2" "" . shorten 60               -- Title of active window
    --   , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character
    --   , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace
    --   , ppExtras  = [windowCount]                                     -- # of windows current workspace
    --   , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
    -- }
	} `additionalKeysP` myKeyBindings)
