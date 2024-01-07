#!/run/current-system/sw/bin/bash

set -x

killall sway

echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/unbind

modprobe -r amdgpu

virsh nodedev-detach pci_0000_2d_00_0
virsh nodedev-detach pci_0000_2f_00_4

modprobe vfio_pci
