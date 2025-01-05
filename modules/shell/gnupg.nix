{ hey, lib, config, options, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.shell.gnupg;
in {
  options.modules.shell.gnupg = with types; {
    enable   = mkBoolOpt false;
    cacheTTL = mkOpt int 3600;  # 1hr
  };

  config = mkIf cfg.enable {
    environment.sessionVariables.GNUPGHOME = "$HOME/.config/gnupg";

    # systemd.user.services.gpg-agent.serviceConfig.Environment = [
    #   "GNUPGHOME=${config.home.configDir}/gnupg"
    # ];

    programs.gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gnome3;


        # pinentryPackage = pkgs.pinentry-rofi.override {
        #   rofi = if config.modules.desktop.type == "wayland"
        #          then pkgs.rofi-wayland-unwrapped
        #          else pkgs.rofi;
        # };
      };
      # There's a release between 2.2 and 2.4 where GPG is broken. Rather than
      # risk hitting it, I'm installing GnuPG from nixos-unstable.
      package = pkgs.unstable.gnupg;
    };
    user.packages = [
      pkgs.pinentry-gnome3
    ];

    home.configFile."gnupg/gpg-agent.conf".text = ''
      default-cache-ttl ${toString cfg.cacheTTL}
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };
}
