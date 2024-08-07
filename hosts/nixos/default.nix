{ hey, lib, ... }:
{
  imports = [
    ../home.nix
    /etc/nixos/hardware-configuration.nix
    # ./hardware-configuration.nix
  ];

  ## Modules
  modules = {
    desktop = {
      xmonad.enable = true;
      apps = {
        # godot.enable = true;
        thunderbird.enable = true;
        whatsapp.enable = true;
      };
      browsers = {
        default = "qutebrowser";
        # brave.enable = true;
        # firefox.enable = true;
        qutebrowser.enable = true;
      };
      media = {
        graphics.enable = true;

        graphics.raster.enable = true;
        # documents.enable = true;
        mpv.enable = true;
      };
      term = {
        default = "xst";
        st.enable = true;
      };
      vm = {
        # qemu.enable = true;
      };
    };
    dev = {
      # curse you, Cambridge!!
      java.enable = true;
      lean.enable = true;
      ocaml.enable = true;
      latex.enable = true;
      sqlite.enable = true;
      # node.enable = true;
      # rust.enable = true;
      # python.enable = true;
    };
    editors = {
      default = "emacs";
      emacs.enable = true;
      # idea.enable = true;
      # android-studio.enable = true;
      # vim.enable = true;
    };
    shell = {
      # adl.enable = true;
      # vaultwarden.enable = true;
      # direnv.enable = true;
      git.enable    = true;
      gnupg.enable  = true;
      # tmux.enable   = true;
      zsh.enable    = true;
    };
    services = {
      syncthing.enable = true;
      # ssh.enable = true;
      # docker.enable = true;
      # Needed occasionally to help the parental units with PC problems
      # teamviewer.enable = true;
    };
    theme.active = "alucard";
  };


  ## Local config
   ## Local config
  config = { pkgs, ... }: {
    # systemd.network.networks.wg0.address = [ "10.10.0.3/32" ];
  # programs.ssh.startAgent = true;
  # services.openssh.startWhenNeeded = true;

  networking.networkmanager.enable = true;
  # programs.nm-applet.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.pulseaudio.enable = true;
  # hardware.bluetooth.enable = true;
  #
  #This is for printing
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelParams = ["i915.force_probe=46a8"];
  };



   # users.users.atticusk.usersextraGroups = [ "networkmanager" "wheel" "audio" "sound" "video" ];
  ## Personal backups
  # Syncthing is a bit heavy handed for my needs, so rsync to my NAS instead.
  systemd = {
  #   services.backups = {
  #     description = "Backup /usr/store to NAS";
  #     wants = [ "usr-drive.mount" ];
  #     path  = [ pkgs.rsync ];
  #     environment = {
  #       SRC_DIR  = "/usr/store";
  #       DEST_DIR = "/usr/drive";
  #     };
  #     script = ''
  #       rcp() {
  #         if [[ -d "$1" && -d "$2" ]]; then
  #           echo "---- BACKUPING UP $1 TO $2 ----"
  #           rsync -rlptPJ --chmod=go= --delete --delete-after \
  #               --exclude=lost+found/ \
  #               --exclude=@eaDir/ \
  #               --include=.git/ \
  #               --filter=':- .gitignore' \
  #               --filter=':- $XDG_CONFIG_HOME/git/ignore' \
  #               "$1" "$2"
  #         fi
  #       }
  #       rcp "$HOME/projects/" "$DEST_DIR/projects"
  #       rcp "$SRC_DIR/" "$DEST_DIR"
  #     '';
  #     serviceConfig = {
  #       Type = "oneshot";
  #       Nice = 19;
  #       IOSchedulingClass = "idle";
  #       User = config.user.name;
  #       Group = config.user.group;
  #     };
  #   };
  #   timers.backups = {
  #     wantedBy = [ "timers.target" ];
  #     partOf = [ "backups.service" ];
  #     timerConfig.OnCalendar = "*-*-* 00,12:00:00";
  #     timerConfig.Persistent = true;
  #   };
  };
}
