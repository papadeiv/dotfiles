# OpenFOAM

## Installation
1. Go to the [Gitlab development page](https://develop.openfoam.com/Development/openfoam/-/blob/master/doc/Build.md)
2. Check the `Requirements build` first and `OpenFOAM build` second
3. Download the `Source` archive and `Third Party` archive and put the latter into the former; the hierarchy should be: `/home/papadeiv/Librerie/OpenFOAM/ThirdParty`
4. Follow the steps in the `Quick Build Guide` doc on Gitlab

## ITHACA-FV
1. Clone the [repo](https://github.com/papadeiv/ITHACA-FV)
2. Compile using all the processors
```bash
git submodule update --init
source ~/Libraries/ITHACA-FV/etc/bashrc && cd ~/Libraries/ITHACA-FV
./Allwmake -j 4
```
3. Pull the development branch
```bash
git remove add ithaca-fv "https://github.com/ithaca-fv/ITHACA-FV"
git pull
git checkout --track origin/NNsPOD-Galerkin
```
4. Work on the branch and commit the changes; once done
```bash
git checkout master
git fetch ithaca-fv
git pull ithaca-fv master
git checkout NNsPOD-Galerkin
git rebase master NNsPOD-Galerkin
git push -f origin NNsPOD-Galerkin 
```
