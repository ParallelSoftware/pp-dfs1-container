#!/bin/bash
#
# AUTHOR : Fabio Pinto <fabio@parallel.co.za>
#
# DESCRIPTION : 
#		Simple series of commands that bootstraps a GlusterFS volume for the dfs1 gluster container
#

ENV_GFS_NODE2_IP="192.168.0.8"

#Modify /etc/hosts with mungehost
mungehosts -l gluster1 &&
mungehosts -a "$ENV_GFS_NODE2_IP gluster2" &&

sleep 1

#These commands bootstrap the gluster volume for us. dfs1 is the control node if you will
service glusterd start &&
gluster peer probe gluster2 && sleep 10 && gluster peer probe gluster2 &&
gluster volume create client_data replica 2 gluster1:/client_data gluster2:/client_data force &&
gluster volume start client_data &&
tail -f /var/log/glusterfs/etc-glusterfs-glusterd.vol.log
