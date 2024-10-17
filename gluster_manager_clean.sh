#!/bin/bash

# Configuration variables
MANAGER_NODE="rpi41"
WORKER_NODES="rpi51,rpi52,rpi53,rpi54"
GLUSTERFS_DIR="/glusterfs"
VOLUME_NAME="staging-gfs"

echo "Starting GlusterFS cleanup on manager node: $MANAGER_NODE"

# Stop and delete the volume
echo "Stopping and deleting GlusterFS volume: $VOLUME_NAME"
gluster volume stop $VOLUME_NAME --mode=script || true
gluster volume delete $VOLUME_NAME --mode=script || true

# Detach peers (worker nodes)
IFS=',' read -ra WORKER_NODE_ARRAY <<< "$WORKER_NODES"
for node in "${WORKER_NODE_ARRAY[@]}"; do
    echo "Detaching peer: $node"
    gluster peer detach $node --mode=script || true
done

# Stop GlusterFS services
echo "Stopping GlusterFS services"
systemctl stop glusterd
systemctl disable glusterd

# Remove GlusterFS packages
echo "Removing GlusterFS packages"
apt purge -y glusterfs-server glusterfs-client glusterfs-common
apt autoremove -y

# Remove GlusterFS directories
echo "Removing GlusterFS directories"
rm -rf $GLUSTERFS_DIR /var/lib/glusterd /var/log/glusterfs /etc/glusterfs

# Remove GlusterFS mount from /etc/fstab
echo "Removing GlusterFS mount from /etc/fstab"
sed -i '/glusterfs/d' /etc/fstab

# Unmount any remaining GlusterFS mounts
echo "Unmounting any remaining GlusterFS mounts"
umount -f /mnt || true

echo "GlusterFS cleanup on manager node completed successfully!"

apt remove glusterfs-server glusterfs-client glusterfs-common -y
