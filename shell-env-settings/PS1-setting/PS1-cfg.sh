# !/bin/bash

ps1_cfg="./PS1.cfg"
profile="${HOME}/.bashrc"

# Read configuration of PS1.
PS1=$(cat $ps1_cfg)

echo "PS1 was configured.Would you like to continue?"
echo "If continue, We will comment your previous configrations."
echo -n "Enter \"yes\" or \"no\": "

read ans
if [ $ans = "yes" ]; then
	# Comment the existent configurations.
	sed -i -s 's/^[^#]*PS1=/# &/' $profile

	# Add it.
	echo "PS1=\"${PS1}\"" >> $profile
	
	# Reload profile.
	. $profile

	echo "Operation done."
else
	echo "Operation aborted."
fi
