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

function USER_WELCOME(){
  
  if [[ $PLAYER_EXISTS == '1' ]]
  then
    RETRIEVE_PLAYER_STATS $INPUT_USERNAME
    echo "Welcome back, $INPUT_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  else
    echo "Welcome, $INPUT_USERNAME! It looks like this is your first time here."
    INSERT_NEW_PLAYER $INPUT_USERNAME
  fi

}

function CHECK_GAME_CONDITION(){

  if ! [[ $GUESS =~ $re_numeric ]]
  then
    echo "That is not an integer, guess again:"
  elif (( $GUESS < $SECRET_NUM))
  then
    echo "It's higher than that, guess again:"
  elif (( $GUESS > $SECRET_NUM))
  then 
    echo "It's lower than that, guess again:"
  else
    echo "You guessed it in $TOTAL_GUESSES tries. The secret number was $SECRET_NUM. Nice job!"
    UPDATE_IF_BEST_GAME
  fi

}


re_numeric="^[0-9]{1,4}$"
SECRET_NUM=$(( $RANDOM % 1001 ))
TOTAL_GUESSES=0

INPUT_USER_PLAYERNAME
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