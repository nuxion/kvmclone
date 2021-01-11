#!/bin/bash
# based on https://www.greenhills.co.uk/posts/cloning-vms-with-kvm/
VM=$1
IMAGES_DIR=/srv/virtual
BASE_IMG=debian10
USER=libvirt
GROUP=libvirt

qemu-img create -f qcow2 -F qcow2 -b ${IMAGES_DIR}/${BASE_IMG}.qcow2 ${IMAGES_DIR}/${VM}.qcow2 
chown ${USER}:${GROUP} ${IMAGES_DIR}/${VM}.qcow2 
mkdir -p tmp
virsh dumpxml ${BASE_IMG} > tmp/debian-base.xml
python3 modify-domain.py \
	--name ${VM} \
	--new-uuid \
	--device-path=${IMAGES_DIR}/${VM}.qcow2 \
	< tmp/debian-base.xml > tmp/${VM}.xml
virsh define tmp/${VM}.xml
virsh start ${VM}


