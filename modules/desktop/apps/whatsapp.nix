{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.whatsapp;
in {
  options.modules.desktop.apps.whatsapp = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      whatsapp-for-linux
    ];
  };
}
