{hey, options, config, lib, pkgs, ... }:

with lib;
with hey.lib;
let hwCfg = config.modules.hardware;
    cfg = hwCfg.bluetooth;
in {
  options.modules.hardware.bluetooth = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
  };
}
