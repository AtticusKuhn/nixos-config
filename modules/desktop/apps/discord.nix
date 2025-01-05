{hey, config, options, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.desktop.apps.discord;
in {
  options.modules.desktop.apps.discord = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      dissent
    ];
    services.bitlbee = {
      enable = true;
      plugins = [
        pkgs.bitlbee-discord
      ];
    };
  };
}
