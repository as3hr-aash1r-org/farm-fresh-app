#!/bin/bash

# Create placeholder images for the Farm Fresh Shop app
echo "Creating placeholder images..."

# Create a simple colored square with text for each mango type
convert -size 300x300 xc:yellow -fill black -gravity center -pointsize 24 -annotate 0 "Chaunsa Mango" chaunsa.png
convert -size 300x300 xc:orange -fill black -gravity center -pointsize 24 -annotate 0 "Sindhri Mango" sindhri.png
convert -size 300x300 xc:green -fill white -gravity center -pointsize 24 -annotate 0 "Anwar Ratol Mango" anwar_ratol.png

# Create a logo placeholder
convert -size 300x300 xc:darkgreen -fill white -gravity center -pointsize 24 -annotate 0 "Farm Fresh Shop" logo.png

# Create a generic placeholder
convert -size 300x300 xc:gray -fill white -gravity center -pointsize 24 -annotate 0 "Placeholder" placeholder.png

echo "Placeholder images created successfully!"
