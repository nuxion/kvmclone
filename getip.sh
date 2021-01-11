#!/bin/bash
VM=$1

mac=`virsh dumpxml ${VM} | grep "mac address" | awk -F\' '{ print $2}'`
arp | grep ${mac}
