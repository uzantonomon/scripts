#!/bin/bash

for item in $(sudo virsh list --name); do sudo virsh dumpxml "$item" > /tmp/"$item".xml ; done

MAC=$(grep "mac address='" /tmp/"$item".xml | awk -F '=' {'print $2'} | cut -d "'" -f2)

IP=$(sudo arp -an | grep $MAC | cut -d " " -f2 | sed 's/.*(\(.*\))/\1/')

VM_NAME=$(for item in $(sudo virsh list --name); do echo "$item"; done)

printf "%-30s | %-30s | %-30s\n" "VM Name" "VM Mac Address" "VM IP"
printf "%-30s | %-30s | %-30s\n" "---------------" "---------------" "---------------"
printf "%-30s | %-30s | %-30s\n" "$VM_NAME" "$MAC" "$IP"