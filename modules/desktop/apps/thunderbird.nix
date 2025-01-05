{hey, config, options, lib, pkgs,home-manager, ... }:

with lib;
with hey.lib;
let cfg = config.modules.desktop.apps.thunderbird;
  # Inspiration: https://github.com/NixOS/nixpkgs/issues/108480#issuecomment-1115108802
  # isync-oauth2 = with pkgs; buildEnv {
  #   name = "isync-oauth2";
  #   paths = [ isync ];
  #   pathsToLink = ["/bin"];
  #   nativeBuildInputs = [ makeWrapper ];
  #   postBuild = ''
  #       wrapProgram "$out/bin/mbsync" \
  #         --prefix SASL_PATH : "${cyrus_sasl}/lib/sasl2:${cyrus-sasl-xoauth2}/lib/sasl2"
  #     '';
  # };
in {
  options.modules.desktop.apps.thunderbird = {
    enable = mkBoolOpt false;
  };


  config = mkIf cfg.enable {

  user.packages = with pkgs; [
    thunderbird
    # isync-oauth2 oauth2ms
    # oauth2
    (isync.override { withCyrusSaslXoauth2 = true; })

  ];
    # programs.thunderbird = {};
    home-manager.users.atticusk = {
      # programs.thunderbird = {
        # enable = true;
        # profiles = {
        #   cambridge = {};
        #   euler = {};
        #   gmail = {
        #     isDefault = true;
        #   };
        #   frantech = {};
        # };
      # };
      accounts.email.accounts = {
        cambridge =  {
          address = "ak2518@cam.ac.uk";
          # thunderbird.enable = true;
          realName = "Atticus Kuhn";
        };
        euler = {
          address = "eulerthedestroyer@gmail.com";
          # thunderbird.enable = true;
          realName = "Atticus Kuhn";
        };
        gmail = {
          address = "atticusmkuhn@gmail.com";
          # thunderbird.enable = true;
          primary = true;
          realName = "Atticus Kuhn";
        };
        frantech = {
          address = "atticusmkuhn@atticusmkuhn.com";
          # thunderbird.enable = true;
          realName = "Atticus Kuhn";
        };
      };
    };
  };
}
