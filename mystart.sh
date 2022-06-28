#!/bin/sh

### BEGIN INIT INFO
# Provides: mystart
# Required-Start: networkremote_fs local_fs
# Required-Stop:network remote_fslocal_fs
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: mystart
# Description: executed when the system starts
### END INIT INFO

/usr/sbin/ntpdate time.nist.gov|logger -t NTP
/usr/sbin/hwclock -w

exit 0