# Java is evil. I hate java.
# Cambridge is evil for making me use this bloatware.
# I hate the antichrist
{ hey, lib, config, options, pkgs, ... }:

with lib;
with hey.lib;
let devCfg = config.modules.dev;
    cfg = devCfg.java;
in {
  options.modules.dev.java = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.java = {
        enable = true;
        package = pkgs.openjdk;
      };
      user.packages = [ pkgs.openjdk ];
    })
    (mkIf cfg.xdg.enable {
      environment.sessionVariables._JAVA_OPTIONS =
        ''-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"'';
    })
  ];
}
