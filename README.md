# NixOS Configuration

## System Configuration

By default, the running system's host name will be used to select which configuration to build. This
is one of many cool features of Flakes -- it makes writing multi-system configurations a breeze.

```
[sudo] nixos-rebuild <command> --flake .
```

Depending on the used *command*, you might need superuser privileges.

## User Configuration

### Testing Configuration

To test if the current configuration builds successfully, use:

```
nix build .#homeConfigurations.<user>.activationPackage
```

This will report errors if there is something wrong with the configuration, otherwise it is going to
build and create a `result` symlink. The following will allow you to investigate the generated
configuration before activating (applying it system-wide) it. If you want to activate it, run the
`result/activate` script, or use the command in the following section.

### Switching Configuration

To build the configuration and automatically activate it, use:

```
nix run .#homeConfigurations.<user>.activationPackage
```

Where *user* is the desired user's configuration. Users are listed in `flake.nix` under
`homeConfigurations`:

```
homeConfigurations = {
  np = home-manager.lib.homeManagerConfiguration { ... };
  ...
};
```

## Update Flakes

Channel updates are done a bit differently with Flakes, to be specific, they are done with the
following command:

```
nix flake update
```
