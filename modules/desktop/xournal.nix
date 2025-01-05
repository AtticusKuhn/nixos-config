{hey, config, options, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.desktop.apps.xournal;
in {
  options.modules.desktop.apps.xournal = {
    enable = mkBoolOpt false;
  };
  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      xournalpp
    ];
  };
}
