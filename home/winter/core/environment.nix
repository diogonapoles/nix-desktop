{
  config,
  lib,
  ...
}: {
  home.sessionVariables = {
    # =========================================================================
    # System Configuration
    # =========================================================================

    # Path to NixOS flake configuration directory
    NH_FLAKE = "/home/${config.home.username}/nixos";

    # =========================================================================
    # NVIDIA GPU Configuration
    # =========================================================================
    
    # Hardware video acceleration
    LIBVA_DRIVER_NAME = "nvidia";

    # OpenGL vendor 
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # NVIDIA Direct rendering backend
    NVD_BACKEND = "direct";

    # Generic Buffer Management backend
    GBM_BACKEND = "nvidia-drm";

    # Disable atomic mode setting for wlroots
    # Workaround for NVIDIA compatibility with wlroots-based compositors
    WLR_DRM_NO_ATOMIC = 1;

    # =========================================================================
    # Wayland Session Configuration
    # =========================================================================

    XDG_SESSION_TYPE = "wayland";

    # =========================================================================
    # Browser & Electron Application Configuration
    # =========================================================================

    # Chromium/Electron Wayland support
    NIXOS_OZONE_WL = "1";

    # Firefox Wayland support
    MOZ_ENABLE_WAYLAND = "1";

    # Firefox WebRender
    MOZ_WEBRENDER = "1";

    # Electron Wayland auto-detection
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # =========================================================================
    # Toolkit Configuration (Qt, GTK, SDL)
    # =========================================================================

    # Qt window decorations
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # Qt platform plugin
    QT_QPA_PLATFORM = "wayland";

    # SDL video driver
    SDL_VIDEODRIVER = "wayland";

    # GTK backend selection
    # Prefer Wayland but fallback to X11 if needed.
    GDK_BACKEND = "wayland, x11";

    # GTK HiDPI scaling factor
    GDK_SCALE = "2";

    # =========================================================================
    # Application-Specific Compatibility
    # =========================================================================

    # Java AWT window manager compatibility
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
