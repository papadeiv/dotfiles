# Pacman

A `pacman` call should look something like this
```bash
sudo pacman <operation> [options] [target(s)]
```

## Common combinations
Here's a list of the commands you'll likely use most of the time. For a short description of the entries scroll further down or run `man pacman`.
- `sudo pacman -S <app>` = download and install `<app>` and its dependencies 
- `sudo pacman -Ss <app>` = search for all database matches for `<app>`
- `sudo pacman -Syu <app>` = update database, updgrade all installed packages and then download and install `<app>` and its dependencies
- `sudo pacman -Qqe` = list all the packages currently installed 
- `sudo pacman -Ql <app> | grep /usr/bin` = list all the `<bin>` files installed by a package `<app>` 
- `sudo pacman -Qo <bin>` = returns the package `<app>` that owns the `<bin>` file 
- `sudo pacman -Rns <app>` = uninstall `<app>` and all ancillary packages and then remove all its config files 

## Operations
- `Q` = query the database of installed package files
- `S` = sync packages and their dependencies
- `R` = remove a certain package

## Options

### With `Sync` operation
- `c` = clean-up disk space by removing packages no longer installed 
- `s` = search packages in the database 
- `u` = upgrade all packages in the database 
- `y` = refresh master package database

### With `Remove` operation
- `n` = ignore file backup 
- `s` = recursively remove targets and dependencies 
- `n` = ignore file backup 
