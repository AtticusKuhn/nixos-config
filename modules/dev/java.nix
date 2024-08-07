<<<<<<< HEAD
# Java is evil. I hate java.
# Cambridge is evil for making me use this bloatware.
# I hate the antichrist


{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
=======
# modules/dev/java.nix --- Poster child for carpal tunnel
#
# TODO

{ hey, lib, config, options, pkgs, ... }:

with lib;
with hey.lib;
>>>>>>> origin
let devCfg = config.modules.dev;
    cfg = devCfg.java;
in {
  options.modules.dev.java = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
<<<<<<< HEAD
      programs.java = {
        enable = true;
        package = pkgs.openjdk;
      };
      user.packages = [ pkgs.openjdk ];
    })

    # what does  this even do??
    (mkIf cfg.xdg.enable {

=======
      # TODO
    })

    (mkIf cfg.xdg.enable {
      environment.sessionVariables._JAVA_OPTIONS =
        ''-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"'';
>>>>>>> origin
    })
  ];
}
