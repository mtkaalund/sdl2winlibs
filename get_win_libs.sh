#!/bin/bash
# File: get_win_libs.sh
# Licens: GPL3
# Author: Mtkaalund

source ./libs_version
source ./libs_files
source ./libs_dirs
source ./libs_urls

ARCHS=("i686-w64-mingw32" "x86_64-w64-mingw32")
PREFIX=`pwd`

for url in "${URLS[@]}"
do
	echo "Downloading ${url}"
	wget --quiet ${url}
done

for file in "${FILES[@]}"
do
	if [ -f "${file}" ]
	then
		if [ -s "${file}" ]
		then
			tar xf ${file}
		fi
	fi
done

for arch in "${ARCHS[@]}"
do
	mkdir -pv ${PREFIX}/${arch}
done

for dir in "${DIRS[@]}"
do
	if [ -d "${dir}" ]
	then
		cd ${dir}
		for arch in "${ARCHS[@]}"
		do
			make install-package arch=${arch} prefix=${PREFIX}/${arch}
		done
		cd ..
	fi
done

echo "All done installing windows libraries"
echo "Cleaning up"
for file in "${FILES[@]}"
do
	rm -rf ${file}
done

for dir in "${DIRS[@]}"
do
	rm -rf ${dir}
done
