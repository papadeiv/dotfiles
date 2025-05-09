# Spicetify

## Configuration
1. Give permission to write on `spotity` files
```bash
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
```
2. Generate the `config` file
```bash
spicetify
```
3. Enable `devtools` for customisation
```bash
spicetify backup apply enable-devtools
```
4. Install `spicetify-themes`
```bash
git clone --depth=1 https://github.com/spicetify/spicetify-themes.git
cd spicetify-themes
cp -r * ~/.config/spicetify/Themes
```
5. Select and apply a [theme](https://github.com/spicetify/spicetify-themes/blob/master/THEMES.md) and color scheme 
```bash
spicetify config current_theme text 
spicetify config color_scheme CatppuccinMacchiato 
```
