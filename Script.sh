#!/bin/bash

PlayersVictory() {
	printf "\nВы победили!"
	exit
}


CompVictory() {
	printf "\nКомпьютер победил!"
	exit
}

Randomize() {
	lowerRange=20
	upperRange=26
	randomNumber=$(( RANDOM * ( upperRange - lowerRange) / 32767 + lowerRange ))
	return $randomNumber
}

RandomizeComputer() {
	lowerRange=1
	upperRange=4
	rand=$(( RANDOM * ( upperRange - lowerRange) / 32767 + lowerRange ))
	return $rand
}

Repeat() {
	char='|'
	count=$1
	printf -v myString '%*s' "$count"
	printf '%s\n' "${myString// /$char}"
}

Randomize
cnt=$?
IsPlayersTurn="true"
nothing=''

game() {
if [ $IsPlayersTurn = "true" ]
then
	printf "\nВаш ход!"
	echo ""
	echo $(Repeat $cnt)
	read -t 3 -p "Сколько палочек вы хотите забрать?: " cm
	cmid=$cm
	if [[ -z $cmid ]]
	then
		printf "\nВы привысили максимальное время ожидания, победа засчитана компьютеру!"
		exit
	fi
	case $cmid in
		"1")
			printf "\nВы решили забрать 1 палочку"
			cnt=$((cnt-1))
			;;
		"2")
			printf "\nВы решили забрать 2 палочки"
			cnt=$((cnt-2))
			;;
		"3")
			printf "\nВы решили забрать 3 палочки"
			cnt=$((cnt-3))
			;;
		*)
			printf "\nВы совершили невозможное действие, победа засчитана компьютеру"
			exit
			;;
	esac
	if [ $cnt -le 0 ]
	then
		PlayersVictory
		break
	fi
	printf "\n"
	echo $(Repeat $cnt)
	IsPlayersTurn="False"
	game
else
	printf "\nХод компьютера!"
	sleep 3
	echo ""
	CompTurnRand=$(RandomizeComputer)
	CompTurn=$?
	if  [ $CompTurn = "1" ]
	then
		printf "\nКомпьютер решил забрать 1 палочку"
	else
		printf "\nКомпьютер решил забрать $CompTurn палочки"
	fi
	cnt=$((cnt-CompTurn))
	printf "\n"
	echo $(Repeat $cnt)
	if [ $cnt -le 0 ]
	then
		CompVictory
		break
	fi
	IsPlayersTurn="true"
	sleep 2
	game
fi
}

game
