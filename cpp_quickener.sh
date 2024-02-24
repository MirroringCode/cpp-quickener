#!/bin/bash

# Program to accelerate the generation of of C++ files and their compilation, cuz i'm really lazy
# Made by Miquios / MirroringCode

function boilerplate {
	read -p "do you wish to generate the boilerplate code of c++? (Y/N): " election
	if [[ $election == "Y" || $election == "y" ]]; then
		cat >>$1 <<EOL
#include <iostream>

int main (int argc, char *argv[]) {
 
  return 0;
}
EOL
	else
		echo "alright, no boilerplate for you"
	fi
}

function create() {
	clear
	read -p "choose the name of your C++ file: " filename

	if [[ -z filename ]]; then
		echo "the name of the file can't be empty!"
		sleep 1
		create
	elif [[ -f "$filename.cpp" ]]; then
		echo "this file already exists"
		sleep 1
		create
	else
		touch "$filename.cpp"
		boilerplate "$filename.cpp"
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
		sleep 1
		compile
	else
		gcc "$filename.cpp" -lstdc++ -o "$output"
		echo "succesfully compiled"
	fi

}

function options {
	read -p "choose either 1 or 2: " election
	if [[ $election -eq 1 ]]; then
		create
	elif [[ $election -eq 2 ]]; then
		compile
	else
		options
	fi
}

echo "This is just a little program where you choose two options, either compile or create new file, this was made to quicken the c++ process"

echo "[1] To create new C++ file"
echo "[2] To compile an already created file"

options
