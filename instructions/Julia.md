# Julia

## Installation (Ubuntu and Debian only, skip if on Arch)
1. Download
```bash
curl -fsSL https://install.julialang.org | sh -s -- --add-to-path=yes
```
2. Create symlink
```bash
sudo mkdir -p /usr/local/lib/julia/bin/
sudo ln -s ~/.julia/juliaup/julia-1.10.0+0.x64.linux.gnu/bin/julia /usr/local/lib/julia/bin
```

### Installation on a server
1. Do step one
2. Launch Julia from the binary
```bash
ls -a
cd ./.juliaup/bin/
./julia
```
3. Clone a GitHub repository (to do that you need to authenticate first, check the __Configuration__ paragraph in [GitHub](GitHub.md))
```bash
git clone git@github.com:papadeiv/STEWS.git
```
4. Since you now have launched it from the `./juliaup/bin/` directory you now have to point to where the scripts you want to launch are located
```bash
cd(raw"../../STEWS/path_to_script/")
```
5. Now you can execute the script
```bash
include("./your_script.jl")
```

## Configuration 
1. Launch the REPL from the terminal
```bash
julia
```
2. Go into Package Manager mode by typing `]`

3. Type the following
```bash
add ModelingToolkit DifferentialEquations DomainSets MethodOfLines LinearAlgebra Statistics StatsBase LsqFit Roots ForwardDiff Integrals Polynomials DataFrames Tables CSV PyCall CairoMakie Makie LaTeXStrings TerminalLoggers ProgressMeter Suppressor 
```
4. Type `backspace` to go back in Prompt mode and execute `include("filename.jl")`

5. Type `ctrl + d` to exit the REPL

## Package development

1. Use `PkgTemplates` to create a scaffold `Julia` package.

```julia
using PkgTemplates

t = Template(;
             user="papadeiv",
             dir="~/Libraries",
             authors="Davide Papapicco",
             julia=v"1.11",
             plugins=[
                      Tests(),
                      Readme(; inline_badges=true),
                      License(; name="MIT"),
                      Git(; manifest=true, ssh=true),
                      GitHubActions(; osx=true, windows=true, x86=true, extra_versions=["1.10"]),
                      !TagBot,
                      !Dependabot
                     ],
            )
```

2. Create the package

```julia
t("MyPackage")
```

then access it 

```bash
cd ~/Libraries/MyPackage
```

and finally activate it and add runtime dependencies to it

```julia
using Pkg

Pkg.activate(".")
Pkg.add(["Makie", "CairoMakie"])
```

3. Write a minimal helper function in `MyPackage.jl` and add a test for it in `runtests.jl`
