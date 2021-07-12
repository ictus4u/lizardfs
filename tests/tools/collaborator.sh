# Functions to get info from collaborators special files

read_collaborator_special_file() {
	local mountdir=${1:-}
	local collaborator_file_name=${2:-}
	{ [ -z "${mountdir}" ] \
	  || [ ! -d "${mountdir}" ] \
	  || [ -z "${collaborator_file_name}" ] ;
	} && exit 1
	sudo cat "${mountdir}/${collaborator_file_name}"
}
