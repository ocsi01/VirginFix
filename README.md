Fix for Virgin Media Superhub 2 VS MacBook Pro (2015) wifi issue
======
The following codes are designs and written by my. The main goal is to Quick-Fix the issue between the new Macbook Pro and the Virgin Media Superhub 2 wireless modem. 
Use the code based on your own decission.
Feel free to contribute.

**How to use** 

```

# To clone repository
git clone https://github.com/ocsi01/VirginFix.git
cd VrginFix

# To install the required dependencies
./install.sh

# To generate configuration file 
./init.sh

# To run the ARP sender loop
./run.sh
```
## Version 
* Version 0.2

## Notes
 * The installer needs sudo, the rest of the script does NOT.
 * The init.sh querries your system for your IP, MAC address.
 * The init.sh qurries the currently active wifi networks SSID -> This will be a new feature. Coming soon
 * The init.sh creates a binary file, which contains the ARP call to send out.
 * The run.sh contains an endless loop. The output is redirected to the arp.log, arp_error.log files

## Dependencies
Ths installer script downloads and installs tcpreplay 4.1. For further details and dependencies check the project website:
https://github.com/appneta/tcpreplay


## Created by:
#### Adam Ocsvari
* Twitter: [@ocsi01](https://twitter.com/ocsi01 "Ocsi01 on twitter")

