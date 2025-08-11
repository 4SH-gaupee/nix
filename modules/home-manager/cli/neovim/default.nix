{ lib, pkgs, config, ... }:
with lib;
let
  nvim-spell-fr-utf8-dictionary = builtins.fetchurl {
    url = "https://ftp.nluug.nl/vim/runtime/spell/fr.utf-8.spl";
    sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
  };
  nvim-spell-fr-utf8-suggestions = builtins.fetchurl {
    url = "https://ftp.nluug.nl/vim/runtime/spell/fr.utf-8.sug";
    sha256 = "0294bc32b42c90bbb286a89e23ca3773b7ef50eff1ab523b1513d6a25c6b3f58";
  };
  nvim-k8s-lsp = pkgs.vimUtils.buildVimPlugin {
    pname = "nvim-k8s-lsp";
    version = "main";
    src = builtins.fetchGit {
      url = "https://github.com/tonychg/nvim-k8s-lsp.git";
      rev = "395f6d6b91da55c12b26a2ef1ace7a922a756712";
      ref = "main";
    };
  };
  telescope-cc = pkgs.vimUtils.buildVimPlugin {
    pname = "telescope-cc.nvim";
    version = "main";
    src = builtins.fetchGit {
      url = "https://github.com/olacin/telescope-cc.nvim.git";
      # Pin to a commit for reproducibility
      rev = "c3cf3489178f945e3efdf0bd15bfb8c353279755";
      ref = "main";
    };
  };
in
{
  options.modules.cli.neovim = {
    enable = mkEnableOption "enable Neovim text editor";
  };
  config = {
    home.file."${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = nvim-spell-fr-utf8-dictionary;
    home.file."${config.xdg.configHome}/nvim/spell/fr.utf-8.sug".source = nvim-spell-fr-utf8-suggestions;
    home.file."${config.xdg.configHome}/nvim/lsp/yaml.lua".source = ./files/lsp/yaml.lua;

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraPackages = with pkgs; [
        # LSP Servers
        ansible-language-server
        clang-tools
        hadolint
        helm-ls
        lua-language-server
        marksman
        nil
        nodePackages.bash-language-server
        python3Packages.python-lsp-server
        shellcheck
        terraform-lsp
        tflint
        yaml-language-server

        # Formatters
        hclfmt
        nixfmt-rfc-style
        prettierd
        shfmt
        xmlformat
      ];
      extraLuaConfig =
        (builtins.readFile ./files/options.lua)
        + (builtins.readFile ./files/keymaps.lua)
        + (builtins.readFile ./files/lsp.lua)
      ;
      plugins = with pkgs.vimPlugins; [
          {
            plugin = tokyonight-nvim;
            type = "lua";
            config = (builtins.readFile ./files/plugins/theme.lua);
          }

      	  { plugin = telescope-fzf-native-nvim;
	  }
      	  { plugin = nvim-lspconfig;
	  }
          {
            plugin = conform-nvim;
            type = "lua";
            config = (builtins.readFile ./files/plugins/conform.lua);
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            #config = (builtins.readFile ./files/plugins/lualine.lua);
          }
       #   {
       #    plugin = neo-tree-nvim;
       #    type = "lua";
       #    #config = (builtins.readFile ./files/plugins/neotree.lua);
       #   }
          {
            plugin = nvim-lint;
            type = "lua";
            #config = ( builtins.readFile ./files/plugins/nvim-lint.lua);
          }
          {
            plugin = (nvim-treesitter.withPlugins (p: [
                p.bash
                p.dockerfile
                p.hcl
                p.helm
                p.lua
                p.llvm
                p.markdown
                p.markdown_inline
                p.nix
                p.python
                p.terraform
                p.vim
                p.yaml
              ])
            );
            type = "lua";
            config = ( builtins.readFile ./files/plugins/treesitter.lua);
          }
          {
            plugin = nvim-treesitter-context;
            type = "lua";
            #config = ( builtins.readFile ./files/plugins/treesitter_context.lua);
         }
         {
           plugin = telescope-cc;
           type = "lua";
         }

         {
            plugin = vim-better-whitespace;
            type = "lua";
         }
        # {
        #    plugin = schemastore;
        #   type = "lua";
        # }
        #  {
        #    plugin = vim-fugitive;
        #    type = "lua";
	# }

        ];
    };
  };
}
