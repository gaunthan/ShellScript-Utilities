#!/bin/env bash
# Automatically remove all your old kernels.

# Package command settings.
# Modify them if you use different package manager.
PKG_QUERY="rpm -qa"
PKG_REMOVE="rpm -e --nodeps"

# Interactive settings.
WAIT_TIME=3

cur_kernel=`uname -r`
old_kernels=`$PKG_QUERY | grep kernel- | grep -v ${cur_kernel}`

# No old kernel exists.
if [[ "${#old_kernels}" -eq "0" ]];then
	echo "Your system doesn't has any old kernel. Leaving..."
	exit
fi

echo "Found old kernels: "
echo "$old_kernels"
echo "Prepare to remove them..."
echo "NOTE: I will wait $WAIT_TIME second(s) each task, to let you cancel removing the specific kernel."
echo "Now begin."

for old_kernel in ${old_kernels}; do
	echo -n "Removing ${old_kernel}...Cancel?(y/n) "
	read -t $WAIT_TIME choice
	if [[ "$?" -eq "0" && "$choice" = "y" ]];then # User canceled.
		echo "Canceled removing $old_kernel."
		continue
	fi
	echo 

	sudo $PKG_REMOVE $old_kernel
done

