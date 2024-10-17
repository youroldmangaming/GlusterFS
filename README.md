# DOX - A Computer Scientists NoteBook

# Managing a Raspberry Pi Distibuted File Share using Gluster

### 1. Check Cluster Availability in Preparation for Installation
Checks the availability of slurm defined nodes. This is needed as a first step as orchestration of tasks become very tiresome as the cluster increases in nodes.
If a node is not available the script will attempt to get it into a state ready to work.
(`is_node_alive.sh`):
### 2. Remove all old GlusterFS shares (`slurm_remove_cluster_worker.sh`):
When you are in a lab, you are by definition learning, installing, reinstalling, makign and breaking. It is a good habit to get into, to create tools that allow you to reset configurations back to a reinstall state.

This file will remove current GlusterFS volumes(`remove_gluster_worker.sh`):

This file will remove current GlusterFS volume from the manager node rpi41(`gluster_manager_clean.sh  `):


This script will install GlusterFS on all nodes with the cluster (manager and worker)(`install_gluster.sh  `):


This script will setup the workers nodes to the manager node(`setup_peering.sh  `), this script must be run on the manager node (rpi41):

This script will setup the GlusterFS volumns and share them. To note this is not a setup similar to SAMBA or NFS where a central server is required to be up so that that files can be accessed. Gluster as setup in this instance, is fully redundant and distributed(`setup_gluster_distributed_share.sh `). This needs to be run on each node including the manager node:


To be run on the manager node to build and startup the volume



<div style="font-size: 50%;">
  <pre><code>
  ┌────────────────────────────────────────────────────────────────────────┐   
  │                                                                        │   
  │ @@@@@@@@@@@@@@@@@@@@          %@@@@@@@@%          %@@            %@@   │   
  │ @@@@@@@@@@@@@@@@@@@@       %@@@@@@@@@@@@@@%     %@@@@@@        *@@@@@@ │   
  │ @@@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@@@@@@@@     @@@@@@@%     @@@@@@%  │   
  │ @@@@@          %@@@@     %@@@@@%       @@@@@@      @@@@@@@% @@@@@@%#   │   
  │ @@@@@          %@@@@    %@@@@@          @@@@@@       @@@@@@@@@@@@#     │   
  │ @@@@@          %@@@@    @@@@@@          #@@@@@         @@@@@@@@%       │   
  │ @@@@@          %@@@@    @@@@@@          %@@@@@        %@@@@@@@@@       │   
  │ @@@@@          %@@@@    *@@@@@*         @@@@@%      #@@@@@@@@@@@@@     │   
  │ @@@@@@@@@@@@@@@@@@@@     @@@@@@@%     @@@@@@@     #@@@@@@@  @@@@@@@@   │   
  │ @@@@@@@@@@@@@@@@@@@@      *@@@@@@@@@@@@@@@@%    *@@@@@@@      @@@@@@@% │   
  │ @@@@@@@@@@@@@@@@@@@@        %@@@@@@@@@@@@@       @@@@@%         @@@@@% │   
  │                                %@@@@@@%            @%             @%   │   
  │                                                                        │   
  └────────────────────────────────────────────────────────────────────────┘
                                           A Computer Scientist's Notebook
                                                            Y0MG 1990-2024
GitHub Repository https://github.com/youroldmangaming/DOX
Documentation Site https://dox.youroldmangaming.com
  </code></pre>
</div>
