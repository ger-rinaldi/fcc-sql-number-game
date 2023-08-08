#! /bin/bash

PSQL="psql -U freecodecamp -d number_guess --tuples-only --no-align -c"


re_numeric="^[0-9]{1,4}$"
SECRET_NUM=$(( $RANDOM % 1001 ))
TOTAL_GUESSES=0

INPUT_USER_PLAYERNAME
#NAME_TO_UPPERCASE
CHECK_PLAYER_EXISTS $INPUT_USERNAME
USER_WELCOME


echo "Guess the secret number between 1 and 1000:"

until (( GUESS == $SECRET_NUM ))
do
  read GUESS
  (( TOTAL_GUESSES++ ))
  CHECK_GAME_CONDITION

done

INCREMENT_GAMES_PLAYED