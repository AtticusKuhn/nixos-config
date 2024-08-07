# Java is evil. I hate java.
# Cambridge is evil for making me use this bloatware.
# I hate the antichrist


{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
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

    # what does  this even do??
    (mkIf cfg.xdg.enable {

    })
  ];
}
