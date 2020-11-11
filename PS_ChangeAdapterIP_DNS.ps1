###
### .NOTES
###     The below works but its slow as a wet week. Can take 30secs or more but does work
###     You probably want to create parameters for the IP address, default goatway and DNS

### First set the ip address for the adapter via the alias rather that InterfaceIndex

New-NetIPAddress -InterfaceAlias "Eth_OnBoard" -IPAddress 192.168.0.123 -PrefixLength 24 -DefaultGateway 192.168.0.1

### First set the DNS server address for the adapter via the alias rather that InterfaceIndex

set-DnsClientServerAddress -InterfaceAlias "Eth_OnBoard" -ServerAddresses ("192.168.0.31")

### ENDS