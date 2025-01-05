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


    user.packages = with pkgs; [
      (unstable.vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
    # programs.vscode = {
      # enable = true;
      # extensions = with pkgs.vscode-extensions; [
        # dracula-theme.theme-dracula
        # jymeng.leuven-vscode
        vscodevim.vim
        yzhang.markdown-all-in-one
        esbenp.prettier-vscode
        # GitHub.copilot
        # Codeium.codeium
        charliermarsh.ruff
        ms-python.python
        njpwerner.autodocstring
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
            name = "lean4";
            publisher = "leanprover";
            version = "latest";
            sha256 = "sha256-lkfMDIed+jw+5tnitv9V68BoohRwsIbAJ/7syDlo9KQ=";
        }
        {
            name = "copilot-arena";
            publisher = "copilot-arena";
            version = "latest";
            sha256 = "sha256-Qepv/wZBb7HlMXt7AWvKHnr/A3luWqgYDJjnrVF5qow=";
        }
        {
            name = "copilot";
            publisher = "GitHub";
            version = "latest";
            sha256 = "sha256-IeMjtWuJuPWbwWsGB96GjddK/G3zW49VoTWqD/Z1TQk=";
        }
        {
            name = "copilot-chat";
            publisher = "GitHub";
            version = "latest";
            sha256 = "sha256-30NR3ivGm68+eEaaJ8DtLsrran/YsawiqbWoOVheHgw=";
        }
        {
            name = "codeium";
            publisher = "Codeium";
            version = "latest";
            sha256 = "sha256-Ir7zTObo1FEZnFChc755Ldg3RNnV+3H9zLWjBZBQSzY=";
        }
        {
            name = "claude-dev";
            publisher = "saoudrizwan";
            version = "latest";
            sha256 = "sha256-v/qG0afyzRJbbWPcoIgQ8n9oPqegY0+Cxy94BpsoSGM=";
        }
      ];
      })
    ];
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
