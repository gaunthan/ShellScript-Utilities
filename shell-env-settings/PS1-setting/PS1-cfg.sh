# !/bin/bash

# Read configuration of PS1.
PS1=$(cat PS1.cfg)

# Add it.
echo "PS1=\"${PS1}\"" >> ~/.bashrc
