{hey, options, config, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.hardware.sensors;
in {
  options.modules.hardware.sensors = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = [ pkgs.lm_sensors ];
  };
}
