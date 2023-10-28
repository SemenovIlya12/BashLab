#!/bin/bash

pal=$((RANDOM % 6 + 20))
echo "Number of sticks: $pal"
for ((i=0; i<$pal; i++))
do
echo -n "|"
done
echo

while [ $pal -gt 0 ]
do
    read -t 3 -p "Enter the number of sticks you want to take (1-3): " a
    if [ "$a" == "" ]
    then
        echo "Times up. Computer wins\n"
        exit
    fi
    if [ $a -ge 1 ] && [ $a -le 3 ]
    then
        if [ "$a" != "" ]
        then
            if [ $((pal-a)) -gt 0 ]
            then
                pal=$((pal-a))
                result=$(printf "|%.0s" $(seq 1 $pal))
                echo "Player takes $a sticks. Current count: $pal"
                echo "$result"
                echo
                n=$((RANDOM % 2 + 1))
                if [ $((pal-n)) -ge 0 ]
                then
                    pal=$((pal-n))
                    result=$(printf "|%.0s" $(seq 1 $pal))
                    echo "Computer takes $n sticks. Current count: $pal"
                    if [ $pal -ne 0 ]
                    then
                        echo "$result"
                        echo
                    else
                        continue
                fi
            else
                pal=0
                echo "No more sticks left. Computer wins."
                exit
            fi
            elif [ $pal -eq 0 ]
            then
                echo "No more sticks left. Player wins."
                exit
            else
                echo "No more sticks left. Player wins."
                exit
            fi
        else
            echo "Time's up. Computer wins."
            exit
        fi
    else
        echo "Invalid move. Computer wins."
        exit
    fi
done
