#!/bin/vbash

source /opt/vyatta/etc/functions/script-template
configure


# Virtual Tunnel Interface
set interfaces vti vti1 address 100.50.0.4/24
set interfaces vti vti1 description 'virtual tunnelling interface'

# set the vpn endpoint interface, on which the encryption and
# decryption happens
set vpn ipsec ipsec-interfaces interface eth2

# set logging
set vpn ipsec logging log-modes all

# Phase 1 configurations
set vpn ipsec ike-group IKE-1W proposal 1
set vpn ipsec ike-group IKE-1W proposal 1 encryption aes256
set vpn ipsec ike-group IKE-1W proposal 1  hash sha256
set vpn ipsec ike-group IKE-1W proposal 2 encryption aes256
set vpn ipsec ike-group IKE-1W proposal 2 hash sha256
set vpn ipsec ike-group IKE-1W proposal 1 dh-group 2
set vpn ipsec ike-group IKE-1W key-exchange ikev2
set vpn ipsec ike-group IKE-1W lifetime 3600
set vpn ipsec ike-group IKE-1W dead-peer-detection action restart
set vpn ipsec ike-group IKE-1W dead-peer-detection interval 30
set vpn ipsec ike-group IKE-1W dead-peer-detection timeout 120
show vpn ipsec ike-group IKE-1W

# Phase 2 configurations
set vpn ipsec esp-group ESP-1W proposal 1
set vpn ipsec esp-group ESP-1W proposal 1 encryption aes256
set vpn ipsec esp-group ESP-1W proposal 1 hash sha256
set vpn ipsec esp-group ESP-1W proposal 2 encryption aes256
set vpn ipsec esp-group ESP-1W proposal 2 hash sha256
set vpn ipsec esp-group ESP-1W lifetime 3600
set vpn ipsec auto-update 60
show vpn ipsec esp-group ESP-1W


set vpn ipsec site-to-site peer <peed ip address> authentication mode pre-shared-secret
set vpn ipsec site-to-site peer <peed ip address> authentication pre-shared-secret test
set vpn ipsec site-to-site peer <peed ip address> default-esp-group ESP-1W
set vpn ipsec site-to-site peer <peed ip address> ike-group IKE-1W
set vpn ipsec site-to-site peer <peed ip address> local-address 14.0.0.8
set vpn ipsec site-to-site peer <peed ip address> authentication remote-id <peed ip address>
set vpn ipsec site-to-site peer <peed ip address> tunnel 1 local prefix 15.0.0.0/24
set vpn ipsec site-to-site peer <peed ip address> tunnel 1 remote prefix 12.0.0.0/24

# If the othersite is VyOS and sitting behind the NAT then uncomment below config
#set vpn ipsec site-to-site peer <peed ip address> authentication id 192.168.6.203

# otherwise use this
set vpn ipsec site-to-site peer <peed ip address> authentication id 14.0.0.8

# Bind VTI interface to the ipsec peer and group
set vpn ipsec site-to-site peer <peed ip address> vti bind 'vti1'
set vpn ipsec site-to-site peer <peed ip address> vti esp-group 'ESP-1W'

set protocols static interface-route 12.0.0.0/24 next-hop-interface vti1

commit
save
exit

