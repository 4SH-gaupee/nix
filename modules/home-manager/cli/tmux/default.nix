{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.cli.tmux;
in
{
  options.modules.cli.tmux = {
    enable = mkEnableOption "enable Tmux";
  };
  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      aggressiveResize = true;
      baseIndex = 1;
      customPaneNavigationAndResize = false;
      escapeTime = 0;
      focusEvents = true;
      keyMode = "vi";
      mouse = true;
      prefix = "C-a";
      terminal = "tmux-256color";
      extraConfig = ''
          unbind C-b
          set-option -g prefix M-a
          bind-key C-a send-prefix
          bind m copy-mode
          bind l paste-buffer
          # split panes using | and -
          bind ( split-window -h
          bind - split-window -v
          bind c new-window -c "#{pane_current_path}"
          unbind '"'
          unbind %

          # reload config file (change file location to your the tmux.conf you want to use)
          bind r source-file ~/.tmux.conf

          bind -n M-Left select-pane -L
          bind -n M-Right select-pane -R
          bind -n M-Up select-pane -U
          bind -n M-Down select-pane -D

          set -g mouse on
          set -g set-clipboard on
          set -g base-index 1
          setw -g pane-base-index 1
          # List of plugins
          set -g @plugin 'tmux-plugins/tpm'
          set -g @plugin 'tmux-plugins/tmux-sensible'
          set -g @plugin 'tmux-plugins/tmux-yank'
          # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
          run '~/.tmux/plugins/tpm/tpm'
      '';
      plugins = with pkgs; [
        tmuxPlugins.tmux-fzf
        tmuxPlugins.tmux-sensible
        tmuxPlugins.tmux-yank
      ];
    };
  };
}

