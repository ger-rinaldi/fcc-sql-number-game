#! /bin/bash

PSQL="psql -U freecodecamp -d number_guess --tuples-only --no-align -c"

function INPUT_USER_PLAYERNAME(){

  echo "Enter your username:"
  read INPUT_USERNAME

}

function CHECK_PLAYER_EXISTS(){

  local USERNAME=$1

  PLAYER_EXISTS=$($PSQL "SELECT 1 FROM players WHERE name = '$USERNAME'")

}

function INSERT_NEW_PLAYER(){

  local USERNAME=$1

  INSERT_RESULT=$($PSQL "INSERT INTO players(name) VALUES ('$USERNAME')")

}

function RETRIEVE_PLAYER_STATS(){

  local USERNAME=$1

  GAMES_PLAYED=$($PSQL "SELECT games_played FROM players WHERE name = '$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM players WHERE name = '$USERNAME'")

}

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