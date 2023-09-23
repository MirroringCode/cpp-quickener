#!/bin/bash

# Program to accelerate the generation of of C++ files and their compilation, cuz i'm really lazy
# Made by Miquios / MirroringCode

echo "This is just a little program where you choose two options, either compile or create new file, this was made to quicken the c++ process"

echo "[1] To create new C++ file"
echo "[2] To compile an already created file"

function create() {
	clear
	echo "choose the name of your C++ file: "
	read filename

	if [[-z filename ]]; then
		echo "the name of the file can't be empty!"
		sleep 1
		create
	elif [[ -f "$filename.cpp" ]]; then
		echo "this file already exists"
		sleep 1
		create
	else
		touch "$filename.cpp"
		echo "file successfully created"
	fi

}

function compile() {
	clear

	read -p "choose which file you want to compile: " filename
	if [[ -z $filename ]]; then
		echo "the name of the file can't be empty!"
		sleep 1
		compile
	fi

	read -p "choose the name of the output file / executable: " output
	if [[ -z $output ]]; then
		echo "the name of the output file can't be empty!"
		sleep 1
		compile
	fi

	if [[ ! -f "$filename.cpp" ]]; then
		echo "this file doesn't exist"
	else
		gcc "$filename.cpp" -lstdc++ -o "$output"
		echo "succesfully compiled"
	fi

}

read election

case $election in
1)
	create
	;;
2)
	compile
	;;
*)
	echo "you must pick either one or two, your election was $election"
	;;
esac
