# Arch User Repository (AUR)

The [https://wiki.archlinux.org/title/Arch_User_Repository](AUR) is an online repository of unofficial packages developed and mantained by a community or [./ArchLinux.md](Arch) users.

## Search
Go to [https://aur.archlinux.org/](AUR home), type the name of the package in the search box in the top right and click on one of the search results.

The package details will show you the `<app>` name to be used by an AUR helper such as `yay` to easily install it.

This would be the string at the __Package Base__ voice.

## Install
Installation of packages from AUR can be done the [https://wiki.archlinux.org/title/Arch_User_Repository#Installing_and_upgrading_packages](hard way) or the by use of an [https://wiki.archlinux.org/title/AUR_helpers](AUR helper) such as `yay`.

Once identified the `<app>` package name under __Package Base__ on the AUR (as explained above) run

```bash
sudo yay -Ss <app>
```

to validate that the description and update version matches the online one and then

```bash
sudo yay -S <app>
```

to download and install it, or

```bash
sudo yay -Syu <app>
```

to do so after system update and upgrade.

### Other commands
- `yay` = alias of `yay -Syu` which performs systems upgrade in the same way that `pacman -Syu does`
- `yay -Ps` = list all currently installed packages 
- `yay -Ssq <app>` = search all packages in the AUR that match `<app>`
- `yay -Yc` = remove unneded dependencies
