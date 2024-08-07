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

<<<<<<< HEAD
    programs.gnupg.agent =  {
      enable = true;
      # pinentryFlavor = "gtk2";
    };

    user.packages = [ pkgs.tomb  pkgs.cyrus-sasl-xoauth2 pkgs.cyrus_sasl ];
    services.pcscd.enable = true;


    # HACK Without this config file you get "No pinentry program" on 20.03.
    #      programs.gnupg.agent.pinentryFlavor doesn't appear to work, and this
    #      is cleaner than overriding the systemd unit.
    home.configFile."gnupg/gpg-agent.conf" = {
      text = ''
        default-cache-ttl ${toString cfg.cacheTTL}
        pinentry-program ${pkgs.pinentry.gtk2}/bin/pinentry
      '';
=======
    # systemd.user.services.gpg-agent.serviceConfig.Environment = [
    #   "GNUPGHOME=${config.home.configDir}/gnupg"
    # ];

    programs.gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-rofi.override {
          rofi = if config.modules.desktop.type == "wayland"
                 then pkgs.rofi-wayland-unwrapped
                 else pkgs.rofi;
        };
      };
      # There's a release between 2.2 and 2.4 where GPG is broken. Rather than
      # risk hitting it, I'm installing GnuPG from nixos-unstable.
      package = pkgs.unstable.gnupg;
>>>>>>> origin
    };

    home.configFile."gnupg/gpg-agent.conf".text = ''
      default-cache-ttl ${toString cfg.cacheTTL}
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };
}
