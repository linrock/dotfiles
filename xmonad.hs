-- vim:foldmethod=marker

import XMonad 

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

import XMonad.Layout.Grid
import XMonad.Layout.Dishes
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders

import qualified XMonad.StackSet as W

import System.IO

myTerminal      = "urxvtc"
myFont          = "-*-terminus-medium-*-*-*-12-120-75-75-*-*-iso8859-*"
myTopStatusBar  = "dzen2 -x '0' -y '0' -h '24' -w '1920' -ta 'l' -fg '#FFFFFF' -bg '#161616' -fn " ++ myFont
myBtmStatusBar  = "conky -c ~/.conky_bottom_dzen | dzen2 -x '0' -y '1056' -h '24' -w '1920' -ta 'c' -bg '#161616' -fg '#FFFFFF' -fn " ++ myFont
myBitmapsDir    = "/usr/share/dzen"
myWorkspaces    = 
    [ "1:term1"
    , "2:term2"
    , "3:web"
    , "4:music"
    , "5:misc1"
    , "6:misc2"
    , "7:vbox"
    , "8:comm"
    , "9:logs"
    ]


main = do
    dzenTopBar <- spawnPipe myTopStatusBar
    spawnPipe myBtmStatusBar
    xmonad $ defaultConfig
        { terminal              = myTerminal
        , layoutHook            = myLayoutHook
        , manageHook            = myManageHook
        , logHook               = myLogHook dzenTopBar >> fadeInactiveLogHook 0xdddddddd
        , modMask               = mod4Mask      -- set the mod key to the windows key
        , borderWidth           = 2
        , focusFollowsMouse     = False
        , workspaces            = myWorkspaces
        , normalBorderColor     = "#707070"
        , focusedBorderColor    = "#ffff00"
        } `additionalKeys`        myKeyz

myKeyz = 
    [ ((mod1Mask, xK_F2     ), spawn "bashrun")         -- intuitive Alt-F2 = run window
    , ((mod1Mask, xK_F4     ), kill)                    -- intuitive Alt-F4 = quit
    , ((mod1Mask, xK_Tab    ), windows W.focusDown)     -- intuitive Alt-Tab = next window

    , ((0, 0x1008ff12       ), spawn "amixer set Master toggle")  -- mute volume
    , ((0, 0x1008ff11       ), spawn "amixer set Master 5-")      -- decrease volume
    , ((0, 0x1008ff13       ), spawn "amixer set Master 5+")      -- increase volume
    ]

-- Hooks {{{
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP
    { ppCurrent          = dzenColor "#ebac54" "#161616" . pad
    , ppVisible          = dzenColor "yellow"  "#161616" . pad
    , ppHidden           = dzenColor "gray"    "#161616" . pad
    , ppHiddenNoWindows  = dzenColor "#606060" "#161616" . pad
    , ppUrgent           = dzenColor "red"     "#161616" . pad
    , ppWsSep            = " "
    , ppSep              = "  |  "
    , ppLayout           = dzenColor "#ff6600" "#161616" .
                           (\x -> case x of
                               "ResizableTall"         ->  "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                               "Mirror ResizableTall"  ->  "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                               "Full"                  ->  "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                               "Simple Float"          ->  "~"
                               _                       ->  x
                           )
    , ppTitle            = (" " ++) . dzenColor "#99ff00" "#161616" . dzenEscape
    , ppOutput           = hPutStrLn h
    }

myLayoutHook = avoidStruts $ smartBorders $ (ThreeCol 1 (3/100) (1/2) ||| Grid ||| Dishes 2 (1/6) ||| Full)

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
    [ [isFullscreen        --> doF W.focusDown <+> doFullFloat     ]    -- allows focusing on other windows without leaving FS
    , [className     =? c  --> doShift "3:web1"  |  c  <- myWebs   ]
    , [className     =? c  --> doCenterFloat     |  c  <- myFloats ]
    , [name          =? n  --> doCenterFloat     |  n  <- myNames  ]
    ])
    where
        role      = stringProperty "WM_WINDOW_ROLE"
        name      = stringProperty "WM_NAME"

        myFloats  = ["VirtualBox", "MPlayer", "Save As..."]
        myWebs    = ["Firefox", "Chrome"]
        myNames   = ["Firefox Preferences", "Chromium Options", "bashrun"]
-- }}}

