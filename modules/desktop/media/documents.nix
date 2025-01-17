# modules/desktop/media/docs.nix

{ hey, options, config, lib, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.desktop.media.documents;
in {
  options.modules.desktop.media.documents = {
    enable = mkBoolOpt false;
    pdf.enable = mkBoolOpt false;
    ebook.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      (mkIf cfg.ebook.enable calibre)
      (mkIf cfg.pdf.enable   evince)
      # zathura
    ];

    # TODO calibre/evince/zathura dotfiles
  };
}
