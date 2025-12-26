{ lib, ... }:
{
  # Filter groups to only include those that exist in the system configuration
  # Usage: ifTheyExist ["wheel" "docker"] config
  ifTheyExist = groups: config:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  # Helper for resolving paths relative to the repository root
  # Usage: mkRelativeToRoot "/hosts/apollo"
  mkRelativeToRoot = path: ../. + path;

  # Conditional helper - simplified if/else
  # Usage: mkIfElse condition thenValue elseValue
  mkIfElse = condition: yes: no:
    if condition then yes else no;
}
