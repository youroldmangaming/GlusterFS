cd/
mkdir -p /glusterfs /mnt/glusterfs

echo "$hostname:/glusterfs /mnt/glusterfs glusterfs defaults,_netdev,backupvolfile-server= 0 0" >> /etc/fstab


chown -R root:docker /mnt
systemctl daemon-reload
mount -a
mount.glusterfs hostname:/glusterfs /mnt
