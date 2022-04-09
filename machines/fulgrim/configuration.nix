{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  hardware = {
    cpu.intel.updateMicrocode = true;
    opengl.enable = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    autoOptimiseStore = true;
  };

  boot = {
    initrd = {
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/local/root@blank
      '';

      luks.devices.cryptroot.device = "/dev/disk/by-uuid/edc1d6b1-5fdf-4b5e-b441-74a23fa8124a";
    };

    loader = {
      timeout = 2;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  networking = {
    hostId = "20a484ee";
    hostName = "fulgrim";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 5900 ];
  };

  time.timeZone = "Europe/Ljubljana";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    sudo = {
      # Don't display a message when using sudo for the first time.
      extraConfig = ''
        Defaults lecture="never"
      '';
    };
  };

  # Needed for user passwords.
  fileSystems."/persist".neededForBoot = true;

  sops = {
    defaultSopsFile = ../../secrets.yaml;

    # Don't import any SSH keys for decryption.
    gnupg.sshKeyPaths = [];
    age.sshKeyPaths = [];

    age.keyFile = "/persist/keys.txt";
    secrets = {
      np-hashed-password = {};
      np-hashed-password.neededForUsers = true;
    };
  };

  users = {
    mutableUsers = false;
    users = {
      np = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        passwordFile = config.sops.secrets.np-hashed-password.path;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      file
      ncdu
      tree
    ];

    etc = {
      # TODO: Doesn't work.
      # "machine-id" = {
      #  source = "/persist/etc/machine-id";
      #};

      "NetworkManager/system-connections".source = "/persist/etc/NetworkManager/system-connections";
    };
  };

  programs = {
    vim.defaultEditor = true;
  };

  services = {
    tlp.enable = true;

    zfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
      };
    };

    xserver = {
      enable = true;
      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
      xkbOptions = "ctrl:nocaps";

      displayManager.startx.enable = true;
      # windowManager.stumpwm.enable = true;
    };
  };

  system.stateVersion = "21.11";
}
