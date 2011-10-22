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
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

import XMonad.Util.Themes
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)

import XMonad.Layout.Grid
import XMonad.Layout.Dishes
import XMonad.Layout.Minimize
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import XMonad.Layout.SimpleFloat

import qualified XMonad.StackSet as W

-- Variables {{{
myBarBgColor      = "#000000"
myTerminal        = "urxvt"
myFont            = "-*-terminus-medium-*-*-*-12-120-75-75-*-*-iso8859-*"
myXmonadStatusBar = "dzen2 -x '0' -y '1056' -h '24' -w '1920' -ta 'l' -fg '#FFFFFF' -bg '" ++ myBarBgColor ++ "' -fn " ++ myFont
mySysStatusBar    = "conky -c ~/.conkyrc | dzen2 -x '0' -y '0' -h '24' -w '1920' -ta 'c' -bg '" ++ myBarBgColor ++ "' -fg '#FFFFFF' -fn " ++ myFont
myWorkspaces      = [ ".1:",":2.",".3:",":4.",".5:",":6.",".7:",":8.",".9:"]
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
        , startupHook           = ewmhDesktopsStartup >> setWMName "LG3D"
        , handleEventHook       = fullscreenEventHook
        , modMask               = mod4Mask      -- set the mod key to the windows key
        , borderWidth           = 2
        , focusFollowsMouse     = False
        , workspaces            = myWorkspaces
        , normalBorderColor     = "#707070"
        , focusedBorderColor    = "#fbb917"
        } `additionalKeys`
            -- , ((mod1Mask, xK_Tab  ), windows W.focusDown)           -- Alt-Tab = next window
            -- [ ((mod1Mask, xK_F2                 ), spawn "bashrun2")
            [ ((mod1Mask, xK_F2                 ), runOrRaisePrompt myXPConfig)
            , ((mod1Mask, xK_F4                 ), kill)                          -- Alt-F4 = quit
            -- , ((mod4Mask, xK_u                  ), withFocused (\f -> sendMessage (MinimizeWin f)))
            -- , ((mod4Mask .|. shiftMask, xK_u    ), sendMessage RestoreNextMinimizedWin)
            , ((mod4Mask, xK_x                  ), sendMessage $ Toggle REFLECTX)
            , ((mod4Mask, xK_y                  ), sendMessage $ Toggle REFLECTY)
            , ((mod4Mask, xK_q                  ), spawn "xmonad --recompile && killall dzen2 && xmonad --restart")
            ]
-- }}}

-- Hooks {{{
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ dzenPP
    { ppCurrent          = dzenColor "#ffcc00" "black" . pad
    , ppVisible          = dzenColor "#f4f4f4" "black" . pad
    , ppHidden           = dzenColor "#707070" "black" . pad
    , ppHiddenNoWindows  = dzenColor "black"   "black" . pad
    , ppUrgent           = dzenColor "black"   "orange" . pad
    , ppWsSep            = " "
    , ppSep              = "  |  "
    , ppLayout           = dzenColor "#ff6600" myBarBgColor . pad
    , ppTitle            = (" " ++) . dzenColor "#ffff00" myBarBgColor . dzenEscape
    , ppOutput           = hPutStrLn h
    }

-- myLayoutHook = avoidStruts $ smartBorders $ minimize $
myLayoutHook = avoidStruts $ smartBorders $
    mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $
        onWorkspace     ".1:"    (Grid ||| ThreeCol 1 (3/100) (1/3) ||| noBorders Full) $
        onWorkspace     ":2."    (noBorders Full ||| Grid ||| ThreeCol 1 (3/100) (1/3)) $
        onWorkspace     ".3:"    (Grid ||| ThreeCol 1 (3/100) (1/3) ||| noBorders Full) $
        onWorkspace     ":4."    (Grid ||| ThreeCol 1 (3/100) (1/3) ||| noBorders Full) $
        onWorkspace     ".5:"    (Grid ||| noBorders Full) $
        onWorkspace     ":6:"    simpleFloat $
        onWorkspace     ".7:"    (noBorders Full ||| Grid) $
        (noBorders Full ||| Grid ||| ThreeCol 1 (3/100) (1/3))

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
    -- [[ isFullscreen        --> doF W.focusDown <+> doFullFloat       ]
    [[ isFullscreen        --> doFullFloat                           ]
    ,[ className     =? i  --> doIgnore          |  i  <- myIgnores  ]
    ,[ className     =? c  --> doShift ":2."     |  c  <- myBrowsers ]
    ,[ className     =? c  --> doShift ".5:"     |  c  <- myVMs      ]
    ,[ className     =? c  --> doShift ":8."     |  c  <- myComms    ]
    ,[ className     =? c  --> doCenterFloat     |  c  <- myFloats   ]
    ,[ wmName        =? n  --> doCenterFloat     |  n  <- myNames    ]
    ])
    where
        -- wmRole    = stringProperty "WM_WINDOW_ROLE"
        wmName      = stringProperty "WM_NAME"

        myIgnores   = ["trayer"]
        myBrowsers  = ["Firefox", "Chrome"]
        myVMs       = ["VirtualBox"]
        myComms     = ["Lanikai", "Pidgin"]
        myFloats    = ["Nitrogen", "MPlayer", "Pidgin", "Save As...", "Mirage", "VirtualBox"]
        myNames     = ["Firefox Preferences", "Downloads", "Chromium Preferences", "Firebug"]
-- }}}

