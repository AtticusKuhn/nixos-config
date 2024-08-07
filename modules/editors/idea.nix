{hey, config, options, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.editors.idea;
in {
  options.modules.editors.idea = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      jetbrains.idea-community
    ];
  };
}
