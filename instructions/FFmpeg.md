# FFmpeg

## Generic command 
```bash
ffmpeg -framerate 30 -start_number 1 -i %d.png -frames:v 101 -c:v libx264 -pix_fmt yuv420p './output.webm'
```

where: 

* `start_number 100` specifies to start the animation at the frame `100.png`;
* `frames:v 101` specifies to end the animation at the frame `200.png`, i.e. including `101` frames in the animation starting from `100.png`;
* `c:v libx264` uses library `x264` to encode the video stream into the _H.264/MPEG-4 AVC_ compression format;
* `pix_fmt yuv420p` specifies to increase the compatibility of `output.webm` to a wider range of video players.

For a more broad type of numbering patters for the source images see [this guide](https://en.wikibooks.org/wiki/FFMPEG_An_Intermediate_Guide/image_sequence).

## Using a list file

### Images

```bash
ffmpeg -f concat -i list.txt -c copy './output.webm'
```

where the content of `list.txt` is as follows

```bash
file './1.png'
duration 2
file './2.png'
duration 5
...
file './.1000.png'
duration 2
```

### Videos

```bash
ffmpeg -f concat -i list.txt -c copy './output.webm'
```

where the content of `list.txt` is as follows

```bash
file './1.mp4'
file './2.mp4'
...
file './.10.mp4'
```
