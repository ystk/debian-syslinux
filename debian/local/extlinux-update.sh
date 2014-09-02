#!/bin/sh

## Copyright (C) 2006-2014 Daniel Baumann <mail@daniel-baumann.ch>
##
## This program comes with ABSOLUTELY NO WARRANTY; for details see COPYING.
## This is free software, and you are welcome to redistribute it
## under certain conditions; see COPYING for details.


set -e

_EXTLINUX_DIRECTORY="/boot/extlinux"

Update ()
{
	 # Upate target file using source content
	_TARGET="${1}"
	_SOURCE="${2}"

	_TMPFILE="${_TARGET}.tmp"
	rm -f "${_TMPFILE}"

	echo "${_SOURCE}" > "${_TMPFILE}"

	if [ -e "${_TARGET}" ] && cmp -s "${_TARGET}" "${_TMPFILE}"
	then
		rm -f "${_TMPFILE}"
	else
		# FIXME: should use fsync here
		echo "P: Updating ${_TARGET}..."
		mv -f "${_TMPFILE}" "${_TARGET}"
	fi
}

for _FILE in /etc/default/extlinux /etc/default/extlinux.d/*
do
	if [ -e "${_FILE}" ]
	then
		. "${_FILE}"
	fi
done
