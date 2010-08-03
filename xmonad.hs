-- vim:foldmethod=marker

import System.IO
import XMonad 

import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

import XMonad.Layout.Grid
import XMonad.Layout.Dishes
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace

import qualified XMonad.StackSet as W

-- Variables {{{
myBarBgColor      = "#000000"
myTerminal        = "urxvtc"
myFont            = "-*-terminus-medium-*-*-*-12-120-75-75-*-*-iso8859-*"
myXmonadStatusBar = "dzen2 -x '0' -y '1056' -h '24' -w '1920' -ta 'l' -fg '#FFFFFF' -bg '" ++ myBarBgColor ++ "' -fn " ++ myFont
mySysStatusBar    = "conky -c ~/.conkyrc | dzen2 -x '0' -y '0' -h '24' -w '1920' -ta 'c' -bg '" ++ myBarBgColor ++ "' -fg '#FFFFFF' -fn " ++ myFont
myWorkspaces      = 
    [ "1:term"
    , "2:fire"
    , "3:dev"
    , "4:ssh"
    , "5:vbox"
    , "6:misc"
    , "7:media"
    , "8:comm"
    , "9:logs"
    ]
-- }}}

-- Prompt {{{
myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
    { font                  = myFont
    , bgColor               = "#000000"
    , fgColor               = "#9afeff"
    , bgHLight              = "#c0c0c0"
    , fgHLight              = "#000000"
    , position              = Top
    , height                = 24
    , promptBorderWidth     = 0
    , historyFilter         = deleteConsecutive
    }
-- }}}

-- Main {{{
main = do
    dzenTopBar <- spawnPipe myXmonadStatusBar
    spawnPipe mySysStatusBar
    xmonad
        $ withUrgencyHook NoUrgencyHook
        $ defaultConfig
        { terminal              = myTerminal
        , layoutHook            = myLayoutHook
        , manageHook            = myManageHook
        , logHook               = myLogHook dzenTopBar
        , modMask               = mod4Mask      -- set the mod key to the windows key
        , borderWidth           = 2
        , focusFollowsMouse     = False
        , workspaces            = myWorkspaces
        , normalBorderColor     = "#707070"
        , focusedBorderColor    = "#fbb917"
        } `additionalKeys`
            -- [ ((mod1Mask, xK_F2   ), spawn "bashrun")         -- Alt-F2 = run window
            [ ((mod1Mask, xK_F2   ), runOrRaisePrompt myXPConfig)
            , ((mod1Mask, xK_F4   ), kill)                          -- Alt-F4 = quit
            , ((mod1Mask, xK_Tab  ), windows W.focusDown)           -- Alt-Tab = next window
            , ((mod4Mask, xK_q    ), spawn "xmonad --recompile; killall dzen2; xmonad --restart")
            ]
-- }}}

-- Hooks {{{
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ dzenPP
    { ppCurrent          = dzenColor "yellow"  ""       . pad
    , ppVisible          = dzenColor "#f4f4f4" ""       . pad
    , ppHidden           = dzenColor "#707070" ""       . pad
    , ppHiddenNoWindows  = dzenColor "#303030" ""       . pad
    , ppUrgent           = dzenColor ""        "yellow"
    , ppWsSep            = " "
    , ppSep              = "  |  "
    , ppLayout           = dzenColor "#ff6600" myBarBgColor . pad
    , ppTitle            = (" " ++) . dzenColor "#99ff00" myBarBgColor . dzenEscape
    , ppOutput           = hPutStrLn h
    }

myLayoutHook = avoidStruts $ smartBorders $
    onWorkspace     "1:term"    (Grid ||| Dishes 2 (1/6)) $
    onWorkspace     "2:fire"    (noBorders Grid) $
    onWorkspace     "3:dev"     (Grid ||| Dishes 2 (1/6)) $
    onWorkspace     "4:ssh"     (Grid ||| Dishes 2 (1/6)) $
    onWorkspace     "5:vbox"    (noBorders Full) $
    onWorkspace     "7:media"   (noBorders Full ||| Grid) $
    (noBorders Full ||| Grid ||| ThreeCol 1 (3/100) (1/3) ||| Dishes 2 (1/6))

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
    -- [[ isFullscreen        --> doF W.focusDown <+> doFullFloat     ]
    [[ isFullscreen        --> doFullFloat                          ]
    ,[ className     =? i  --> doIgnore          |  i  <- myIgnores ]
    ,[ className     =? c  --> doShift "2:fire"  |  c  <- myFires   ]
    ,[ className     =? c  --> doShift "5:vbox"  |  c  <- myVMs     ]
    ,[ className     =? c  --> doShift "8:comm"  |  c  <- myComms   ]
    ,[ className     =? c  --> doCenterFloat     |  c  <- myFloats  ]
    ,[ wmName        =? n  --> doCenterFloat     |  n  <- myNames   ]
    ])
    where
        -- wmRole    = stringProperty "WM_WINDOW_ROLE"
        wmName    = stringProperty "WM_NAME"

        myIgnores = ["trayer"]
        myFires   = ["Firefox", "Minefield"]
        myVMs     = ["VirtualBox"]
        myComms   = ["Pidgin"]
        myFloats  = ["Gtick", "Nitrogen", "feh", "MPlayer", "Pidgin", "Save As..."]
        myNames   = ["Namoroka Preferences", "Add-ons", "Downloads", "Manage Proxies", "Proxy Info", "Chromium Options", "bashrun"]
-- }}}

