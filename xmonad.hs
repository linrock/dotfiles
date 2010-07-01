-- vim:foldmethod=marker

import System.IO
import XMonad 

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Hooks.ManageHelpers

import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

import XMonad.Layout.Grid
import XMonad.Layout.Dishes
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders

import qualified XMonad.StackSet as W

-- Variables {{{
myBarBgColor      = "#000000"
myTerminal        = "urxvtc"
myFont            = "-*-terminus-medium-*-*-*-12-120-75-75-*-*-iso8859-*"
myXmonadStatusBar = "dzen2 -x '0' -y '1056' -h '24' -w '1920' -ta 'l' -fg '#FFFFFF' -bg '" ++ myBarBgColor ++ "' -fn " ++ myFont
mySysStatusBar    = "conky -c ~/.conky_bottom_dzen | dzen2 -x '0' -y '0' -h '24' -w '1920' -ta 'c' -bg '" ++ myBarBgColor ++ "' -fg '#FFFFFF' -fn " ++ myFont
myBitmapsDir      = "/usr/share/dzen"
myWorkspaces      = 
    [ "1:term"
    , "2:fire"
    , "3:dev"
    , "4:web"
    , "5:media"
    , "6:misc"
    , "7:win"
    , "8:comm"
    , "9:logs"
    ]
-- }}}

-- Main {{{
main = do
    dzenTopBar <- spawnPipe myXmonadStatusBar
    spawnPipe mySysStatusBar
    xmonad
        $ withUrgencyHook dzenUrgencyHook {args = ["-bg", "black", "-fg", "red"]}
        $ defaultConfig
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
        } `additionalKeys`
            [ ((mod1Mask, xK_F2   ), spawn "bashrun")         -- Alt-F2 = run window
            , ((mod1Mask, xK_F4   ), kill)                    -- Alt-F4 = quit
            , ((mod1Mask, xK_Tab  ), windows W.focusDown)     -- Alt-Tab = next window

            , ((mod4Mask, xK_q    ), spawn "xmonad --recompile; killall dzen2; xmonad --restart")
            ]
-- }}}

-- Hooks {{{
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP
    { ppCurrent          = dzenColor "#ebac54" myBarBgColor . pad
    , ppVisible          = dzenColor "yellow"  myBarBgColor . pad
    , ppHidden           = dzenColor "gray"    myBarBgColor . pad
    , ppHiddenNoWindows  = dzenColor "#606060" myBarBgColor . pad
    , ppUrgent           = dzenColor "red"     myBarBgColor . pad
    , ppWsSep            = " "
    , ppSep              = "  |  "
    , ppLayout           = dzenColor "#ff6600" myBarBgColor .
                           (\x -> case x of
                               "ResizableTall"         ->  "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                               "Mirror ResizableTall"  ->  "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                               "Full"                  ->  "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                               "Simple Float"          ->  "~"
                               _                       ->  x
                           )
    , ppTitle            = (" " ++) . dzenColor "#99ff00" myBarBgColor . dzenEscape
    , ppOutput           = hPutStrLn h
    }

myLayoutHook = avoidStruts $ smartBorders $
    (noBorders Full ||| Grid ||| Dishes 2 (1/6))

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
    -- [[ isFullscreen        --> doF W.focusDown <+> doFullFloat     ]
    [[ isFullscreen        --> doFullFloat                          ]
    ,[ className     =? r  --> doIgnore          |  r  <- myIgnores ]
    ,[ className     =? c  --> doShift "2:fire"  |  c  <- myFires   ]
    ,[ className     =? c  --> doShift "4:web"   |  c  <- myWebs    ]
    ,[ className     =? c  --> doShift "5:media" |  c  <- myMedia   ]
    ,[ className     =? c  --> doShift "7:win"   |  c  <- myWins    ]
    ,[ className     =? c  --> doShift "8:comm"  |  c  <- myComms   ]
    ,[ className     =? c  --> doCenterFloat     |  c  <- myFloats  ]
    ,[ wmName        =? n  --> doCenterFloat     |  n  <- myNames   ]
    ])
    where
        -- wmRole    = stringProperty "WM_WINDOW_ROLE"
        wmName    = stringProperty "WM_NAME"

        myIgnores = ["trayer"]
        myFires   = ["Firefox", "Minefield"]
        myWebs    = ["Chrome"]
        myMedia   = ["MPlayer"]
        myWins    = ["VirtualBox"]
        myComms   = ["Pidgin"]
        myFloats  = ["VirtualBox", "Artha", "MPlayer", "Pidgin", "Save As..."]
        myNames   = ["Firefox Preferences", "Add-ons", "Chromium Options", "bashrun"]
-- }}}

