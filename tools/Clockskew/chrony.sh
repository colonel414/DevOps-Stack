# Install chrony
sudo yum install chrony -y

# Configure chrony
sudo bash -c 'cat << EOF > /etc/chrony.conf
# Use public NTP servers
server 0.pool.ntp.org iburst
server 1.pool.ntp.org iburst
server 2.pool.ntp.org iburst

# Allow NTP client access from local network
allow 192.168.0.0/16

# Specify the keyfile for authenticating time sources
keyfile /etc/chrony.keys

# Enable kernel synchronization of the real-time clock (RTC)
rtcsync

# Enable hardware timestamping on all interfaces that support it
hwtimestamp *
EOF'

# Start and enable chrony
sudo systemctl start chronyd
sudo systemctl enable chronyd

# Check the status of chrony
sudo chronyc sources

chronyc tracking
