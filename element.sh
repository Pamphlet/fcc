#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# number = has only digits
# symbol = has only 1-2 letters
# name = anything else

ERROR_OUT() {
  if [[ $1 ]]
  then
    echo $1
  else
    echo "Encountered an error."
  fi
}

PARSE_QUERY() {
  if [[ -z $1 ]]
  then
    ERROR_OUT "I could not find that element in the database."
  else
    local IFS='|'
    read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE < <(echo "$1")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  fi
}

if [[ -z $1 ]]
then
  ERROR_OUT "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
  PARSE_QUERY $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
then
  PARSE_QUERY $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'")
else
  PARSE_QUERY $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'")
fi
