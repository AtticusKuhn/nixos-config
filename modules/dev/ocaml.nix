
{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.ocaml;
in {
  options.modules.dev.ocaml = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = [
        pkgs.ocaml
      ];
    })

    # what does  this even do??
    (mkIf cfg.xdg.enable {

    })
  ];
}
