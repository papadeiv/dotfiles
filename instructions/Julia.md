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
