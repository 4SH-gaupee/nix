{ config, pkgs, ... }:

{
  home.username = "gaupee";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    minikube
    qbittorrent
    mpv
    qpwgraph
    vault
    super-slicer-latest
    govc
    mongodb-compass
    docker-compose
    ansible
    btop  # replacement of htop/nmon
    curl
    dnsutils  # `dig` + `nslookup`
    ethtool
    fzf # A command-line fuzzy finder
    talosctl
    gawk
    gcc
    git
    gnupg
    gnused
    gnutar
    iftop # network monitoring
    iotop # io monitoring
    jq # A lightweight and flexible command-line JSON processor
    k9s
    k9s
    kdePackages.ksshaskpass
    kubectl
    kubeswitch
    lm_sensors # for `sensors` command
    lsof # list open files
    mtr # A network diagnostic tool
    nix-output-monitor
    oh-my-zsh
    pciutils # lspci
    ripgrep # recursively searches directories for a regex pattern
    slack
    sysstat
    terraform
    terragrunt
    tmux
    tree
    unzip
    kubernetes-helm
    usbutils # lsusb
    wget
    which
    yq-go # yaml processor https://github.com/mikefarah/yq
    zig
 ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Gwendal AUPEE";
    userEmail = "gwendal.aupee@4sh.fr";
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history.ignoreDups = true;
    history.extended = true;
    shellAliases = {
      nixedit = "nvim ~/.config/nixos";
      nixup   = "nixos-rebuild switch --use-remote-sudo --flake ~/.config/nixos";
      s = "switch";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "terraform" "ansible" "tmux" "kube-ps1"];
      theme = "ys";
    };
    initExtra = ''
      PROMPT='$(kube_ps1)'$PROMPT
      source <(switcher init zsh)
      source <(switch completion zsh)
    '';
  };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraPackages = with pkgs; [
        # LSP Servers
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
	ansible-language-server

        # Formatters
        nixfmt-rfc-style
	hclfmt
	xmlformat
        shfmt
	prettierd
      ];
      plugins = with pkgs.vimPlugins; [
          {
            plugin = conform-nvim;
            type = "lua";
            #config = (builtins.readFile ./files/plugins/conform.lua);
          }
          {
            plugin = fzf-lua;
            type = "lua";
            #config = (builtins.readFile ./files/plugins/fzf-lua.lua);
          }
          {
            plugin = gitsigns-nvim;
            type = "lua";
            #config = (builtins.readFile ./files/plugins/luasnip.lua);
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            #config = (builtins.readFile ./files/plugins/lualine.lua);
          }
          {
           plugin = neo-tree-nvim;
           type = "lua";
           #config = (builtins.readFile ./files/plugins/neotree.lua);
          }
          {
            plugin = nvim-lint;
            type = "lua";
            #config = ( builtins.readFile ./files/plugins/nvim-lint.lua);
          }
          {
            plugin = nvim-sops;
            type = "lua";
            #config = (builtins.readFile ./files/plugins/nvim-sops.lua);
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
            #config = ( builtins.readFile ./files/plugins/treesitter.lua);
          }
          {
            plugin = nvim-treesitter-context;
            type = "lua";
            #config = ( builtins.readFile ./files/plugins/treesitter_context.lua);

          }
        ];

  };


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
