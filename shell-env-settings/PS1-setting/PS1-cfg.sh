# !/bin/bash

ps1_cfg="./PS1.cfg"
profile="${HOME}/.bashrc"

# Read configuration of PS1.
PS1=$(cat $ps1_cfg)

# Check if configured.
grep "^PS1=" $profile --silent
if [ $? = 0 ]; then
	echo "PS1 was configured.Would you like to continue?"
	echo "If continue, We will comment your previous configrations."
	echo -n "Enter \"yes\" or \"no\": "

	read ans
	if [ $ans = "no" ]; then
		echo "Operation aborted."
		exit
	else
		echo "Commenting your previous configurations..."
		# Comment the existent configurations.
		sed -i -s 's/^[^#]*PS1=/# &/' $profile
	fi
fi

echo "Configuring PS1..."

# Add it.
echo "PS1=\"${PS1}\"" >> $profile
	
# Reload profile.
. $profile

echo "Operation done."
