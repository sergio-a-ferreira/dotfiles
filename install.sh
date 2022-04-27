#! /usr/bin/env bash
# ==============================================================================
#  ___   / _|   ___   _ __   _ __     ___  | |_ 
# / __| | |_   / _ \ | '__| | '_ \   / _ \ | __|
# \__ \ |  _| |  __/ | |    | | | | |  __/ | |_ 
# |___/ |_|    \___| |_|    |_| |_|  \___|  \__|
# 
# Name        : install.sh
# Version     : v0.1
# Description : dotfiles installation script
#
# Arguments   : N/A
# Returns     : 0 on successfull installation
#              >0 otherwise
#
# Input Files : N/A
# Output Files: N/A; messages outputed to stderr
#
# Notes       : performs simple validations based on heuristics to evaluate
#                 directory or file deletion.
#               the files / directories which are marked for deletion are 
#                 renamed with a suffix .orig_df_<yyyymmddhhmmss>
#               for example if a file named .vimrc exists it's renamed to 
#                 .vimrc.orig_df_yyyymmddhhmmss
#
# ==============================================================================
# configure files to deploy here:
typeset -A file_info=(

	[profile]="source|${HOME}/dotfiles/profile.config|${HOME}/.bashrc"
	[vim]="link|${HOME}/dotfiles/vim.config|${HOME}/.vimrc"
	[git]="link|${HOME}/dotfiles/git.config|${HOME}/.gitconfig"
	[neofetch]="link|${HOME}/dotfiles/neofetch.config|${HOME}/.config/neofetch"
	# add new files here

)

# ==============================================================================
# - Functions: -----------------------------------------------------------------
writeMessage(){

	# Description: print a formatted message to stderr
	# Arguments  : a string with the message
	# Returns
	#       - 0  : success
	#       - >0 : on error
	# Notes
	#
	printf "$0 [$$ :: $(getTimestamp full)]: ${@}\n" 1>&2
}


# ------------------------------------------------------------------------------
getTimestamp(){

	# Description: format a timestamp with current datetime
	# Arguments  : full; returns timestamp to nanosecond [yyyy-mm-dd hh:mm:ss.ns]
	#              y2s: a simple yyyymmddhhmmss for the file renaming
	# Returns    : formated timestamp
	# Notes
	#
	case "${1}" in
		"full") date +"%Y-%m-%d %T.%N"
		;;
		"y2s") date +"%Y%m%d%H%M%S"
		;;
	esac
}

# ------------------------------------------------------------------------------
copy_(){

	# Description: copy a file; if file exists make backup
	# Arguments  : 1 file origin
	#              2 file destiny
	#       - 0  : success
	#       - >0 : error
	# Notes      : 
	#

	typeset origin="${1}"
	typeset destiny="${2}"

	writeMessage "copying file ${origin} to ${destiny}"

	backUp ${destiny}

	cp -pR ${origin} ${destiny}
}

# ------------------------------------------------------------------------------
link_(){

	# Description: link a file; if link exists replace it
	# Arguments  : 1 file origin
	#              2 file destiny
	#       - 0  : success
	#       - >0 : error
	# Notes      : 
	#

	typeset origin="${1}"
	typeset destiny="${2}"

	writeMessage "linking file ${origin} as ${destiny}"

	backUp ${destiny}

	ln -s ${origin} ${destiny}
}


# ------------------------------------------------------------------------------
backUp(){

	# Description: evaluates if destiny exists and make a back
	# Arguments  : 1 file destiny
	#       - 0  : success
	#       - >0 : error
	# Notes      : 
	#

	typeset destiny="${1}"

	if [ -e "${destiny}" ]; then
		writeMessage "${destiny} exists; replacing with ${origin}"
		if [ -L ${destiny} ]; then
			# if link delete
			rm ${destiny}
		else
			# if file / directory make backup
			writeMessage "backing up ${destiny} as ${destiny}_dt_$(getTimestamp y2s)"
			cp -pR ${destiny} ${destiny}_dt_$(getTimestamp y2s) && rm -rf ${destiny}
		fi
	fi
}


# ------------------------------------------------------------------------------
source_(){

	# Description: copy a file; if file exists make backup
	# Arguments  : 1 file origin
	#              2 file destiny
	#       - 0  : success
	#       - >0 : error
	# Notes      : 
	#

	typeset origin=${1}
	typeset destiny=${2}

	writeMessage "sourcing file ${origin} in ${destiny}"

	typeset msg_id="# source dotfiles/profile.config"
	typeset msg_line='[ -r ~/dotfiles/profile.config ] && . ~/dotfiles/profile.config'

	if [ -f ${destiny} ]; then
		grep -q "${msg_id}" ${destiny} && return 0
	fi

	printf "\n${msg_id}\n${msg_line}\n" >> ${destiny}
}

# ------------------------------------------------------------------------------
getInstallInfo(){

	# Description: get file list, origin, destiny and methods for installation
	# Arguments  : N/A
	#       - 0  : success
	#       - >0 : on error
	# Notes      : 
	#   don't use tilde expansion
	#    methods available
	#      source - source file
	#      copy   - copy file to destiny
	#      link   - symlink file in destiny

	for file_type in ${!file_info[@]}; do

		typeset IFS="|"
		set ${file_info[$file_type]}

		typeset method="${1}"
		typeset origin="${2}"
		typeset destiny="${3}"

		case "${method}" in
			"source") source_ "${origin}" "${destiny}"
			;;
			"link")	link_ "${origin}" "${destiny}"
			;;
			"copy")	copy_ "${origin}" "${destiny}"
			;;
		esac
	done
}

# ------------------------------------------------------------------------------
main(){

	# Description: runtime entry point
	# Arguments  : N/A; parses ${0} ${@}
	# Returns    : 
	#	sucess   : 0
	#	error    : parses last error received
	# Notes      : this function is an auxiliary entry point:
	#                sets process control variables;
	#                sources scripts and libaries;
	#                orchestrates the process flow.

	# start process
	writeMessage "start"

	# get files to install (link or copy)
	getInstallInfo

	# end process
	writeMessage "end"

	return ${rc}
}


# ==============================================================================
# - Main : ---------------------------------------------------------------------
# evaluate if script is to be sourced or executed
if [ "${0}" != "bash" ]; then
	# run script
	main
else
	# source file; it's an installation script so
	#   unset all variables and functions
	unset main writeMessage getTimestamp getInstallInfo source_ copy_ link_ backUp
	writeMessage "this script is not aimed to be sourced!!"
	return 130
fi
