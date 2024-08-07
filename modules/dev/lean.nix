{ hey,config, options, lib, pkgs, ... }:

with lib;
with hey.lib;
let devCfg = config.modules.dev;
    cfg = devCfg.lean;
in {
  options.modules.dev.lean = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {

      user.packages = [
        pkgs.elan
      ];
    })

    # what does  this even do??
    (mkIf cfg.xdg.enable {

    })
  ];
}
