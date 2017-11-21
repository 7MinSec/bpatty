# This is a script (to get Kali to offer a proper HD resolution)
# Source: https://gist.github.com/omouse/004726fb5dde889535b4
#

# Create 1920x1080 resolution mode
xrandr --newmode '1920x1080'  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync

# Add new resolution mode to the display
xrandr --addmode Virtual1 1920x1080

# Resize the display to use the new resolution mode
xrandr --output Virtual1 --mode '1920x1080' --rate 60
