{
  pkgs,
  config,
  ...
}:
let
  homeDir = config.users.users.winter.home;

  # Helper script to create virtual monitor before Sunshine starts
  sunshineMonitorCreate = pkgs.writeScriptBin "sunshine-monitor-create" ''
    #!/usr/bin/env bash
    set -euo pipefail

    MONITOR_NAME="streaming"
    RESOLUTION="1280x800"
    REFRESH_RATE="60"

    log() { echo "[sunshine-monitor-create] $1" >&2; }

    # Check if Hyprland is running
    if ! ${pkgs.procps}/bin/pgrep Hyprland > /dev/null; then
        log "ERROR: Hyprland is not running"
        exit 1
    fi

    # Remove existing streaming monitor if it exists (clean slate)
    if ${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -e ".[] | select(.name == \"$MONITOR_NAME\")" > /dev/null 2>&1; then
        log "Removing existing virtual monitor: $MONITOR_NAME"
        ${pkgs.hyprland}/bin/hyprctl output remove "$MONITOR_NAME" || true
        sleep 0.3
    fi

    # Create new virtual monitor with custom name
    log "Creating virtual monitor: $MONITOR_NAME"
    if ! ${pkgs.hyprland}/bin/hyprctl output create headless "$MONITOR_NAME"; then
        log "ERROR: Failed to create virtual monitor"
        exit 1
    fi

    sleep 0.5

    # Configure the monitor with desired resolution
    log "Configuring monitor to ''${RESOLUTION}@''${REFRESH_RATE}Hz..."
    if ! ${pkgs.hyprland}/bin/hyprctl keyword monitor "''${MONITOR_NAME},''${RESOLUTION}@''${REFRESH_RATE},auto,1"; then
        log "ERROR: Failed to configure virtual monitor"
        exit 1
    fi

    # Verify configuration
    CURRENT_RES=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r ".[] | select(.name == \"$MONITOR_NAME\") | \"\(.width)x\(.height)@\(.refreshRate)\"")
    log "Monitor configured successfully: $MONITOR_NAME at $CURRENT_RES"

    exit 0
  '';

  sunshineLaunchSteam = pkgs.writeScriptBin "sunshine-launch-steam" ''
    #!/usr/bin/env bash
    set -euo pipefail

    MONITOR_NAME="streaming"
    RESOLUTION="1280x800"
    REFRESH_RATE="60"

    hyprctl dispatch moveworkspacetomonitor 3 streaming && setsid steam steam://open/bigpicture

    exit 0
  '';

  # Helper script to remove virtual monitor after Sunshine stops
  sunshineMonitorRemove = pkgs.writeScriptBin "sunshine-monitor-remove" ''
    #!/usr/bin/env bash
    set -euo pipefail

    MONITOR_NAME="streaming"

    log() { echo "[sunshine-monitor-remove] $1" >&2; }

    # Check if Hyprland is running
    if ! ${pkgs.procps}/bin/pgrep Hyprland > /dev/null; then
        log "WARNING: Hyprland is not running, skipping cleanup"
        exit 0
    fi

    # Remove the streaming monitor
    if ${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -e ".[] | select(.name == \"$MONITOR_NAME\")" > /dev/null 2>&1; then
        log "Removing virtual monitor: $MONITOR_NAME"
        ${pkgs.hyprland}/bin/hyprctl output remove "$MONITOR_NAME" || log "WARNING: Failed to remove $MONITOR_NAME"
    else
        log "Virtual monitor $MONITOR_NAME not found (already removed)"
    fi

    log "Virtual monitor cleanup complete"
    exit 0
  '';
in
{
  environment.systemPackages = with pkgs; [
    moonlight-qt
    sunshineMonitorCreate
    sunshineMonitorRemove
    sunshineLaunchSteam
  ];

  # ===============================================================================
  #
  # How to use:
  #  1. setup user via Web Console: <https://localhost:47990/>):
  #  2. on another machine, connect to sunshine via moonlight-qt client
  #
  # systemctl --user status sunshine
  #
  # ===============================================================================
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # omit this when using with Xorg
    openFirewall = true;

    # override package to add CUDA support and NVIDIA runtime dependencies
    package = pkgs.sunshine.override {
      cudaSupport = true;
    };
  };

  # GPU library paths to systemd service environment for NVENC support
  systemd.user.services.sunshine = {
    serviceConfig = {
      Environment = [
        "LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib"
      ];
    };

    # Ensure jq is available for JSON parsing in scripts
    path = [ pkgs.jq ];
  };
}
