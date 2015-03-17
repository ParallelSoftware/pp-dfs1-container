#GlusterFS container for Placementpartner client_data directory
FROM centos:6.6
MAINTAINER Parallel Software

#Installing GlusterFS
RUN yum install -y wget
RUN wget -P /etc/yum.repos.d http://download.gluster.org/pub/gluster/glusterfs/LATEST/CentOS/glusterfs-epel.repo
RUN yum install -y glusterfs glusterfs-fuse glusterfs-server

#Install Mungehosts (Awsome Utlity which helps with /etc/hosts file modifications in docker)
ADD https://github.com/ParallelSoftware/nim-mungehosts/releases/download/v0.1.1/mungehosts /usr/local/bin/mungehosts
RUN chmod 755 /usr/local/bin/mungehosts

#Ports required for a single glusterFS volume
EXPOSE 24007 24008 24009 49152

#Inserts bootstrap bash script into image
COPY bootstrap_gluster.sh /root/

#Apply execute permissions to script
RUN chmod 777 /root/bootstrap_gluster.sh

#Tail gluster log to keep container alive
CMD ["/root/bootstrap_gluster.sh"]
