#!/bin/sh
unset CDPATH
top=$(git rev-parse --show-toplevel)
curdir=$(pwd)
cd "$(dirname "$0")"
META=$(pwd)
cd "$curdir"
unset curdir

# This variable must be defined in config.sh
GITHUB_TOKEN=UNDEFINED

WIN32_LOGIN=Administrator@localhost
WIN32_SSH_PORT=2002
WIN32_COLA_DIR=git-cola
WIN32_PYTHON=/c/Python27

DOCUMENT_ROOT="$top/../git-cola.github.com"
RELEASES="$DOCUMENT_ROOT/releases"

# _the_ cola version
if test -e bin/git-cola
then
	VERSION=$(bin/git-cola version | awk '{print $3}')
fi

if test -e "$META/config.sh"
then
	. "$META/config.sh"
fi

do_or_die() {
	if ! "$@"; then
		status=$?
		echo "error running: $@"
		echo "exit status: $status"
		exit $status
	fi
}

title() {
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "    $@"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
}

ensure_dir_exists() {
	if ! test -d "$1"; then
		do_or_die mkdir -p "$1"
	fi
}