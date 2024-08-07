{hey, config, options, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.desktop.apps.skype;
in {
  options.modules.desktop.apps.skype = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      skypeforlinux
      skype_call_recorder
    ];
  };
}
