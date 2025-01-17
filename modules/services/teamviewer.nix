{hey, options, config, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.services.teamviewer;
in {
  options.modules.services.teamviewer = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.teamviewer.enable = true;
  };
}
