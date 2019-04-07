# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true


DEBIAN_FRONTEND=noninteractive

if [ -d "/vagrant" ]; then
	root_dir="/vagrant"
elif [ -d "scripts" ]; then
 	root_dir="$(PWD)"
elif [ -d "../scripts" ]; then
   	root_dir="$(dirname "$PWD")"
else
   	root_dir="/tmp"
fi

#echo "---------------------"
#echo "root dir : " $root_dir
#echo "---------------------"

scripts_dir=${root_dir}"/scripts/"
archive_dir=${scripts_dir}"archives/"

if [ ! -d ${archive_dir} ]; then
	sudo mkdir ${archive_dir}
fi

#make sure any need archive downloaded is readable
sudo chmod -R 555 ${archive_dir}

