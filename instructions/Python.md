# Python

## Installation
1. Install dependencies
```bash
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
```
2. Install Python3
```bash
wget https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tgz
sudo mv Python-3.10.13.tgz /usr/local/lib/ && cd /usr/local/lib/
tar -xf Python-3.10.13.tgz
rm -fr Python-3.10.13.tgz
cd Python-3.10.13/
./configure --prefix=/usr/local --enable-optimizations --enable-shared
make -j $(nproc)
sudo make altinstall
```
3. Install Anaconda
```bash
curl -O https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
bash Anaconda3-2019-Linux-x86.64.sh
```
Accept the terms and conditions and specify
```bash
/usr/local/lib/anaconda3
```
as the installation directory. Create a new virtual environment
```bash
conda create --name env_name
```
Install packages
```bash
conda env list
conda activate env_name
conda list
conda install numpy matplotlib pandas pytorch
conda deactivate 
```
Update and remove packages
```bash
conda search scikit-learn
conda update "scikit-learn>=1.11"
conda remove scikit-learn
```
