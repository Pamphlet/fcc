#!/bin/bash

# generate a random number from 1 to 1000
# ask the user to guess it
# discard bad input with clear error messages
# tell the user if their guess is too low or too high
# track the number of guesses needed
# report said number of guesses after winning
# use a database to store each user (by their username), the number of games they've played and their best number of guesses thus far
# ask for username upon startup
# if user is new, create an entry for them and greet them accordingly before starting a new session
# if they're not new, greed them accordingly and report the aforementioned stats before starting a new session

PSQL="psql --username=freecodecamp --dbname=guesses -t --no-align -c"

RANDOM() {
  echo $((1 + $RANDOM % 1000))
}

VALIDATE_INPUT() {
  if ! [[ -z $1 ]]
  then
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      echo $1
    fi
  fi
}

NUMBER=$(RANDOM)

echo "Enter your username:"
read USER_NAME

CHECK_USER_STATUS=$($PSQL "SELECT * FROM guesses WHERE name='$USER_NAME'")

if [[ -z $CHECK_USER_STATUS ]]
then
  echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
  ADD_USER_STATUS=$($PSQL "INSERT INTO guesses(name) VALUES('$USER_NAME')")
else
  OLD_IFS=$IFS
  IFS='|'
  read ID USER_NAME BEST_GAME GAMES_PLAYED < <(echo "$CHECK_USER_STATUS")
  echo -e "\nWelcome back, $USER_NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  IFS=$OLD_IFS
fi

echo -e "\nGuess the secret number between 1 and 1000:"

TOTAL_GUESSES=0

while [[ $NUMBER != $GUESS ]]
do
  read -r GUESS
  ((TOTAL_GUESSES++))

  GUESS=$(VALIDATE_INPUT $GUESS)

  if [[ -z $GUESS ]]
  then
    echo "That is not an integer, guess again:"
  elif [ $NUMBER -lt $GUESS ]
  then
    echo "It's lower than that, guess again:"
  elif [ $NUMBER -gt $GUESS ]
  then
    echo "It's higher than that, guess again:"
  else
    echo -e "\nYou guessed it in $TOTAL_GUESSES tries. The secret number was $NUMBER. Nice job!"
    
    CHECK_USER_STATUS=$($PSQL "SELECT * FROM guesses WHERE name='$USER_NAME'")
    OLD_IFS=$IFS # without this, the final update fails
    IFS='|'
    read ID USER_NAME BEST_GAME GAMES_PLAYED < <(echo "$CHECK_USER_STATUS")
    ((GAMES_PLAYED++))
    if [[ "$BEST_GAME" -eq 0 || "$BEST_GAME" -gt "$TOTAL_GUESSES" ]];
    then
      BEST_GAME=$TOTAL_GUESSES
    fi

    IFS=$OLD_IFS
    UPDATE_USER_STATUS=$($PSQL "UPDATE guesses SET games_played = $GAMES_PLAYED, best_game = $BEST_GAME WHERE id = $ID")
  fi
done
