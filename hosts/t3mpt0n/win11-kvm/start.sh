#!/run/current-system/sw/bin/bash

set -x
source "/var/lib/libvirt/hooks/kvm.conf"

killall sway

echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/unbind

modprobe -r amdgpu
modprobe -r radeon
modprobe -r drm_kms_helper
modprobe -r drm

sleep 5

virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO
virsh nodedev-detach $VIRSH_AUDIO_JACK

modprobe vfio-pci
modprobe vfio
modprobe vfio-iommu-type-1
