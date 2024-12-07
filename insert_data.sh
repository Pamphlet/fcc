#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
$PSQL "TRUNCATE TABLE games, teams"

cat ./games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # insert winner team if not listed already
    WINNER_INSERT_STATUS="$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")"
    if [[ $WINNER_INSERT_STATUS == "" ]]
    then
      WINNER_INSERT="$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
    fi

    # insert loser team if not listed already
    OPPONENT_INSERT_STATUS="$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")"
    if [[ $OPPONENT_INSERT_STATUS == "" ]]
    then
      OPPONENT_INSERT="$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
    fi

    # get winner ID
    WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"

    # get loser ID
    OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"

    # insert match details
    MATCH_INSERT_STATUS="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"
  fi
done
