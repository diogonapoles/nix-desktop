{
  export-sessions = import ./export-sessions.nix;

  # wayland environment modules
  nvidia-env = import ./wayland/nvidia-env.nix;
  wayland-env = import ./wayland/wayland-env.nix;
  toolkit-env = import ./wayland/toolkit-env.nix;

  # configuration modules
  assets = import ./assets.nix;
  monitors = import ./monitors.nix;
  stylix-targets = import ./stylix-targets.nix;
}
