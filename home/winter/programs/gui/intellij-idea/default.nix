{ pkgs, ... }: 
let
  ideaWithPlugins = pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea-ultimate [
    "nixidea"   
    "ideavim"   
  ];
in {
  home.packages = [ ideaWithPlugins ];
  
  xdg.desktopEntries.idea-ultimate = {
    name = "IntelliJ IDEA Ultimate";
    exec = "${ideaWithPlugins}/bin/idea-ultimate -Dawt.toolkit.name=WLToolkit %f";
    icon = "intellij-idea-ultimate";
    categories = [ "Development" "IDE" ];
  };
}
