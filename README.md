# audacity-restore.rb
i wrote this script when audacity crashed in the middle of a long
recording session to create an audacity project file from the .au
files that audacity stores in /tmp

# cdbackup.rb
a script for backing up files removable media.
Usage: dbus-monitor | cddbackup.rb somedirectory
insert media, wait for it being copied and ejected, insert next

# colour.rb
applies colouring to text on stdin similar to grep but outputs
non-matching lines as well. you can see a list of colours in
the source. if the colour name is preceded by bg_ its the
background colour. additionally background and foreground
colours can be specified at the same time by listing them
separated by a comma.

Usage: cmd | colour.rb colour_spec regex
Example: ls -la | colour.rb bg_red,white " $USER "

# podcast2m3u.rb
creates an m3u playlist from a podcast

