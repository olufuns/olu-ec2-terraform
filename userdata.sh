#!/bin/bash

# get admin privileges
sudo su

# install httpd
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "Welcome to DevOps Training" > /var/www/html/index.html


# Define variables
NEW_USER="olu"
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgnp6m9d4UU/2n6LqmZfeEyHUt3HL76uIYFCAZB33AeA6E1Zf/ZPY9c39KLW3+sYbCzDQYFMe3OjUrodBzgiVPa+KtbJoziVW4dEZ3tBHFRhVzPp6l5D0IAog3obWwugWs/idHT0ykHI+r4np1QRDIVqXV95x25AfN8RDwvdsnVG1UTRPXy0bqi5SH2oXNFC31T34TWy8l42GAHTuQcvsEaovh2tqt86+w+LTzs6lgzZVRG1UyE95/5OYuWCpzcigL8cBZWhqwvA8h98iDQOYH/twfYf+075K3aORlM2swrIzc54sOhXnotnHQGNwHWvkog3d1wpdbFz2ZYw6Phd9U+QQM6/AW3wBtuProGOCvgec/7ukyDiiPh3NKCdCQmh+uj6y2+mF8JVeawBOTXgFr9sDQa9/MEhV1d7FJaYjpSuxacQi0j+Ao0yW7y5smVbIFWHYMfPnEaKjrtDiyiPmlwdo1SV61af3n2rCtZ1iv7PbIjEGlGHVFVqmDcXDDNoc= olufunso@Dell"

# 1. Create the user and their home directory
if ! id "$NEW_USER" &>/dev/null; then
    useradd -m -s /bin/bash "$NEW_USER"
fi

# 2. Grant passwordless sudo privileges
echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/90-$NEW_USER"
chmod 0440 "/etc/sudoers.d/90-$NEW_USER"

# 3. Configure SSH access
USER_HOME="/home/$NEW_USER"
mkdir -p "$USER_HOME/.ssh"
echo "$SSH_PUBLIC_KEY" > "$USER_HOME/.ssh/authorized_keys"

# 4. Correct permissions and ownership
chmod 700 "$USER_HOME/.ssh"
chmod 600 "$USER_HOME/.ssh/authorized_keys"
chown -R "$NEW_USER:$NEW_USER" "$USER_HOME/.ssh"

echo "User $NEW_USER successfully configured via User Data."
