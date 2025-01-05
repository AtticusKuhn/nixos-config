{hey, config, options, lib, pkgs, ... }:

with lib;
with hey.lib;
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
          scheme-full wrapfig xifthen capt-of cleveref thmtools mdframed;

        })
      ];
    })

    # what does  this even do??
    (mkIf cfg.xdg.enable {

    })
  ];
}
