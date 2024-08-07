
{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.sqlite;
in {
  options.modules.dev.sqlite = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = [ pkgs.sqlite ];
    })

    # what does  this even do??
    (mkIf cfg.xdg.enable {

    })
  ];
}
