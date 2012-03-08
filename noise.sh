#!/bin/bash -e

function die() {
	echo $1 >&2
	exit 0
}

[[ -x $(which play) ]] || die "sox must be installed"

if [ $# -gt 0 ]; then
	if [ $1 == "pink" ]; then
		play -t sl -r48000 -c2 - synth -1 pinknoise .1 40  < /dev/zero
		exit 0
	elif [ $1 == "space" ]; then
		play -c2 -n synth whitenoise band -n 100 24 band -n 300 100 gain +30
		exit 0
	fi
fi

echo "Usage: $0 (pink|space)"
