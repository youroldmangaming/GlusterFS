#!/bin/bash

# Configuration variables
GLUSTERFS_DIR="/glusterfs"

echo "Starting GlusterFS cleanup on worker node"

# Stop GlusterFS services
echo "Stopping GlusterFS services"
systemctl stop glusterd
systemctl disable glusterd

# Remove GlusterFS packages
echo "Removing GlusterFS packages"
apt remove --purge glusterfs-server -y
apt remove --purge glusterfs-client -y
apt remove --purge glusterfs-common -y

apt autoremove -y

# Remove GlusterFS directories
echo "Removing GlusterFS directories"
rm -rf $GLUSTERFS_DIR /var/lib/glusterd /var/log/glusterfs /etc/glusterfs

# Remove GlusterFS mount from /etc/fstab
echo "Removing GlusterFS mount from /etc/fstab"
sed -i '/glusterfs/d' /etc/fstab

# Unmount any remaining GlusterFS mounts
#echo "Unmounting any remaining GlusterFS mounts"
#sudo umount -f /mnt || true

echo "GlusterFS cleanup on worker node completed successfully!"


systemctl stop glusterd.service
systemctl disable glusterd.service
rm /etc/systemd/system/glusterd.service
rm /etc/systemd/system/glusterd.service # and symlinks that might be related
rm /usr/lib/systemd/system/glusterd.service 
rm /usr/lib/systemd/system/glusterd.service # and symlinks that might be related
systemctl daemon-reload
systemctl reset-failed
