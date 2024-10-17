gluster vol set glusterfs cluster.heal-timeout 5
gluster volume heal glusterfs enable
gluster vol set glusterfs cluster.quorum-reads false
gluster vol set glusterfs cluster.quorum-count 1
gluster vol set glusterfs network.ping-timeout 2
gluster volume set glusterfs cluster.favorite-child-policy mtime
gluster volume heal glusterfs granular-entry-heal enable
gluster volume set glusterfs cluster.data-self-heal-algorithm full
gluster volume set glusterfs performance.io-thread-count 8
