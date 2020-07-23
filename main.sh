#!/bin/bash

# loop command sep iteration1 sep sep iteration3 (...)
# sep without arguments will run as such 
loop () {
	verbose=false
	if [[ "$1" == "-v" ]]; then
		verbose=true
		shift
	fi
	cmd="$1"
	if [[ -z "$2" ]]; then
		$verbose && echo '$' ':'
		return
	fi
	sep="$2"
	shift; shift
	args=("$@")
	i="0"
	n="${#args[@]}"
	while [[ $i -lt $n ]]; do
		temp=()
		el="${args[$i]}"
		while [[ "$el" != "$sep" ]] && [[ $i -lt $n ]]; do
			temp[${#temp[@]}]="$el"
			i=$[$i+1]
			el="${args[$i]}"
		done
		$verbose && echo '$' "$cmd" "${temp[@]}"
		$cmd "${temp[@]}"
		i=$[$i+1]
	done
	last=$[$n-1]
	if [[ $n -eq 0 ]] || [[ "${args[$last]}" == "$sep" ]]; then
		$verbose && echo '$' "$cmd"
		$cmd
	fi
}
