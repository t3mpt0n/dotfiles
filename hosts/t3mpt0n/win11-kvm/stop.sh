#!/run/current-system/sw/bin/bash

set -x
source "/var/lib/libvirt/hooks/kvm.conf"

virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO
virsh nodedev-reattach $AUDIO_JACK
modprobe -r vfio-iommu-type1
modprobe -r vfio-pci
modprobe -r vfio
modprobe amdgpu
modprobe radeon
modprobe drm
modprobe drm_kms_helper

echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind
