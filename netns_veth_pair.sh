#!/bin/bash

<< INFO
	This script creates a network namespace named 'inet'
	Creates a veth pair, veth-a and veth-b.
	Attach the veth-b to the namespace.
	Assign ip address to them.
	You can change the CIDR and names of the veth pair and namespace
	
INFO

# Create a namespace
ip netns add inet

ip netns exec inet ip addr

# Bring up or make active lo interface in the namespace
ip netns exec inet ip link set dev lo up

ip netns exec inet ip link
# Create veth pair veth-a and veth-b
ip link add veth-a type veth peer name veth-b

# Assign veth-b to the namespace inet
ip link set veth-b netns inet

ip netns exec inet ip link

# Assign ip to the veth-a
ip addr add 22.0.0.1/24 dev veth-a

# Up veth-a
ip link set dev veth-a up

# Assign ip address to veth-b
ip netns exec inet ip addr add 22.0.0.2/24 dev veth-b

# Bring veth-b up/Active the veth-b interface
ip netns exec inet ip link set dev veth-b up

# Add route incase the otherside namespace has different subnet
# In this case 23.0.0.0/24 is CIDR of the otherside

ip netns exec inet ip route add 23.0.0.0/24 via 22.0.0.1 dev veth-b
