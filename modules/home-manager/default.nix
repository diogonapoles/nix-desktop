{
  export-sessions = import ./export-sessions.nix;

  # Wayland environment modules
  nvidia-env = import ./wayland/nvidia-env.nix;
  wayland-env = import ./wayland/wayland-env.nix;
  toolkit-env = import ./wayland/toolkit-env.nix;

  # Configuration modules
  assets = import ./assets.nix;
  monitors = import ./monitors.nix;
}
