#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\n~~~~~ MY SALON ~~~~~\n"

  echo -e "Welcome to My Salon, how can I help you?"

  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$SERVICES" | while read ID BAR NAME
  do
    echo "$ID) $NAME"
  done
  read SERVICE_ID_SELECTED

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
  SERVICE_NAME=$(echo "$SERVICE_NAME" | sed -s -E 's/^ *| *$//g')

  if [[ -z $SERVICE_NAME ]]
  then
    MAIN_MENU "I Could not find that service. What would you like today?"
  else
    GET_CUSTOMER_INFO
  fi
}

GET_CUSTOMER_INFO() {
echo -e "\nPlease put your phone number here:"
read CUSTOMER_PHONE

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
CUSTOMER_ID=$(echo "$CUSTOMER_ID" | sed -s -E 's/^ *| *$//g')

if [[ -z $CUSTOMER_ID ]]
then
  echo -e "\nYou are a new customer! Please insert your name:"
  read CUSTOMER_NAME

  INSERT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  CUSTOMER_ID=$(echo "$CUSTOMER_ID" | sed -s -E 's/^ *| *$//g')
  else
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID")
  CUSTOMER_NAME=$(echo "$CUSTOMER_NAME" | sed -E 's/^ *| *$//g')
fi

SCHEDULE_APPOINTMENT
 
}

SCHEDULE_APPOINTMENT(){
  echo -e "\nWhat time would you like to $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}


MAIN_MENU