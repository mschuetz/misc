# cdbackup.rb
a script for backing up files removable media.
Usage: dbus-monitor | cddbackup.rb somedirectory
insert media, wait for it being copied and ejected, insert next

# podcast2m3u.rb
creates an m3u playlist from a podcast

# audacity-restore.rb
i wrote this script when audacity crashed in the middle of a long
recording session to create an audacity project file from the .au
files that audacity stores in /tmp

#colours.rb
applies colouring to text on stdin similar to grep but outputs
non-matching lines as well.
Usage: cmd | colour.rb colour_spec regex
Example: ls -la | colour.rb bg_red,white " $USER "
