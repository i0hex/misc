#!/bin/bash

# Get the basename of the script file
script_name=$(basename "$0")

function gen_common(){
	mkdir include
	mkdir src
	mkdir lib
	mkdir build
}

function gen_resource(){
	mkdir assets
	mkdir config
}

function gen_test(){
	mkdir tests
}

function gen_document(){
	mkdir doc
	touch README.md
}

function gen_cmake(){
	gen_common
	touch CMakeLists.txt	
}

function gen_advanced(){
	gen_common
	gen_resource
}

function gen_all(){
	gen_common
	gen_resource
	gen_document
	gen_test
}

function echo_help(){
	echo
	echo "Create directory structure of the C/C++ project."
	echo
	echo "Usage: $script_name <option> <directory>"
	echo "Options:"
	echo "	-common		- Create common project directories (include, src, lib, build)"
	echo "	-res		- Create resource directories (assets. config)"
	echo "	-doc		- Create documentation (doc, README.md)"
	echo "	-test		- Create test directoties"
	echo "	-cmake		- Create a CMakeLists.txt"
	echo "	-advanced	- Create common and resource directories"
	echo "	-all		- Create common, resource, document and test directories"
	echo	
}

# Limit number of the parameters
argc=1

if [ $# -lt $argc ]
then
	echo "Not engough arguments. At least $argc arguments."
	echo_help
	exit 1
fi

# Get the first parameter as an option
option=$1

func=echo_help

if [ "$option" = "-help" ]
then
	echo_help
	exit 0
elif [ "$option" = "-common" ]
then
	func=gen_common
elif [ "$option" = "-res" ]
then
	func=gen_resource
elif [ "$option" = "-doc" ]
then
	func=gen_document
elif [ "$option" = "-test" ]
then
	func=gen_test
elif [ "$option" = "-cmake" ]
then
	func=gen_cmake
elif [ "$option" = "-advanced" ]
then
	func=gen_advanced
elif [ "$option" = "-all" ]
then
	func=gen_all
else
	echo "$script_name: Invalid option --- '$1'"
	echo "Try '$script_name -help' for more infomation"
	exit 1
fi

# Get the second parameter as the directory
directory=$2

if [ -z "$directory" ]; then
	# Create struture in the current directory
	$func
elif [ "$directory" = "." ]; then
	# Create struture in the current directory
	$func
else
	# Check if the directory exists
	if [ -d "$directory" ]; then
		echo "Directoty exists."
		exit 1
	fi

	# Add a trailing backslash if there is no backslash at the end of the directory parameter
	if [[ "$directory" != */ ]]; then
		directory=$directory/
	fi

	# Check if the directory successfully created
	mkdir $directory
	if [ ! -d "$directory" ]; then
		echo "Failed to create directoty."
		exit 1
	fi
	cd $directory
	$func
	cd ..
fi

echo "Project directories created."
