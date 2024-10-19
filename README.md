# Nix-Darwin Installation Guide

## Step 1:

Need to have installed nix first.

```
sh <(curl -L https://nixos.org/nix/install)
```

To test that it is intalled, you have to run this one line at  a time.:

```
nix-shell -p cowsay --extra-experimental-features flakes
cowsay moo
exit
cowsay moo
```

next:
```
mkdir ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

nix-env -iA nixpkgs.git
git clone https://github.com/wgretz/nixos-config ~/.setup
cd ~/.setup
sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
nix build .#darwinConfigurations.<host>.system
./result/sw/bin/darwin-rebuild switch --flake .
```

this sets up your flake using your macbook's name.

```
nix run nix-darwin -- switch --flake ~/.setup
darwin-rebuild switch --flake ~/.setup
```

