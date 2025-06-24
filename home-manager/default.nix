{ config, pkgs, ... }:

{
  imports = [
   ../modules/home-manager/default.nix
  ];
  home.username = "gaupee";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    python313.withPackages (ps: [ ps.hvac ps.diagrams ])
    minikube
    qbittorrent
    kubectx
    mpv
    freecad
    qpwgraph
    vault
    prusa-slicer
    govc
    mongodb-compass
    kustomize
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
