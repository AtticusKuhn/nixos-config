# Emacs is my main driver. I'm the author of Doom Emacs
# https://github.com/doomemacs. This module sets it up to meet my particular
# Doomy needs.

{ hey, lib, config, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.editors.emacs;
    emacs = with pkgs; (emacsPackagesFor
      (if config.modules.desktop.type == "wayland"
       then emacs-pgtk
       else emacs-git)).emacsWithPackages
      (epkgs: []);
in {
  options.modules.editors.emacs = {
    enable = mkBoolOpt false;
<<<<<<< HEAD
    doom = rec {
      enable = mkBoolOpt false;
      # forgeUrl = mkOpt types.str "https://github.com";
      # repoUrl = mkOpt types.str "${forgeUrl}/doomemacs/doomemacs";
      # configRepoUrl = mkOpt types.str "${forgeUrl}/hlissner/doom-emacs-private";
    };
=======
    # doom = rec {
    #   enable = mkBoolOpt false;
    #   forgeUrl = mkOpt types.str "https://github.com";
    #   repoUrl = mkOpt types.str "${forgeUrl}/doomemacs/doomemacs";
    #   configRepoUrl = mkOpt types.str "${forgeUrl}/hlissner/.doom.d";
    # };
>>>>>>> origin
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      hey.inputs.emacs-overlay.overlays.default
    ];

    user.packages = with pkgs; [
      (mkLauncherEntry "Emacs (Debug Mode)" {
        description = "Start Emacs in debug mode";
        icon = "emacs";
        exec = "${emacs}/bin/emacs --debug-init";
      })

      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
<<<<<<< HEAD
      # 28.2 + native-comp
      ((emacsPackagesFor emacs-unstable).emacsWithPackages
        (epkgs: [ epkgs.vterm ]))
=======
      # HEAD + native-comp
      emacs
>>>>>>> origin

      ## Doom dependencies
      git
      ripgrep
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      (mkIf (config.programs.gnupg.agent.enable)
        pinentry-emacs)   # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
<<<<<<< HEAD
      # This is used for telega.el, which is a telegram client
      tdlib
      # also for telege.el/??
      emacsPackages.telega

=======
      # :lang beancount
      beancount
      fava
      # :lang nix
      age
>>>>>>> origin
    ];

    environment.variables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    modules.shell.zsh.rcFiles = [ "${hey.configDir}/emacs/aliases.zsh" ];

<<<<<<< HEAD
    fonts.packages = [ pkgs.emacs-all-the-icons-fonts ];

    services.xserver.displayManager.sessionCommands = ''
    emacs --daemon &
    '';
    system.userActivationScripts = mkIf cfg.doom.enable {
      installDoomEmacs = ''
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
           git clone --depth=1 --single-branch "${cfg.doom.repoUrl}" "$XDG_CONFIG_HOME/emacs"
        fi
      '';
    };
=======
    fonts.packages = [
      (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
>>>>>>> origin
  };
}
