# Global settings that ALL hosts should have
{ outputs, ... }:
{
  imports = [
    outputs.nixosModules.default
  ];

  # Universal settings (if any) can be added here
  # Most configuration is now in modules with sensible defaults
}
