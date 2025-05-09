# pde2path

## Installation
1. Download the repos `pde2path` and `ilupack` from drive.
2. 

## Structure
* The `pde2path/html` subfolder contains useful help menus you want to check out, especially the `demos.html` guide (__Warning__: to be able to visualize the `html` files you should run `setpde2path` first as explained below in the __Setup__ section).
* The `pde2path/demos` subfolder contains tutorials on various equations and PDEs phenomena. In particular:
  * the `acsuite` directory contains various [Allen-Cahn models](ACequation.md);
  * the `hopf` directory contains examples focuing on the continuation of [periodic orbits](PeriodiOrbit.md) out of [Hopf bifurcations](HopfBifurcation.md);
  * the `pftut` directory contains tutorials concerned with pattern formations out of [Turing bifurcations](TuringBifurcation.md) and in particular the `pftut/sh` subdirectory contains examples for the [Swift-Hohenberg model](SHequation).

All the above `demos` subdirectories already each contains a `pdf` guide explaining the setup for the simulations in each folder. Other guides for the remaining examples can be founde [here](https://www.staff.uni-oldenburg.de/hannes.uecker/pde2path/tutorials.html). 

## Setup
After starting `matlab` from the terminal use the folder navigator on the left to go to `pde2path`; once there run `setpde2path` on the command window. 

If the program has been installed correctly the prompt should say
```bash
pde2path, v3.1. Setting library path beginning with /home/pde2path
Setting additional libraries /home/ilupackV2.4_GNU64_long_MUMPS/mex
using ilupack from tu-BS
```

## Case setup
1. Create a folder in the `pde2path/demos` subdir
2. The hierarchy in such folder is
- `cmds1d.m` for the simulation commands (continuation runs and plots of bifurcation diagrams)
  - `shinit.m` for initialising the fields of the `problem` structure (see `pde2path/Quickstart guide.pdf`)
    - `sG.m` for computing the rhs operator
    - `sGjac.m` for computing the Jacobian of the rhs
      - `njac.m` for the numerical approximation of the Jacobian of the rhs
    - `shbra1d.m`
      - `shJ.m`
