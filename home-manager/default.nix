{ config, pkgs, inputs, ... }:
{
  imports = [
   ../modules/home-manager/default.nix
  ];
  home.username = "gaupee";
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    (python313.withPackages (ps: [ ps.hvac ps.diagrams ]))
    ansible
    btop  # replacement of htop/nmon
    curl
    dnsutils  # `dig` + `nslookup`
    docker-compose
    ethtool
    foot
    fzf # A command-line fuzzy finder
    gawk
    gcc
    gh
    ghq
    git
    gnupg
    gnused
    gnutar
    govc
    iftop # network monitoring
    iotop # io monitoring
    jq # A lightweight and flexible command-line JSON processor
    k9s
    kdePackages.ksshaskpass
    kdePackages.xdg-desktop-portal-kde
    kubectl
    kubectx
    kubernetes-helm
    kubeswitch
    kustomize
    lm_sensors # for `sensors` command
    lsof # list open files
    minikube
    mongodb-compass
    mpv
    mtr # A network diagnostic tool
    networkmanager-openvpn
    nix-output-monitor
    oh-my-zsh
    pciutils # lspci
    popeye
    qpwgraph
    ripgrep # recursively searches directories for a regex pattern
    slack
    sysstat
    talosctl
    terraform
    terragrunt
    tmux
    tree
    trivy
    unzip
    usbutils # lsusb
    vault
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
      nixup   = "nixos-rebuild switch --sudo --flake ~/.config/nixos";
      nixtest   = "nixos-rebuild test --sudo --flake ~/.config/nixos";
      s = "switch";
      tgp = "terragrunt plan";
      tgpa = "terragrunt plan --all";
      tga = "terragrunt apply";
      tgaa = "terragrunt apply --all";
      ghr = "gh fzf repo 4SH";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "terraform" "ansible" "tmux" "kube-ps1" "direnv"];
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
