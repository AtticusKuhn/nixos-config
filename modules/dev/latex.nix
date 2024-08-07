{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.latex;
in {
  options.modules.dev.latex = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = [
        # (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-medium xifthen ifmtarg lazylist environ bbding xstring beamertheme-metropolis catchfile polytable caption catchfilebetweentags datetime2 enumitem geometry natbib newunicodechar relsize tikz-cd xcolor graphviz todonotes pgfopts tcolorbox wrapfig ; })
        (pkgs.texlive.combine { inherit (pkgs.texlive)
          scheme-medium wrapfig xifthen;
        })
      ];
    })

    # what does  this even do??
    (mkIf cfg.xdg.enable {

    })
  ];
}
