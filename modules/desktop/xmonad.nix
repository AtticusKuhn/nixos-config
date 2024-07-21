{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.xmonad;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.xmonad = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    # modules.theme.onReload.bspwm = ''
    #   ${pkgs.bspwm}/bin/bspc wm -r
    #   source $XDG_CONFIG_HOME/bspwm/bspwmrc
    # '';

    environment.systemPackages = with pkgs; [
      lightdm
      light
      # dunst
      libnotify
      haskellPackages.xmobar
      # (polybar.override {
      #   pulseSupport = true;
      #   nlSupport = true;
      # })
    ];

    services = {
      picom.enable = true;
      redshift.enable = true;
      xserver = {
        # this enables mouse touchap???
        libinput.enable = true;
        enable = true;
        displayManager = {
          defaultSession = "none+xmonad";
          lightdm.enable = true;
          lightdm.greeters.mini.enable = true;
        };
        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
          config = builtins.readFile /home/atticusk/.xmonad/xmonad.hs;
          # libFiles  = {
          #   "Colors.hs" = /home/atticusk/.xmonad/lib/Colors.hs;
          # };
          # ghcArgs = [
          #   "-hidir /tmp" # place interface files in /tmp, otherwise ghc tries to write them to the nix store
          #   "-odir /tmp" # place object files in /tmp, otherwise ghc tries to write them to the nix store
          #   "-v"
          #   "-i /home/atticusk/.xmonad/lib" # tell ghc to search in the respective nix store path for the module
          # ];
        };
      };
    };

    # xsession.windowManager.xmonad.libFiles = {

    # };
    systemd.user.services."dunst" = {
      enable = true;
      description = "";
      wantedBy = [ "default.target" ];
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
    };

    # link recursively so other modules can link files in their folders
    # home.configFile = {
    #   "sxhkd".source = "${configDir}/sxhkd";
    #   "bspwm" = {
    #     source = "${configDir}/bspwm";
    #     recursive = true;
    #   };
    # };
  };
}
