{ config, pkgs, inputs, ... }:
{
  imports = [
   ../modules/home-manager/default.nix
    #   inputs.walker.homeManagerModules.default
  ];
  home.username = "gaupee";
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    (python313.withPackages (ps: [ ps.hvac ps.diagrams ]))
    minikube
    qbittorrent
    foot
    gh
    ghq
    kubectx
    mpv
    networkmanager-openvpn
    qpwgraph
    vault
    trivy
    bitwarden-cli
    buildpack
    prusa-slicer
    govc
    mongodb-compass
    kustomize
    docker-compose
    ansible
    btop  # replacement of htop/nmon
    curl
    dnsutils  # `dig` + `nslookup`
    popeye
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
    kdePackages.ksshaskpass
    kdePackages.xdg-desktop-portal-kde
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
    # Hyprland
    waybar
    dunst
    walker
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
      nixup   = "nixos-rebuild switch --sudo --flake ~/.config/nixos";
      s = "switch";
      tgp = "terragrunt plan";
      tgpa = "terragrunt plan --all";
      tga = "terragrunt apply";
      tgaa = "terragrunt apply --all";
      ghr = "gh fzf repo 4SH";
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


  ###   HYPRLAND

  #  programs.walker = {
  #  enable = true;
  #  runAsService = true;
  #
  #  # All options from the config.json can be used here.
  #  config = {
  #    search.placeholder = "Example";
  #    ui.fullscreen = true;
  #    list = {
  #      height = 200;
  #    };
  #    websearch.prefix = "?";
  #    switcher.prefix = "/";
  #  };
  #
  #  };

  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland.enable = true; # enable Hyprland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = nm-applet --indicator
  '';

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    input = {
      kb_layout = "fr";
    };

    bind =
      [
        "$mod, F, exec, firefox"
	"$mod, T, exec, kitty"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
	      "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
	      "$mod, R, exec, walker"
	      "$mod, M, exec, wlogout --protocol layer-shell"
	      "$mod, Q, killactive,"
            ]
          )
          9)
      );
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
