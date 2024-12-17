# When I'm stuck in the terminal or don't have access to Emacs, (neo)vim is my
# go-to. I am a vimmer at heart, after all.

{ hey, lib, config, options, pkgs, ... }:

with lib;
with hey.lib;
let cfg = config.modules.editors.vscode;
in {
  options.modules.editors.vscode = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        jymeng.leuven-vscode
        vscodevim.vim
        yzhang.markdown-all-in-one
        lean4.leanprover
        copilot-arena.copilot-arena
        esbenp.prettier-vscode
      ];
    };
    # user.packages = with pkgs; [
    #   (vscode-with-extensions.override {
    #     vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    #       {
    #         name = "lean4";
    #         publisher = "leanprover";
    #         version = "latest";
    #         sha256 = "sha256-V2ZjimjLdWjy2ARQY9d5bASOxImVQcSVY/sqMIogiDw=";
    #       }
    #     ];
    #   })
    # ];

    # This is for non-neovim, so it loads my nvim config
    # env.VIMINIT = "let \\$MYVIMRC='\\$XDG_CONFIG_HOME/nvim/init.vim' | source \\$MYVIMRC";

    # environment.shellAliases = {
    #   vim = "nvim";
    #   v   = "nvim";
    # };
  };
}
