#!/bin/bash

# salon

PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

MAIN_MENU()
{
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "\nWelcome to our salon. Please select from one of the following services:"
  echo "$($PSQL "SELECT * FROM services")" | while IFS='|' read ID SERVICE
  do
    echo "$ID) $SERVICE"
  done

  SELECT_SERVICE
}

SELECT_SERVICE()
{
  echo -e "\nSelect a service:"
  read SERVICE_ID_SELECTED

  CHECK_IF_NUMBER $SERVICE_ID_SELECTED
}

CHECK_IF_NUMBER()
{
  SERVICE_ID_SELECTED=$1

  # check if the ID is a number
  REGEX_NUMBER='^[0-9]+$'
  if ! [[ $SERVICE_ID_SELECTED =~ $REGEX_NUMBER ]]
  then
    # if not, return to main menu
    MAIN_MENU "That is not a number. Please try again."
  else
    CHECK_IF_SERVICE $SERVICE_ID_SELECTED
  fi
}

CHECK_IF_SERVICE()
{
  SERVICE_ID_SELECTED=$1

  SERVICE_NAME_SELECTED="$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")"
  # check if there is a service with that number
  if [[ -z $SERVICE_NAME_SELECTED ]]
  then
    # if not, return to main menu
    MAIN_MENU "That is not a valid service. Please try again."
  else
    echo -e "\nYou selected the following service: $SERVICE_NAME_SELECTED."
    REGISTER_APPOINTMENT $SERVICE_ID_SELECTED $SERVICE_NAME_SELECTED
  fi
}

REGISTER_APPOINTMENT()
{
  SERVICE_ID_SELECTED=$1
  SERVICE_NAME_SELECTED=$2

  # get phone number
  echo -e "\nEnter your phone number:"
  read CUSTOMER_PHONE

  CUSTOMER_ID="$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")"

  # if no customer with said phone number exists
  if [[ -z $CUSTOMER_ID ]]
  then
    # ask for name
    echo -e "\nYou're a new customer. Enter your name:"
    read CUSTOMER_NAME

    # create customer
    NEW_CUSTOMER_STATUS="$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$NAME')")"
    CUSTOMER_ID="$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")"
  else
    CUSTOMER_NAME="$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID")"
  fi

  # get requested time
  echo -e "\nEnter your desired appointment time:"
  read SERVICE_TIME

  NEW_APPOINTMENT_STATUS="$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")"

  echo -e "\nI have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
}

# ---

echo -e "\n~~~ SALON ~~~"

MAIN_MENU 
