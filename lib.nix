{ lib, ... }:
{
  # Filter groups to only include those that exist in the system configuration
  # Usage: ifTheyExist ["wheel" "docker"] config
  ifTheyExist = groups: config:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
}
