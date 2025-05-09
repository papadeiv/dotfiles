# GParted

## Flash clean a USB stick
1. Launch `gparted` from the terminal

2. Select the drive from the top right dropdown (probably `sdb`)

3. `Device > Create Partition Table > Select new partition table type: msdos > Apply`

4. Now right click on the device (should appear `unallocated`) and select `New`

5. Select filesystem `exFAT` if you can, otherwise `ext4` is okay

6. Click on `Apply All Operations` (green tick button)

7. When complete click `Close` and unplug the stick

8. You can close `gparted` now. Plug the stick back in and mount it `mountusb`

9. Open the terminal and `cd` into the location of the stick

10. Change mode and permissions for the stick
```bash
sudo chmod 777 .
sync
```

11. Close the terminal, `unmount` the stick, unplug it, plug it back in and check that you have write permissions.
