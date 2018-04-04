# openvpn_route_fix.sh
# Updated 1/25/18
#
# When using client openvpn connections, sometimes it's setup in such a way
# that traffic to local subnets in my network are all jacked up.
#
# For example, if my main subnet is 192.168.1.x/24 and my VMWare lab environment
# lives at 192.168.55.x/24, the 55.x network becomes unreachable once the openvpn
# connection is established.
#
# A quick and easy workaround is to add a route to your machine so that it knows
# to go through the proper default gateway to get to the 55.x network from your 1.x
# network:
sudo route -n add 192.168.55.0/24 192.168.1.1
