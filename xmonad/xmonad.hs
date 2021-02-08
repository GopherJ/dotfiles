import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops

main = do
    xmonad $ ewmh $ desktopConfig {
        terminal = "alacritty"
    }
