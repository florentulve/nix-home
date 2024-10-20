{ config, pkgs, lib, extraSpecialArgs, ... }:

{
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "flo";
  home.homeDirectory = "/home/flo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    hello
    devbox
    chezmoi
    mise
    usage
    rclone
    just
    dive
    grype
    syft
    nodejs_22
    jdk22
    #distrobox #broken mount /nix
    go-task
    just
    jq
    cheat
    tldr
    starship
    lazygit
    gum
    delta
    atuin
    kubectl
    krew
    k9s
    k3d
    kind
    minikube
    kubescape
    kubectl
    krew
    zellij
    fenix.stable.completeToolchain

    (nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" "DroidSansMono" "JetBrainsMono" "Hack" "UbuntuMono" "IosevkaTerm" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/flo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  #home.activation.chezmoi-dotfiles = lib.hm.dag.entryAfter [ "installPackages" ] ''
  #  #echo -e "\033[0;34mActivating chezmoi"
  #  #echo -e "\033[0;34m=================="
  #  echo "${config.home.path}"
  #  PATH="${config.home.path}/bin:/usr/bin/:$PATH" $DRY_RUN_CMD ${pkgs.chezmoi}/bin/chezmoi init --apply --force --verbose -S ${config.home.homeDirectory}/Documents/Sync/Workspace/chezmoi
  #  #echo -e "\033[0;34m=================="
  #'';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "sudo"
          "starship"
        ];
      };
    };
  };

  programs.krewfile = {
    enable = true;
    upgrade = true;
    krewPackage = pkgs.krew;
    plugins = [
      "kc"
      "oidc-login"
      "access-matrix"
      "ns"
      "popeye"
      "neat"
      "sniff"
      "outdated"
      "who-can"
    ];
  };
}
