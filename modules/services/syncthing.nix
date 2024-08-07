{ hey, lib, config, options, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.services.syncthing;
in {
  options.modules.services.syncthing = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.syncthing = rec {
      enable = true;
      overrideDevices = true;
      overrideFolders = true;
      openDefaultPorts = true;
      user = "atticusk"; # config.user.name;
      systemService = true;
      group   = "wheel";
      dataDir = "/home/atticusk/Documents";    # Default folder for new synced folders
      configDir = "/home/atticusk/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys

      settings = {
        devices = {
          "FranTech VM" = { id = "RQMWALI-MXDP4A2-2ICYGEV-4XTAADG-G5G2E5I-GAMGX3J-4EBOA52-T77JJAK"; };
        };
        folders = {
          "org2" = {        # Name of folder in Syncthing, also the folder ID
            path = "/home/atticusk/org";    # Which folder to add to Syncthing
            devices = [ "FranTech VM"];      # Which devices to share the folder with
          };
          "org-roam-db" = {
            path = "/home/atticusk/.config/emacs/.local/cache";
              devices = ["FranTech VM"];
          };
        };
      };
    };
  };
}
