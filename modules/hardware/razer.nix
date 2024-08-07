# modules/hardware/razer.nix --- support for razer devices

{ hey, options, config, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.hardware.razer;
in {
  options.modules.hardware.razer = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hardware.openrazer.enable = true;

    user.extraGroups = [ "plugdev" ];

    environment.systemPackages = with pkgs; [
      # TODO Install polychromatic
    ];
  };
}
