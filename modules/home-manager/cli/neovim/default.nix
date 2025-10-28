{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  nvim-spell-fr-utf8-dictionary = builtins.fetchurl {
    url = "https://ftp.nluug.nl/vim/runtime/spell/fr.utf-8.spl";
    sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
  };
  nvim-spell-fr-utf8-suggestions = builtins.fetchurl {
    url = "https://ftp.nluug.nl/vim/runtime/spell/fr.utf-8.sug";
    sha256 = "0294bc32b42c90bbb286a89e23ca3773b7ef50eff1ab523b1513d6a25c6b3f58";
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
  kustomize = pkgs.vimUtils.buildVimPlugin {
    pname = "kustomize.nvim";
    buildInputs = [pkgs.vimPlugins.luasnip pkgs.vimPlugins.plenary-nvim];
    version = "main";
    src = builtins.fetchGit {
      url = "https://github.com/Allaman/kustomize.nvim";
      ref = "refs/tags/v6.0.0";
      rev = "0359d57bbd842b3ab9957d927f1bcd0558f55903";
    };
  };

  nvim-k8s-lsp = pkgs.vimUtils.buildVimPlugin {
    pname = "nvim-k8s-lsp";
    version = "main";
    src = builtins.fetchGit {
      url = "https://github.com/tonychg/nvim-k8s-lsp.git";
      rev = "1dffda65f4fe117f67514ed5d93b18f62be1ef24";
      ref = "main";
    };
  };

  ## Dynamically create LSP servers configurations list regarding
  ## files in `./files/lsp`
  lspConfigFiles = lib.mapAttrs' (
    k: _:
      lib.nameValuePair
      "${config.xdg.configHome}/nvim/lsp/${k}"
      {source = ./files/lsp/${k};}
  ) (builtins.readDir ./files/lsp);

  ## This variable contains neovim LSP activations
  lspLuaConfig = lib.attrsets.mapAttrsToList (
    k: v: "vim.lsp.enable('${lib.removeSuffix ".lua" k}')"
  ) (builtins.readDir ./files/lsp);
in {
  options.modules.cli.neovim = {
    enable = mkEnableOption "enable Neovim text editor";
  };
  config = {
    home.file =
      lspConfigFiles
      // {
        "${config.xdg.configHome}/nvim/spell/fr.utf-8.spl".source = nvim-spell-fr-utf8-dictionary;
        "${config.xdg.configHome}/nvim/spell/fr.utf-8.sug".source = nvim-spell-fr-utf8-suggestions;
      };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraPackages = with pkgs; [
        # LSP Servers
        lua-language-server
        python3Packages.python-lsp-server
        yaml-language-server
        tofu-ls
        helm-ls
        tflint
        vscode-langservers-extracted

        prettierd
        xmlformat
        alejandra
        shfmt
        yamlfmt
      ];
      extraLuaConfig =
        (builtins.readFile ./files/options.lua)
        + (builtins.readFile ./files/keymaps.lua)
        + ''
          ${lib.concatStringsSep "\n" lspLuaConfig}
        '';
      plugins = with pkgs.vimPlugins; [
        SchemaStore-nvim
        blink-emoji-nvim
        blink-cmp-dictionary
        lazydev-nvim
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = ''
            local autopair = require("nvim-autopairs").setup {}
          '';
        }
        {
          plugin = tokyonight-nvim;
          type = "lua";
          config = builtins.readFile ./files/plugins/theme.lua;
        }

        {
          plugin = telescope-fzf-native-nvim;
        }
        {
          plugin = luasnip;
        }
        {
          plugin = conform-nvim;
          type = "lua";
          config = builtins.readFile ./files/plugins/conform.lua;
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = builtins.readFile ./files/plugins/lualine.lua;
        }
        {
          plugin = (
            nvim-treesitter.withPlugins (p: [
              p.bash
              p.dockerfile
              p.hcl
              p.helm
              p.lua
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
          config = builtins.readFile ./files/plugins/treesitter.lua;
        }
        {
          plugin = telescope-cc;
          type = "lua";
          config = builtins.readFile ./files/plugins/telescope.lua;
        }
        {
          plugin = vim-better-whitespace;
          type = "lua";
        }
        {
          plugin = vim-fugitive;
          type = "lua";
        }
        {
          plugin = blink-cmp;
          type = "lua";
          config = builtins.readFile ./files/plugins/blink-cmp.lua;
        }
        {
          plugin = kustomize;
          type = "lua";
        }
        {
          plugin = nvim-lint;
          type = "lua";
          config = builtins.readFile ./files/plugins/lint.lua;
        }
        {
          plugin = nvim-k8s-lsp;
          type = "lua";
          config = builtins.readFile ./files/plugins/nvim-k8s-lsp.lua;
        }
        {
          plugin = yazi-nvim;
          type = "lua";
          config = builtins.readFile ./files/plugins/yazi.lua;
        }
      ];
    };
  };
}
