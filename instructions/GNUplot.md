# GNUplot

```bash
set terminal png enhanced size 1200,1200
set output "file.png"
set xlabel "x-axis" font ",12" offset 
set xtics  font ",12"
set xrange [1:20]
set ylabel "y-axis" font ",12" offset 
set ytics (1e-16,1) font ",12"
set yrange [1e-16:1]
set grid
set logscale y
plot "file.txt" w l lw 3 notitle
plot "file1" wl lw 3 title "1", "file2" wl lw 3 title "2" 
```
