{hey, config, options, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.editors.android-studio;
in {
  options.modules.editors.android-studio = {
    enable = mkBoolOpt false;
  };

  # optios.android_sdk.accept_license = true;
  config = mkIf cfg.enable {
services.flatpak.enable = true;
xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # xdg.portal.config.common.default = "gtk";
    # android_sdk.accept_license = true;
environment.systemPackages = with pkgs; [
  android-studio
# ndroid-studio-stable
 # androidStudioPackages.dev
      # androidenv.androidPkgs_9_0.androidsdk
                                        ] ;
# android_sdk.accept_license = true;

    # user.packages = with pkgs; [
    #   android-studio
    #   androidenv.androidPkgs_9_0.androidsdk
    # ];
  };
}
