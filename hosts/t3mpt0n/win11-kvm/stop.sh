#!/run/current-system/sw/bin/bash

set -x

virsh nodedev-detach pci_0000_2d_00_0
virsh nodedev-detach pci_0000_2f_00_4

modprobe -r vfio_pci
modprobe amdgpu

echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind
