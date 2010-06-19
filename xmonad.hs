-- vim:foldmethod=marker

import XMonad 

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns

import qualified XMonad.StackSet as W

import System.IO

myTerminal      = "urxvtc"
myFont          = "-*-terminus-medium-*-*-*-12-120-75-75-*-*-iso8859-*"
myTopStatusBar  = "dzen2 -x '0' -y '0' -h '24' -w '1920' -ta 'l' -fg '#FFFFFF' -bg '#161616' -fn " ++ myFont
myBtmStatusBar  = "conky -c ~/.conky_bottom_dzen | dzen2 -x '0' -y '1056' -h '24' -w '1920' -ta 'c' -bg '#161616' -fg '#FFFFFF' -fn " ++ myFont
myBitmapsDir    = "/usr/share/dzen"
myWorkspaces    = 
    [ "1:dev1"
    , "2:dev2"
    , "3:web1"
    , "4:web2"
    , "5:music"
    , "6:misc1"
    , "7:misc2"
    , "8:logs1"
    , "9:logs2"
    ]


main = do
    dzenTopBar <- spawnPipe myTopStatusBar
    dzenBtmBar <- spawnPipe myBtmStatusBar
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
    [ ((mod1Mask, xK_F2),         spawn "bashrun")
    , ((0,                        0x1008ff12  ), spawn "amixer set Master toggle")  -- mute volume
    , ((0,                        0x1008ff11  ), spawn "amixer set Master 5-")      -- decrease volume
    , ((0,                        0x1008ff13  ), spawn "amixer set Master 5+")      -- increase volume
    ]

-- Hooks {{{
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP
    { ppCurrent          = dzenColor "#ebac54" "#161616" . pad
    , ppVisible          = dzenColor "white"   "#161616" . pad
    , ppHidden           = dzenColor "white"   "#161616" . pad
    , ppHiddenNoWindows  = dzenColor "#444444" "#161616" . pad
    , ppUrgent           = dzenColor "red"     "#161616" . pad
    , ppWsSep            = " "
    , ppSep              = "  |  "
    , ppLayout           = dzenColor "#ebac54" "#161616" .
                           (\x -> case x of
                               "ResizableTall"         ->  "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                               "Mirror ResizableTall"  ->  "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                               "Full"                  ->  "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                               "Simple Float"          ->  "~"
                               _                       ->  x
                           )
    , ppTitle            = (" " ++) . dzenColor "white" "#161616" . dzenEscape
    , ppOutput           = hPutStrLn h
    }

myLayoutHook = avoidStruts $ (ThreeCol 1 (3/100) (1/2) ||| Accordion ||| Grid ||| spiral(6/7) ||| Full)

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
    [ [isFullscreen        --> doF W.focusDown <+> doFullFloat     ]
    , [className     =? c  --> doShift "3:web1"  |  c  <- myWebs   ]
    , [className     =? c  --> doCenterFloat     |  c  <- myFloats ]
    , [name          =? n  --> doCenterFloat     |  n  <- myNames  ]
    ])
    where
        role      = stringProperty "WM_WINDOW_ROLE"
        name      = stringProperty "WM_NAME"

        myFloats  = ["VirtualBox", "Save As...", "MPlayer"]
        myWebs    = ["Firefox"]
        myNames   = ["bashrun"]
-- }}}
